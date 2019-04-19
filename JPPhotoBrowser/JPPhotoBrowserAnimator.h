//
//  JPPhotoBrowserAnimator.h
//  JPPhotoBrowserDemo
//
//  Created by tztddong on 2017/4/1.
//  Copyright © 2017年 dongjiangpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//负责自定义转场
@interface JPPhotoBrowserAnimator : NSObject<UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>

/** 九宫格的小图View */
@property(nonatomic,strong) UIImageView *animationImageView;

/** 当前显示的大图View */
@property(nonatomic,strong) UIImageView *currentImageView;

/** backViewColor */
@property(nonatomic,strong) UIColor *backViewColor;

@end
