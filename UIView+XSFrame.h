//
//  UIView+XSFrame.h
//  Frame
//
//  Created by xisi on 2018/10/23.
//  Copyright © 2018年 xisi. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
    只有get方法。
 
    如果有set方法，比如setRight:，这时候是改变left，还是改变width ?
 */
@interface UIView (XSFrame)

@property (readonly, nonatomic) CGFloat left;
@property (readonly, nonatomic) CGFloat right;
@property (readonly, nonatomic) CGFloat top;
@property (readonly, nonatomic) CGFloat bottom;

@property (readonly, nonatomic) CGFloat width;
@property (readonly, nonatomic) CGFloat height;
@property (readonly, nonatomic) CGFloat centerX;
@property (readonly, nonatomic) CGFloat centerY;

@end
