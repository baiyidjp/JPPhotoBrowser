//
//  ViewController.m
//  JPPhotoBrowserDemo
//
//  Created by tztddong on 2017/4/1.
//  Copyright © 2017年 dongjiangpeng. All rights reserved.
//

#import "ViewController.h"
#import "ImageShowViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)oneClick:(id)sender {
    
    NSArray *smallImageUrls =  @[@"http://wx3.sinaimg.cn/mw690/66755707gy1fe9gyjk2sxj20m80m80zq.jpg"];
    NSArray *largeImageUrls =  @[@"http://wx3.sinaimg.cn/mw690/66755707gy1fe9gyjk2sxj20m80m80zq.jpg"];
    
    ImageShowViewController *imageShowVC = [[ImageShowViewController alloc] init];
    imageShowVC.smallImageUrls = smallImageUrls;
    imageShowVC.largeImageUrls = largeImageUrls;
    [self.navigationController pushViewController:imageShowVC animated:YES];
}
- (IBAction)fourClick:(id)sender {
    
    NSArray *smallImageUrls =  @[@"http://wx3.sinaimg.cn/mw690/66755707gy1fe9gyjk2sxj20m80m80zq.jpg",
                                 @"http://wx4.sinaimg.cn/mw690/66755707ly1febk0z9b37j20990dwwrf.jpg",
                                 @"http://wx2.sinaimg.cn/mw690/0069ptwkgy1feb1dmjg52j30hs0b8dgr.jpg",
                                 @"http://wx1.sinaimg.cn/mw690/0069ptwkgy1feb1dgzvelj31hc0xcnor.jpg"];
    NSArray *largeImageUrls =  @[@"http://wx3.sinaimg.cn/mw690/66755707gy1fe9gyjk2sxj20m80m80zq.jpg",
                                 @"http://wx4.sinaimg.cn/mw690/66755707ly1febk0z9b37j20990dwwrf.jpg",
                                 @"http://wx2.sinaimg.cn/mw690/0069ptwkgy1feb1dmjg52j30hs0b8dgr.jpg",
                                 @"http://wx1.sinaimg.cn/mw690/0069ptwkgy1feb1dgzvelj31hc0xcnor.jpg"];
    
    ImageShowViewController *imageShowVC = [[ImageShowViewController alloc] init];
    imageShowVC.smallImageUrls = smallImageUrls;
    imageShowVC.largeImageUrls = largeImageUrls;
    [self.navigationController pushViewController:imageShowVC animated:YES];

}

- (IBAction)fiveClick:(id)sender {
    

    NSArray *smallImageUrls =  @[@"http://wx3.sinaimg.cn/mw690/66755707gy1fe9gyjk2sxj20m80m80zq.jpg",
                                 @"http://wx4.sinaimg.cn/mw690/66755707ly1febk0z9b37j20990dwwrf.jpg",
                                 @"http://wx2.sinaimg.cn/mw690/0069ptwkgy1feb1dmjg52j30hs0b8dgr.jpg",
                                 @"http://wx1.sinaimg.cn/mw690/0069ptwkgy1feb1dgzvelj31hc0xcnor.jpg",
                                 @"http://wx2.sinaimg.cn/mw690/66755707ly1feadezg850j20h80mz7e3.jpg"];
    NSArray *largeImageUrls =  @[@"http://wx3.sinaimg.cn/mw690/66755707gy1fe9gyjk2sxj20m80m80zq.jpg",
                                 @"http://wx4.sinaimg.cn/mw690/66755707ly1febk0z9b37j20990dwwrf.jpg",
                                 @"http://wx2.sinaimg.cn/mw690/0069ptwkgy1feb1dmjg52j30hs0b8dgr.jpg",
                                 @"http://wx1.sinaimg.cn/mw690/0069ptwkgy1feb1dgzvelj31hc0xcnor.jpg",
                                 @"http://wx2.sinaimg.cn/mw690/66755707ly1feadezg850j20h80mz7e3.jpg"];
    
    ImageShowViewController *imageShowVC = [[ImageShowViewController alloc] init];
    imageShowVC.smallImageUrls = smallImageUrls;
    imageShowVC.largeImageUrls = largeImageUrls;
    [self.navigationController pushViewController:imageShowVC animated:YES];
}

- (IBAction)nineClick:(id)sender {
    
    NSArray *smallImageUrls =  @[@"http://wx3.sinaimg.cn/mw690/66755707gy1fe9gyjk2sxj20m80m80zq.jpg",
                                 @"http://wx4.sinaimg.cn/mw690/66755707ly1febk0z9b37j20990dwwrf.jpg",
                                 @"http://wx2.sinaimg.cn/mw690/0069ptwkgy1feb1dmjg52j30hs0b8dgr.jpg",
                                 @"http://wx1.sinaimg.cn/mw690/0069ptwkgy1feb1dgzvelj31hc0xcnor.jpg",
                                 @"http://wx2.sinaimg.cn/mw690/66755707ly1feadezg850j20h80mz7e3.jpg",
                                 @"http://wx2.sinaimg.cn/mw690/66755707ly1feadf01d5ej20h80n34cb.jpg",
                                 @"http://wx3.sinaimg.cn/mw690/66755707gy1fe9jh6ovsyj20dg0f5ab1.jpg",
                                 @"http://wx4.sinaimg.cn/mw690/66755707ly1feadf0wxlsj20go0o41be.jpg",
                                 @"https://ww2.sinaimg.cn/bmiddle/007ec4BGly1g27oqunsdfj30rs601e1n.jpg"];
    NSArray *largeImageUrls =  @[@"http://wx3.sinaimg.cn/mw690/66755707gy1fe9gyjk2sxj20m80m80zq.jpg",
                                 @"http://wx4.sinaimg.cn/mw690/66755707ly1febk0z9b37j20990dwwrf.jpg",
                                 @"http://wx2.sinaimg.cn/mw690/0069ptwkgy1feb1dmjg52j30hs0b8dgr.jpg",
                                 @"http://wx1.sinaimg.cn/mw690/0069ptwkgy1feb1dgzvelj31hc0xcnor.jpg",
                                 @"http://wx2.sinaimg.cn/mw690/66755707ly1feadezg850j20h80mz7e3.jpg",
                                 @"http://wx2.sinaimg.cn/mw690/66755707ly1feadf01d5ej20h80n34cb.jpg",
                                 @"http://wx3.sinaimg.cn/mw690/66755707gy1fe9jh6ovsyj20dg0f5ab1.jpg",
                                 @"http://wx4.sinaimg.cn/mw690/66755707ly1feadf0wxlsj20go0o41be.jpg",
                                 @"https://ww2.sinaimg.cn/bmiddle/007ec4BGly1g27oqunsdfj30rs601e1n.jpg"];

    ImageShowViewController *imageShowVC = [[ImageShowViewController alloc] init];
    imageShowVC.smallImageUrls = smallImageUrls;
    imageShowVC.largeImageUrls = largeImageUrls;
    [self.navigationController pushViewController:imageShowVC animated:YES];
}

@end
