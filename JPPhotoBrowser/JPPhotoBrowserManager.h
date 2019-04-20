//
// Created by peng on 2019-04-19.
// Copyright (c) 2019 dongjiangpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedSaveImageCompletion)(UIImage *image);

@interface JPPhotoBrowserManager : NSObject

+ (instancetype)defaultPhotoBrowserManager;

/** completion */
@property(nonatomic,copy) SelectedSaveImageCompletion completion;

- (UIViewController *)getPhotoBrowserController;

/**
 show photo images/index/delegate 没有转场动画

 @param imageDatas 图片数据(NSString/NSURL/UIImage)
 @param currentImageIndex 当前索引
 @param currentController 当前控制器(self)
 */
- (void)showPhotoNoTransitionWithImageDatas:(NSArray *)imageDatas
                                      index:(NSInteger)currentImageIndex
                                 controller:(UIViewController *)currentController;

/**
 show photo images/index/delegate 没有转场动画

 @param imageDatas 图片数据(NSString/NSURL/UIImage)
 @param currentImageIndex 当前索引
 @param currentController 当前控制器(self)
 @param completion completion
 */
- (void)showPhotoNoTransitionWithImageDatas:(NSArray *)imageDatas
                                      index:(NSInteger)currentImageIndex
                                 controller:(UIViewController *)currentController
                                 completion:(SelectedSaveImageCompletion)completion;

/**
 show photo images/views/index/delegate/currentController 带转场动画

 @param imageDatas 图片数据(NSString/NSURL/UIImage)
 @param imageBackViews 小图所在的UIImageView集合->标记转场动画的起始位置
 @param currentImageIndex 当前索引
 @param currentController 当前控制器(self)
 */
- (void)showPhotoWithImageDatas:(NSArray *)imageDatas
                     imageViews:(NSArray <UIImageView *>*)imageBackViews
                          index:(NSInteger)currentImageIndex
                     controller:(UIViewController *)currentController;

/**
 show photo images/views/index/delegate/currentController 带转场动画

 @param imageDatas 图片数据(NSString/NSURL/UIImage)
 @param imageBackViews 小图所在的UIImageView集合->标记转场动画的起始位置
 @param currentImageIndex 当前索引
 @param currentController 当前控制器(self)
 @param completion completion
 */
- (void)showPhotoWithImageDatas:(NSArray *)imageDatas
                     imageViews:(NSArray <UIImageView *>*)imageBackViews
                          index:(NSInteger)currentImageIndex
                     controller:(UIViewController *)currentController
                     completion:(SelectedSaveImageCompletion)completion;

/**
 show photo images/views/index/transition/delegate/currentController 带转场动画

 @param imageDatas 图片数据(NSString/NSURL/UIImage)
 @param imageBackViews 小图所在的UIImageView集合->标记转场动画的起始位置
 @param currentImageIndex 当前索引
 @param showTransition 转场动画
 @param currentController 当前控制器(self)
 @param completion completion
 */
- (void)showPhotoWithImageDatas:(NSArray *)imageDatas
                     imageViews:(NSArray <UIImageView *>*)imageBackViews
                          index:(NSInteger)currentImageIndex
                 showTransition:(BOOL)showTransition
                     controller:(UIViewController *)currentController
                     completion:(SelectedSaveImageCompletion)completion;


/****** 配置 ******/

/** backViewColor default black */
@property(nonatomic,strong) UIColor *backViewColor;

/** isShowTopIndex default YES */
@property(nonatomic,assign) BOOL isShowTopIndex;

/** isHiddenTopIndexOnlyOne default YES */
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
