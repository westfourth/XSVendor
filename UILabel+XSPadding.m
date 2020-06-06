//
//  UILabel+XSPadding.m
//  Test
//
//  Created by mac on 2020/2/27.
//  Copyright © 2020 mac. All rights reserved.
//

#import "UILabel+XSPadding.h"
#import <objc/runtime.h>

@implementation UILabel (XSPadding)

- (UIEdgeInsets)padding {
    NSValue *value = objc_getAssociatedObject(self, @selector(padding));
    return value.UIEdgeInsetsValue;
}

- (void)setPadding:(UIEdgeInsets)padding {
    NSValue *value = [NSValue valueWithUIEdgeInsets:padding];
    objc_setAssociatedObject(self, @selector(padding), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load {
    Class cls = [UILabel class];
    SEL sel = @selector(drawTextInRect:);
    Method m = class_getInstanceMethod(cls, sel);
    IMP imp0 = method_getImplementation(m);
    IMP imp1 = imp_implementationWithBlock(^void(UILabel *label, CGRect rect) {
        UIEdgeInsets padding = label.padding;
        CGRect rect2 = CGRectMake(CGRectGetMinX(rect) + padding.left,
                                  CGRectGetMinY(rect) + padding.top,
                                  CGRectGetWidth(rect) - (padding.left + padding.right),
                                  CGRectGetHeight(rect) - (padding.top + padding.bottom));
        ((void (*)(UILabel*, SEL, CGRect))imp0)(label, sel, rect2);
    });
    method_setImplementation(m, imp1);
}

@end
