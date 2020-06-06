//
//  UIButton+XSVerticalAlign.m
//  Test
//
//  Created by mac on 2020/2/28.
//  Copyright © 2020 mac. All rights reserved.
//

#import "UIButton+XSVerticalAlign.h"
#import <objc/runtime.h>

@implementation UIButton (XSVerticalAlign)

- (BOOL)verticalAlign {
    return [objc_getAssociatedObject(self, @selector(verticalAlign)) boolValue];
}

- (void)setVerticalAlign:(BOOL)verticalAlign {
    objc_setAssociatedObject(self, @selector(verticalAlign), @(verticalAlign), OBJC_ASSOCIATION_ASSIGN);
    [self setNeedsLayout];
}

- (CGFloat)verticalAlignSpacing {
    return [objc_getAssociatedObject(self, @selector(verticalAlignSpacing)) floatValue];
}

- (void)setVerticalAlignSpacing:(CGFloat)verticalAlignSpacing {
    objc_setAssociatedObject(self, @selector(verticalAlignSpacing), @(verticalAlignSpacing), OBJC_ASSOCIATION_ASSIGN);
    [self setNeedsLayout];
}


+ (void)load {
    Class cls = [UIButton class];
    SEL sel = @selector(layoutSubviews);
    Method m = class_getInstanceMethod(cls, sel);
    IMP imp0 = method_getImplementation(m);
    IMP imp1 = imp_implementationWithBlock(^void(UIButton *button) {
        if (button.verticalAlign == YES) {
            CGSize imageSize = [button imageForState:UIControlStateNormal].size;
            CGSize titleSize = [button titleSize_];
            CGFloat space = button.verticalAlignSpacing;
            button.imageEdgeInsets = UIEdgeInsetsMake(-titleSize.height - space, 0,
                                                      0, -titleSize.width);
            button.titleEdgeInsets = UIEdgeInsetsMake(0, -imageSize.width,
                                                      -imageSize.height - space, 0);
        }
        ((void (*)(UIButton *, SEL))imp0)(button, sel);
    });
    method_setImplementation(m, imp1);
}


/// 获取文字大小。后缀下划线，防止同名方法。
- (CGSize)titleSize_ {
    NSString *title = [self titleForState:UIControlStateNormal];
    if (title != nil) {             //  正常文字
        return [title sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}];
    }
    NSAttributedString *attrTitle = [self attributedTitleForState:UIControlStateNormal];
    if (attrTitle != nil) {         //  属性文字
        __block UIFont *font = nil;
        [attrTitle enumerateAttribute:NSFontAttributeName inRange:NSMakeRange(0, attrTitle.length) options:0 usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
            if (value != nil) {
                font = value;
                *stop = YES;
            }
        }];
        if (font != nil) {      //  设置了字体
            return attrTitle.size;
        } else {                //  没有设置字体
            return [attrTitle.string sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}];
        }
    }
    return CGSizeZero;
}

@end
