//
//  JPPhotoShowController.m
//  JPPhotoBrowserDemo
//

#import "JPPhotoShowController.h"
#import "UIView+JPLayout.h"
#import "UIImageView+WebCache.h"

static const CGFloat kDefaultAnimationDurationTime = 0.25;
static const CGFloat kMinAlpha = 0.3;

@interface JPPhotoShowController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

/** backViewColor */
@property(nonatomic,strong) UIColor *backViewColor;
/** screenWidth */
@property(nonatomic,assign) CGFloat screenWidth;
/** screenHeight */
@property(nonatomic,assign) CGFloat screenHeight;
/** scroll */
@property(nonatomic,strong) UIScrollView *scrollView;
/** moveImageView */
@property(nonatomic,strong) UIImageView *moveImageView;
/** beginMovePoint */
@property(nonatomic,assign) CGPoint beginMovePoint;
/** lastMovePoint */
@property(nonatomic,assign) CGPoint lastMovePoint;
/** isZoom */
@property(nonatomic,assign) BOOL isZoom;
/** isDragging */
@property(nonatomic,assign) BOOL isDragging;
/** isScrollDown */
@property(nonatomic,assign) BOOL isScrollDown;
/** isRebound */
@property(nonatomic,assign) BOOL isRebound;

@end

@implementation JPPhotoShowController


- (instancetype)initWithImageData:(id)imageData placeholderImage:(UIImage *)placeholderImage selectedIndex:(NSInteger)index backViewColor:(UIColor *)backViewColor {
    
    self = [super init];
    if (self) {
        self.imageData = imageData;
        self.placeholderImage = placeholderImage;
        self.selectIndex = index;
        self.backViewColor = backViewColor;
        
        [self p_SetUI];
        [self p_DownLoadImage];
    }
    return self;
}

/** 设置图片显示 */
- (void)p_SetUI {
    
    self.view.backgroundColor = self.backViewColor;
    [self.view addSubview:self.scrollView];
    
    self.scrollView.frame = self.view.bounds;
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = 1;
    self.scrollView.maximumZoomScale = 2;
    self.scrollView.alwaysBounceVertical = YES;//开启上下回弹
    self.scrollView.alwaysBounceHorizontal = YES;
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }

    [self.scrollView addSubview:self.showImageView];
    
    [self p_SetImageSizeWithImage:self.placeholderImage scale:1];
    
    self.showImageView.userInteractionEnabled = YES;
    
    //添加单击 双击 手势
    UITapGestureRecognizer *oneTapImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p_OneTapImage)];
    oneTapImage.numberOfTapsRequired = 1;
    
    UITapGestureRecognizer *doubleTapImage = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p_DoubleTapImage:)];
    doubleTapImage.numberOfTapsRequired = 2;
    
    [oneTapImage requireGestureRecognizerToFail:doubleTapImage];
    
    [self.scrollView addGestureRecognizer:oneTapImage];
    [self.showImageView addGestureRecognizer:doubleTapImage];
}

/** 设置图片大小 */
- (void)p_SetImageSizeWithImage:(UIImage *)image scale:(CGFloat)scale {
    
    if (image) {

        //原图尺寸
        CGSize imageSize = image.size;
        //需要设置的尺寸
        CGSize size = CGSizeZero;
        size.width = self.screenWidth*scale;
        size.height = size.width *imageSize.height / imageSize.width;
        //设置图片位置
        self.showImageView.frame = CGRectMake(0, 0, size.width, size.height);
        self.scrollView.contentSize = size;
        //短图居中
        if (size.height < self.scrollView.jp_h*scale) {
            self.showImageView.jp_y = (self.scrollView.jp_h - size.height)*0.5;
            if (self.showImageView.jp_y < 0) {
                self.showImageView.jp_y = 0;
            }
        }
    }
}

/** 下载图片 */
- (void)p_DownLoadImage {
    
    if ([self.imageData isKindOfClass:[NSString class]]) {
        
        [self.showImageView sd_setImageWithURL:[NSURL URLWithString:(NSString *)self.imageData] placeholderImage:self.placeholderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (image) {
                [self p_SetImageSizeWithImage:image scale:1];
            }
        }];
    }
    
    if ([self.imageData isKindOfClass:[NSURL class]]) {
        
        [self.showImageView sd_setImageWithURL:(NSURL *)self.imageData placeholderImage:self.placeholderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (image) {
                [self p_SetImageSizeWithImage:image scale:1];
            }
        }];
    }
    
    if ([self.imageData isKindOfClass:[UIImage class]]) {
        
        self.showImageView.image = (UIImage *)self.imageData;
        [self p_SetImageSizeWithImage:(UIImage *)self.imageData scale:1];
    }
}

/** 单击图片 */
- (void)p_OneTapImage {
    
    if ([self.delegate respondsToSelector:@selector(showControllerDidTapImageExitShowImage)]) {
        [self.delegate showControllerDidTapImageExitShowImage];
    }
}

/** 双击 */
- (void)p_DoubleTapImage:(UITapGestureRecognizer *)tap {
    
    CGFloat scale = self.scrollView.zoomScale < 2 ? 2 : 1;
    
    [UIView animateWithDuration:kDefaultAnimationDurationTime animations:^{
        self.scrollView.zoomScale = scale;
        if (scale == 2) {
            //双击放大,居中显示
            if (self.scrollView.jp_h >= self.showImageView.jp_h) {
                self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x+self.scrollView.jp_w*0.5, self.scrollView.contentOffset.y);
            } else {
                //长图不处理Y
                if (self.showImageView.jp_h > 2*self.scrollView.jp_h) {
                    self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x+self.scrollView.jp_w*0.5, 0);
                } else {
                    //放大后比scrollView高,需要适配Y
                    self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x+self.scrollView.jp_w*0.5, (self.showImageView.jp_h-self.scrollView.jp_h)*0.5);
                }

            }
        }
    }];
}

#pragma mark - pan
- (void)p_PanImageView:(UIPanGestureRecognizer *)panGesture {
    
    if (panGesture.numberOfTouches !=  1) {
       //两个手指在拖，此时应该是在缩放，不执行继续执行
        self.beginMovePoint = CGPointZero;
        return;
    }

    if (self.isRebound) {
        return;
    }

    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.beginMovePoint = [panGesture locationInView:self.scrollView];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            //向下拖动
            self.isDragging = YES;
            self.showImageView.hidden = YES;
            self.moveImageView.frame = self.showImageView.frame;
            self.moveImageView.image = self.showImageView.image;
            self.moveImageView.hidden = NO;
            [self.view addSubview:self.moveImageView];
            
            CGPoint currentPoint = [panGesture locationInView:self.scrollView];

            self.isScrollDown = (currentPoint.y - self.lastMovePoint.y >= 0);

            self.lastMovePoint = currentPoint;

            if (self.beginMovePoint.x == 0 && self.beginMovePoint.y == 0) {
                self.beginMovePoint = currentPoint;
            }
            
            //代理通知不可以滑动
            if (self.delegate && [self.delegate respondsToSelector:@selector(showControllerDidMoveImageCanScrollPageController:)]) {
                [self.delegate showControllerDidMoveImageCanScrollPageController:NO];
            }
            
            if (currentPoint.y - self.beginMovePoint.y > self.screenHeight*0.5) {
                [self p_ExitShowImage];
                return;
            }
            
            CGFloat alpha = 1- (currentPoint.y - self.beginMovePoint.y) / (self.screenHeight*0.5);

            if (alpha > 1) {
                alpha = 1;
            }
            
            if (alpha < kMinAlpha) {
                alpha = kMinAlpha;
            }
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(showControllerDidMoveImagePageControllerBackViewAlpha:)]) {
                [self.delegate showControllerDidMoveImagePageControllerBackViewAlpha:alpha * 0.7];
            }
            self.view.backgroundColor = [self.backViewColor colorWithAlphaComponent:alpha*0.7];

            CGFloat scrollYScale = 1.3;
            if (self.showImageView.jp_h > self.screenHeight) {
                scrollYScale = 1.0;
            }
            if (self.showImageView.jp_h <= self.screenHeight*0.6) {
                scrollYScale = 1.5;
            }

            if (currentPoint.y > self.beginMovePoint.y) {
                //当前的y比起始的时候大
                self.moveImageView.jp_w = self.showImageView.jp_w*alpha;
                self.moveImageView.jp_h = self.showImageView.jp_h*alpha;
                self.moveImageView.jp_centerX = (currentPoint.x - self.beginMovePoint.x) + self.showImageView.jp_centerX;
                self.moveImageView.jp_centerY = (currentPoint.y - self.beginMovePoint.y)*scrollYScale + self.showImageView.jp_centerY;

                if (self.moveImageView.jp_centerY > self.screenHeight && self.showImageView.jp_h <= self.screenHeight) {
                    [self p_ExitShowImage];
                    return;
                }
            }
            else {
                //当前的Y比起始的时候还小，此时图片的大小保持原状
                self.moveImageView.jp_centerX = (currentPoint.x - self.beginMovePoint.x) + self.showImageView.jp_centerX;
                self.moveImageView.jp_centerY = (currentPoint.y - self.beginMovePoint.y)*scrollYScale + self.showImageView.jp_centerY;
                self.moveImageView.jp_size = self.showImageView.frame.size;
            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            self.beginMovePoint = CGPointZero;
        }
            break;
        case UIGestureRecognizerStatePossible:
        {
            self.beginMovePoint = CGPointZero;
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            self.beginMovePoint = CGPointZero;
        }
            break;
            
        default:
            break;
    }
}


//UIScrollViewDelegate
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    self.isZoom = (scrollView.zoomScale != 1);
    
    [self p_SetImageSizeWithImage:self.showImageView.image scale:scrollView.zoomScale];

}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return self.showImageView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (!self.isZoom) {
        //上下拖动
        CGFloat scrollY = scrollView.contentOffset.y;
        scrollView.contentOffset = CGPointMake(0, scrollY);
        
        if (scrollY < 0) {
            [self p_PanImageView:self.scrollView.panGestureRecognizer];

        } else {
            if (!self.isDragging) {

                if (self.showImageView.jp_h <= self.view.jp_h) {
                    scrollView.contentOffset = CGPointZero;
                }
            } else {
                [self p_PanImageView:self.scrollView.panGestureRecognizer];
            }
        }
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {

    if (!self.isZoom && self.isDragging) {

        self.isRebound = YES;

        CGFloat scrollY = scrollView.contentOffset.y;

        if (scrollY <= -self.scrollMaxMargin) {

            if (self.isScrollDown) {
                //手指离开屏幕的时候,如果是向下滑动的则退出浏览,否则恢复原状
                [self p_ExitShowImage];
            } else {
                [self p_ImageRestoredOriginal];
            }

        } else {

            [self p_ImageRestoredOriginal];
        }
    }
}

#pragma mark - end show image
- (void)p_ExitShowImage {

    self.showImageView = self.moveImageView;
    [self p_OneTapImage];
    self.isDragging = NO;
    self.isRebound = NO;
}

#pragma mark - restored original
- (void)p_ImageRestoredOriginal {

    self.isDragging = NO;
    [UIView animateWithDuration:kDefaultAnimationDurationTime animations:^{
        self.moveImageView.frame = self.showImageView.frame;
        self.view.backgroundColor = [UIColor blackColor];
        self.scrollView.contentOffset = CGPointZero;
    } completion:^(BOOL finished) {
        self.isRebound = NO;
        self.beginMovePoint = CGPointZero;
        self.showImageView.hidden = NO;
        self.moveImageView.hidden = YES;
        [self.moveImageView removeFromSuperview];
        if (self.delegate && [self.delegate respondsToSelector:@selector(showControllerDidMoveImagePageControllerBackViewAlpha:)]) {
            [self.delegate showControllerDidMoveImagePageControllerBackViewAlpha:1];
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(showControllerDidMoveImageCanScrollPageController:)]) {
            [self.delegate showControllerDidMoveImageCanScrollPageController:YES];
        }
    }];
}


//保证翻页时当前图片 恢复原大小
- (void)viewDidDisappear:(BOOL)animated {

    [super viewDidDisappear:animated];

    self.scrollView.zoomScale = 1;
}

- (UIScrollView *)scrollView {

    if (!_scrollView) {

        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

- (UIImageView *)showImageView {

    if (!_showImageView) {

        _showImageView = [[UIImageView alloc] init];;
    }
    return _showImageView;
}

- (UIImageView *)moveImageView {

    if (!_moveImageView) {

        _moveImageView = [[UIImageView alloc] init];
    }
    return _moveImageView;
}

- (CGFloat)screenWidth {
    
    return [UIScreen mainScreen].bounds.size.width;
}

- (CGFloat)screenHeight {
    
    return [UIScreen mainScreen].bounds.size.height;
}

@end
