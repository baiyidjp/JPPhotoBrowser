//
//  JPMoreImageView.h
//  JPPhotoBrowserDemo
//
//  Created by tztddong on 2017/4/1.
//  Copyright © 2017年 dongjiangpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

//显示多张照片的View 独立模块
@interface JPImageShowBackView : UIView

//三个属性均为必传属性

/** 单张大图片的URL集合 用于显示浏览大图*/
@property(nonatomic,strong)NSArray <NSString *>*largeImageUrls;
/** 单张小图的URL集合 用于显示九宫格小图*/
@property(nonatomic,strong)NSArray <NSString *>*smallImageUrls;
/** showView的父控制器(用来跳转) */
@property(nonatomic,strong)UIViewController *superController;

@end
