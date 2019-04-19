//
//  MoreImageViewController.m
//  JPPhotoBrowserDemo
//
//  Created by tztddong on 2017/4/1.
//  Copyright © 2017年 dongjiangpeng. All rights reserved.
//

#import "ImageShowViewController.h"
#import "JPImageShowBackView.h"



@interface ImageShowViewController ()

@end

@implementation ImageShowViewController
{
    JPImageShowBackView      *_imageShowBackView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"多图控制器";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //宽高可以随便写 XY必须确定
    _imageShowBackView = [[JPImageShowBackView alloc] initWithFrame:CGRectMake(0, 100, 0, 0)];
    _imageShowBackView.smallImageUrls = self.smallImageUrls;
    _imageShowBackView.largeImageUrls = self.largeImageUrls;
    _imageShowBackView.superController = self;
    [self.view addSubview:_imageShowBackView];

}


@end
