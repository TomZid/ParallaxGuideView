//
//  UIView+Frame.m
//  ParallaxGuideView
//
//  Created by wave on 15/9/24.
//  Copyright (c) 2015年 wave. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}
@end
