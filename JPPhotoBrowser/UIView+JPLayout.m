//
//  UIView+JP_Frame.m
//  JPHeaderViewScale
//
//  Created by tztddong on 2016/11/3.
//  Copyright © 2016年 dongjiangpeng. All rights reserved.
//

#import "UIView+JPLayout.h"

@implementation UIView (JPLayout)

- (CGFloat)jp_x{
    
    return self.frame.origin.x;
}

- (void)setJp_x:(CGFloat)jp_x{
    
    CGRect frame = self.frame;
    frame.origin.x = jp_x;
    self.frame = frame;
}

- (CGFloat)jp_y{
    
    return self.frame.origin.y;
}

- (void)setJp_y:(CGFloat)jp_y{
    
    CGRect frame = self.frame;
    frame.origin.y = jp_y;
    self.frame = frame;
}

- (CGFloat)jp_w{
    
    return self.frame.size.width;
}

- (void)setJp_w:(CGFloat)jp_w{
    
    CGRect frame = self.frame;
    frame.size.width = jp_w;
    self.frame = frame;
}

- (CGFloat)jp_h{
    
    return self.frame.size.height;
}

- (void)setJp_h:(CGFloat)jp_h{
    
    CGRect frame = self.frame;
    frame.size.height = jp_h;
    self.frame = frame;
}

- (CGSize)jp_size {

    return self.frame.size;
}

- (void)setJp_size:(CGSize)jp_size {

    CGRect frame = self.frame;
    frame.size = jp_size;
    self.frame = frame;
}

- (CGFloat)jp_centerX{
    
    return self.center.x;
}

- (void)setJp_centerX:(CGFloat)jp_centerX{
    
    CGPoint center = self.center;
    center.x = jp_centerX;
    self.center = center;
}

- (CGFloat)jp_centerY{
    
    return self.center.y;
}

- (void)setJp_centerY:(CGFloat)jp_centerY{
    
    CGPoint center = self.center;
    center.y = jp_centerY;
    self.center = center;
}

- (void)jp_removeAllSubViews{
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

@end
