//
//  UIView+XSFrame.m
//  Frame
//
//  Created by xisi on 2018/10/23.
//  Copyright © 2018年 xisi. All rights reserved.
//

#import "UIView+XSFrame.h"

#define XSFRAME_IMPLEMENT(name, prop)          \
- (CGFloat)name {                           \
    return CGRectGet##prop(self.frame);     \
}


@implementation UIView (XSFrame)

XSFRAME_IMPLEMENT(left, MinX);
XSFRAME_IMPLEMENT(right, MaxX);
XSFRAME_IMPLEMENT(top, MinY);
XSFRAME_IMPLEMENT(bottom, MaxY);

XSFRAME_IMPLEMENT(width, Width);
XSFRAME_IMPLEMENT(height, Height);
XSFRAME_IMPLEMENT(centerX, MidX);
XSFRAME_IMPLEMENT(centerY, MidY);

@end
