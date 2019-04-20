//
//  JPPhotoBrowserController.h
//  JPPhotoBrowserDemo
//

#import <UIKit/UIKit.h>

typedef void(^SelectedSaveImageCompletion)(UIImage *image);

//负责多张照片的显示的控制器  负责照片交互
@interface JPPhotoBrowserController : UIViewController

- (instancetype)initWithImageDatas:(NSArray *)imageDatas
                        imageViews:(NSArray <UIImageView *>*)imageBackViews
                             index:(NSInteger)currentImageIndex
                        completion:(SelectedSaveImageCompletion)completion;

/** completion */
@property(nonatomic,copy) SelectedSaveImageCompletion completion;

- (void)setPageViewController;

/****** 配置 ******/

/** backViewColor default black */
@property(nonatomic,strong) UIColor *backViewColor;

/** isShowTopIndex default YES */
@property(nonatomic,assign) BOOL isShowTopIndex;

/** isHiddenTopIndexOnlyOne */
@property(nonatomic,assign) BOOL isHiddenTopIndexOnlyOne;

/** currentIndexColor default red */
@property(nonatomic,strong) UIColor *currentIndexColor;

/** totalIndexColor default white */
@property(nonatomic,strong) UIColor *totalIndexColor;

/** currentIndexFontSize default bold 20 */
@property(nonatomic,strong) UIFont *currentIndexFontSize;

/** totalIndexFontSize default bold 17 */
@property(nonatomic,strong) UIFont *totalIndexFontSize;

/** middleString default '/' */
@property(nonatomic,strong) NSString *middleString;

/** isShowSaveImage default NO */
@property(nonatomic,assign) BOOL isShowSaveImage;

/** saveImage default nil */
@property(nonatomic,strong) UIImage *saveImage;

/** scroll maxMargin exit show image default 60 */
@property(nonatomic,assign) CGFloat scrollMaxMargin;

@end
