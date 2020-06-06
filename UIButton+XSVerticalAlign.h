//
//  UIButton+XSVerticalAlign.h
//  Test
//
//  Created by mac on 2020/2/28.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (XSVerticalAlign)

/// 是否垂直布局，即图片在上，文字在下
@property (nonatomic) BOOL verticalAlign;

/// 垂直布局间隙，即图片与文字之间的距离
@property (nonatomic) CGFloat verticalAlignSpacing;

@end

NS_ASSUME_NONNULL_END
