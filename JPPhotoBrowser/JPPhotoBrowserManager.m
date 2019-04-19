//
// Created by peng on 2019-04-19.
// Copyright (c) 2019 dongjiangpeng. All rights reserved.
//
#import "JPPhotoBrowserManager.h"
#import "JPPhotoBrowserController.h"

@implementation JPPhotoBrowserManager

+ (instancetype)defaultPhotoBrowserManager {

    return [[JPPhotoBrowserManager alloc] init];
}

- (void)showPhotoNoTransitionWithImageDatas:(NSArray *)imageDatas index:(NSInteger)currentImageIndex controller:(UIViewController *)currentController {

    [self showPhotoNoTransitionWithImageDatas:imageDatas index:currentImageIndex controller:currentController completion:nil];
}

- (void)showPhotoNoTransitionWithImageDatas:(NSArray *)imageDatas index:(NSInteger)currentImageIndex controller:(UIViewController *)currentController completion:(SelectedSaveImageCompletion)completion {

    [self showPhotoWithImageDatas:imageDatas imageViews:@[] index:currentImageIndex controller:currentController completion:completion];
}

- (void)showPhotoWithImageDatas:(NSArray *)imageDatas imageViews:(NSArray <UIImageView *> *)imageBackViews index:(NSInteger)currentImageIndex controller:(UIViewController *)currentController {

    [self showPhotoWithImageDatas:imageDatas imageViews:imageBackViews index:currentImageIndex controller:currentController completion:nil];
}

- (void)showPhotoWithImageDatas:(NSArray *)imageDatas imageViews:(NSArray <UIImageView *>*)imageBackViews index:(NSInteger)currentImageIndex controller:(UIViewController *)currentController completion:(SelectedSaveImageCompletion)completion {

    [self showPhotoWithImageDatas:imageDatas imageViews:imageBackViews index:currentImageIndex showTransition:YES controller:currentController completion:completion];
}

- (void)showPhotoWithImageDatas:(NSArray *)imageDatas imageViews:(NSArray <UIImageView *>*)imageBackViews index:(NSInteger)currentImageIndex showTransition:(BOOL)showTransition controller:(UIViewController *)currentController completion:(SelectedSaveImageCompletion)completion {

    if (!showTransition && imageBackViews.count) {
        imageBackViews = @[];
    }
    
    JPPhotoBrowserController *photoBrowserController = [[JPPhotoBrowserController alloc] initWithImageDatas:imageDatas imageViews:imageBackViews index:currentImageIndex completion:^(UIImage *image) {
        
        //保存图片
        if (completion) {
            completion(image);
        }
        
    }];
    if (photoBrowserController) {
        if (showTransition) {
            photoBrowserController.modalPresentationStyle = UIModalPresentationCustom;
        }
        [self p_HandleData:photoBrowserController];
        [currentController presentViewController:photoBrowserController animated:YES completion:nil];
    }
}

- (instancetype)init {

    self = [super init];

    if (self) {

        [self p_SetDefaultData];
    }
    return self;
}

#pragma mark - default data
- (void)p_SetDefaultData {

    self.backViewColor = [UIColor blackColor];
    self.isShowTopIndex = YES;
    self.currentIndexColor = [UIColor redColor];
    self.currentIndexFontSize = [UIFont boldSystemFontOfSize:20];
    self.totalIndexColor = [UIColor whiteColor];
    self.totalIndexFontSize = [UIFont boldSystemFontOfSize:17];
    self.middleString = @"/";

    self.isShowSaveImage = NO;
    
    self.scrollMaxMargin = 60;
}

#pragma mark - handle data
- (void)p_HandleData:(JPPhotoBrowserController *)photoBrowserController {

    photoBrowserController.isShowTopIndex = self.isShowTopIndex;
    photoBrowserController.currentIndexColor = self.currentIndexColor;
    photoBrowserController.currentIndexFontSize = self.currentIndexFontSize;
    photoBrowserController.totalIndexColor = self.totalIndexColor;
    photoBrowserController.totalIndexFontSize = self.totalIndexFontSize;
    photoBrowserController.middleString = self.middleString;
    photoBrowserController.isShowSaveImage = self.isShowSaveImage;
    photoBrowserController.saveImage = self.saveImage;
    photoBrowserController.scrollMaxMargin = self.scrollMaxMargin;
    //当优先设置backViewColor时,Browser控制器会直接走 viewDidLoad方法,很奇怪,所以此处将color设置放在后面
    photoBrowserController.backViewColor = self.backViewColor;
}

@end
