//
//  JPPhotoShowController.h
//  JPPhotoBrowserDemo
//

#import <UIKit/UIKit.h>

@protocol JPPhotoShowControllerDelegate <NSObject>
/**
 * 单击图片 退出浏览
 */
- (void)showControllerDidTapImageExitShowImage;
/**
 * 手指滑动图片 判断此时是否可以滑动pageViewController
 * @param canScroll canScroll
 */
- (void)showControllerDidMoveImageCanScrollPageController:(BOOL)canScroll;
/**
 * 手指滑动图片中 改变pageViewController的背景透明度
 * @param alpha canScroll
 */
- (void)showControllerDidMoveImagePageControllerBackViewAlpha:(CGFloat)alpha;

@end


//负责单张照片的显示的控制器
@interface JPPhotoShowController : UIViewController

- (instancetype)initWithImageData:(id)imageData placeholderImage:(UIImage *)placeholderImage selectedIndex:(NSInteger)index backViewColor:(UIColor *)backViewColor;

/** 大图 */
@property(nonatomic,strong) id imageData;

/** 占位图 */
@property(nonatomic,strong) UIImage *placeholderImage;

/** 当前点击的序号 */
@property(nonatomic,assign) NSInteger  selectIndex;

/** 当前显示图片的View */
@property(nonatomic,strong) UIImageView *showImageView;

/** scroll maxMargin exit show image default 60 */
@property(nonatomic,assign) CGFloat scrollMaxMargin;

/** delegate */
@property(nonatomic,assign) id<JPPhotoShowControllerDelegate> delegate;


@end
