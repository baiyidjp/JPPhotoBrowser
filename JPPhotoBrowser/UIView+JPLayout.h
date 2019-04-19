//
//  UIView+JP_Frame.h
//  JPHeaderViewScale
//
//  Created by tztddong on 2016/11/3.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

// 判断是否是iPhone X
#define iPhoneX ((SCREEN_HEIGHT >= 812) ? YES : NO)

// 状态栏高度
#define STATUS_BAR_HEIGHT (iPhoneX ? 44.f : 20.f)

// 导航栏高度
#define NAVIGATION_BAR_HEIGHT (iPhoneX ? 88.f : 64.f)

// tabBar高度
#define TAB_BAR_HEIGHT (iPhoneX ? (49.f+34.f) : 49.f)

// home indicator
#define HOME_INDICATOR_HEIGHT (iPhoneX ? 34.f : 0.f)

//适配底部x
#define BOTTOM_MARGIN(margin) ((margin)+HOME_INDICATOR_HEIGHT)

//适配屏幕
#define SteyLayoutScreen(x) SCREEN_WIDTH*(x)/375.0

@interface UIView (JPLayout)

@property(nonatomic,assign)CGFloat jp_x;
@property(nonatomic,assign)CGFloat jp_y;
@property(nonatomic,assign)CGFloat jp_w;
@property(nonatomic,assign)CGFloat jp_h;
@property(nonatomic,assign)CGSize jp_size;
@property(nonatomic,assign)CGFloat jp_centerX;
@property(nonatomic,assign)CGFloat jp_centerY;

- (void)jp_removeAllSubViews;

@end
