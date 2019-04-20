//
//  JPPhotoBrowserController.m
//  JPPhotoBrowserDemo
//

#import "JPPhotoBrowserController.h"
#import "JPPhotoShowController.h"
#import "JPPhotoBrowserAnimator.h"
#import "UIView+JPLayout.h"

@interface JPPhotoBrowserController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource,JPPhotoShowControllerDelegate,UIScrollViewDelegate>

/** JPPhotoBrowserAnimator *animator */
@property(nonatomic,strong) JPPhotoBrowserAnimator *animator;

/** 大图 */
@property(nonatomic,strong) NSArray *imageDatas;

/** imageBackViews */
@property(nonatomic,strong) NSArray <UIImageView *>*imageBackViews;

/** 当前点击的图片序号 */
@property(nonatomic,assign) NSInteger currentImageIndex;

/** topIndexLabel */
@property(nonatomic,strong) UILabel *topIndexLabel;

/** saveImageButton */
@property(nonatomic,strong) UIButton *saveImageButton;

/** pageViewController */
@property(nonatomic,strong) UIPageViewController *pageViewController;

/** scrollView */
@property(nonatomic,strong) UIScrollView *scrollView;

/** currentPhotoShowController */
@property(nonatomic,strong) JPPhotoShowController *currentPhotoShowController;

@end

@implementation JPPhotoBrowserController

- (instancetype)initWithImageDatas:(NSArray *)imageDatas imageViews:(NSArray <UIImageView *>*)imageBackViews index:(NSInteger)currentImageIndex completion:(SelectedSaveImageCompletion)completion {

    if (imageDatas.count) {

        self = [super init];
        if (self) {
            //回调
            self.completion = completion;
            //图片数据
            self.imageDatas = imageDatas;
            //当前查看的图片索引
            self.currentImageIndex = currentImageIndex;
            //转场背景色
            self.animator.backViewColor = self.backViewColor;
            
            if (imageBackViews.count) {
                //只有存在底图才+自定义转场
                self.transitioningDelegate = self.animator;
                //底图和图片一一对应
                if (imageBackViews.count == imageDatas.count) {
                    self.imageBackViews = imageBackViews;
                }
                //底图个数小于图片个数,不一一对应(banner/展示部分图片)
                if (imageBackViews.count < imageDatas.count) {
                    NSMutableArray *imageBackViewsM = [NSMutableArray array];
                    for (NSInteger i = 0; i < imageDatas.count; i++) {
                        if (i < imageBackViews.count-1) {
                            [imageBackViewsM addObject:imageBackViews[i]];
                        } else {
                            [imageBackViewsM addObject:imageBackViews[imageBackViews.count-1]];
                        }
                    }
                    self.imageBackViews = [imageBackViewsM copy];
                }
                //底图个数大于图片个数,不一一对应(bug^_^)
                if (imageBackViews.count > imageDatas.count) {
                    NSMutableArray *imageBackViewsM = [NSMutableArray array];
                    for (NSInteger i = 0; i < imageDatas.count; i++) {
                        [imageBackViewsM addObject:imageBackViews[i]];
                    }
                    self.imageBackViews = [imageBackViewsM copy];
                }
                //转场的默认图
                self.animator.animationImageView = self.imageBackViews[self.currentImageIndex];
            }
        }
        return self;
    }

    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/** 设置分页控制器 */
- (void)setPageViewController {

    //UIPageViewControllerTransitionStyleScroll滑动换页  UIPageViewControllerNavigationOrientationHorizontal横向滚动  UIPageViewControllerOptionInterPageSpacingKey页间距
    UIPageViewController *pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:@{UIPageViewControllerOptionInterPageSpacingKey:@20}];
    self.pageViewController = pageViewController;

    JPPhotoShowController *showController = [[JPPhotoShowController alloc] initWithImageData:self.imageDatas[self.currentImageIndex] placeholderImage:self.imageBackViews[self.currentImageIndex].image selectedIndex:self.currentImageIndex backViewColor:self.backViewColor];
    self.currentPhotoShowController = showController;
    showController.delegate = self;
    showController.scrollMaxMargin = self.scrollMaxMargin;
    //设置show为page的子控制器
    [pageViewController setViewControllers:@[showController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    self.animator.currentImageView = showController.showImageView;

    //将分页控制器添加为当前的子控制器
    [self.view addSubview:pageViewController.view];
    [self addChildViewController:pageViewController];
    [pageViewController didMoveToParentViewController:self];

    //代理
    pageViewController.delegate = self;
    pageViewController.dataSource = self;

    //设置手势
    self.view.gestureRecognizers = pageViewController.gestureRecognizers;

    //顶部提示
    [self.view addSubview:self.topIndexLabel];

    //保存
    [self.view addSubview:self.saveImageButton];
    
    self.view.backgroundColor = self.backViewColor;
    self.animator.backViewColor = self.backViewColor;

    self.topIndexLabel.hidden = !self.isShowTopIndex;
    if (self.isShowTopIndex) {
        [self p_SetTopIndexLabelText:self.currentImageIndex];
        if (self.isHiddenTopIndexOnlyOne && self.imageDatas.count <= 1) {
            self.topIndexLabel.hidden = YES;
        } else {
            self.topIndexLabel.hidden = NO;
        }
    }

    self.saveImageButton.hidden = !self.isShowSaveImage;
    if (self.isShowSaveImage) {
        [self.saveImageButton setImage:self.saveImage forState:UIControlStateNormal];
        [self.saveImageButton setImage:self.saveImage forState:UIControlStateHighlighted];
    }

}

/**
 返回前一页控制器

 @param pageViewController pageViewController description
 @param viewController 当前显示的控制器
 @return 返回前一页控制器 返回Nil 就是到头了
 */
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    //取出当前控制器的序号
    JPPhotoShowController *currentCtrl = (JPPhotoShowController *)viewController;
    NSInteger index = currentCtrl.selectIndex;
    //判断是否已经滑动到最前面一页
    if (index <= 0) {
        return nil;
    }
    index --;
    JPPhotoShowController *beforeCtrl = [[JPPhotoShowController alloc] initWithImageData:self.imageDatas[index] placeholderImage:self.imageBackViews[index].image selectedIndex:index backViewColor:self.backViewColor];
    beforeCtrl.delegate = self;
    beforeCtrl.scrollMaxMargin = self.scrollMaxMargin;
    return beforeCtrl;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    //取出当前控制器的序号
    JPPhotoShowController *currentCtrl = (JPPhotoShowController *)viewController;
    NSInteger index = currentCtrl.selectIndex;
    //判断是否已经滑动到最后面一页
    if (index >= self.imageDatas.count-1) {
        return nil;
    }
    index ++;
    JPPhotoShowController *afterCtrl = [[JPPhotoShowController alloc] initWithImageData:self.imageDatas[index] placeholderImage:self.imageBackViews[index].image selectedIndex:index backViewColor:self.backViewColor];
    afterCtrl.delegate = self;
    afterCtrl.scrollMaxMargin = self.scrollMaxMargin;
    return afterCtrl;

}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    // viewControllers[0] 是当前显示的控制器，随着分页控制器的滚动，调整数组的内容次序
    // 始终保证当前显示的控制器的下标是 0
    // 一定注意，不要使用 childViewControllers
    
    JPPhotoShowController *showController = (JPPhotoShowController *)pageViewController.viewControllers[0];
    self.currentPhotoShowController = showController;
    self.currentImageIndex = showController.selectIndex;
    
    //提示
    [self p_SetTopIndexLabelText:self.currentImageIndex];
}

/**
 单击图片 退出浏览
 */
- (void)showControllerDidTapImageExitShowImage {
    
    //退出时一定要给转场代理重新赋值当前的图片
    self.animator.animationImageView = self.imageBackViews[self.currentImageIndex];
    self.animator.currentImageView = self.currentPhotoShowController.showImageView;
    self.animator.backViewColor = self.view.backgroundColor;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showControllerDidMoveImagePageControllerBackViewAlpha:(CGFloat)alpha {
    
    self.view.backgroundColor = [self.backViewColor colorWithAlphaComponent:alpha];
}

- (void)showControllerDidMoveImageCanScrollPageController:(BOOL)canScroll {
    
    self.scrollView.scrollEnabled = canScroll;
    if (canScroll) {
        self.saveImageButton.hidden = !self.isShowSaveImage;
        self.topIndexLabel.hidden = !self.isShowTopIndex;
        if (self.isShowTopIndex) {
            [self p_SetTopIndexLabelText:self.currentImageIndex];
            if (self.isHiddenTopIndexOnlyOne && self.imageDatas.count <= 1) {
                self.topIndexLabel.hidden = YES;
            } else {
                self.topIndexLabel.hidden = NO;
            }
        }

    } else {
        self.topIndexLabel.hidden = self.saveImageButton.hidden = YES;
    }
}

/** 设置顶部提示 */
- (void)p_SetTopIndexLabelText:(NSInteger)currentIndex {

    NSInteger allCount = self.imageDatas.count;

    NSString *currentIndexString = [NSString stringWithFormat:@"%zd",currentIndex+1];
    NSString *middleString = [NSString stringWithFormat:@" %@ ",self.middleString];
    NSString *totalIndexString = [NSString stringWithFormat:@"%zd",allCount];

    NSString *topIndexString = [NSString stringWithFormat:@"%@%@%@",currentIndexString,middleString,totalIndexString];

    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:topIndexString];

    [attributedStr addAttributes:@{NSForegroundColorAttributeName:self.currentIndexColor,NSFontAttributeName:self.currentIndexFontSize} range:NSMakeRange(0, currentIndexString.length)];
    [attributedStr addAttributes:@{NSForegroundColorAttributeName:self.totalIndexColor,NSFontAttributeName:self.totalIndexFontSize} range:NSMakeRange(currentIndexString.length, topIndexString.length-currentIndexString.length)];

    self.topIndexLabel.attributedText = attributedStr;
}

/** 保存图片 */
- (void)p_SaveImage {
    
    if (self.completion) {
        if (self.currentPhotoShowController.showImageView.image) {
            self.completion(self.currentPhotoShowController.showImageView.image);
        }
    } else {
        NSLog(@"未设置browser completion");
    }
}

- (JPPhotoBrowserAnimator *)animator{

    if (!_animator) {

        _animator = [[JPPhotoBrowserAnimator alloc] init];
    }
    return _animator;
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        
        _scrollView = [self findScrollView];
    }
    return _scrollView;
}

- (UIScrollView *)findScrollView {
    
    UIScrollView *scrollView = nil;
    for(UIView *subview in self.pageViewController.view.subviews) {
        if([subview isKindOfClass:[UIScrollView class]]) {
            scrollView = (UIScrollView *)subview;
            break;
        }
    }
    return scrollView;
}

- (UILabel *)topIndexLabel {
    
    if (!_topIndexLabel) {
        
        _topIndexLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT+10, self.view.bounds.size.width, 25)];
        _topIndexLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _topIndexLabel;
}

- (UIButton *)saveImageButton {
    
    if (!_saveImageButton) {
        
        _saveImageButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width-32-16, self.view.bounds.size.height-BOTTOM_MARGIN(16+32), 32, 32)];
        [_saveImageButton addTarget:self action:@selector(p_SaveImage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveImageButton;
}


@end
