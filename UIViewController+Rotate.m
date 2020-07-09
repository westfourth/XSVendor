//
//  UIViewController+Rotate.m
//  Test
//
//  Created by mac on 2020/7/9.
//  Copyright © 2020 mac. All rights reserved.
//

#import "UIViewController+Rotate.h"
#import <objc/runtime.h>

@implementation UIViewController (Rotate)

+ (void)noRotateAndOnlyPortrait {
    [self aop_shouldAutorotate];
    [self aop_supportedInterfaceOrientations];
    [self aop_preferredInterfaceOrientationForPresentation];
}

//  修改默认值：不支持旋转
+ (void)aop_shouldAutorotate {
    Class cls = [UIViewController class];
    SEL sel = @selector(shouldAutorotate);
    Method m = class_getInstanceMethod(cls, sel);
    IMP imp1 = imp_implementationWithBlock(^BOOL(UIViewController *vc) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            return [((UITabBarController *)vc).selectedViewController shouldAutorotate];
        } else if ([vc isKindOfClass:[UINavigationController class]]) {
            return [((UINavigationController *)vc).topViewController shouldAutorotate];
        }
        return NO;
    });
    method_setImplementation(m, imp1);
}

//  修改默认值：仅支持portrait
+ (void)aop_supportedInterfaceOrientations {
    Class cls = [UIViewController class];
    SEL sel = @selector(supportedInterfaceOrientations);
    Method m = class_getInstanceMethod(cls, sel);
    IMP imp1 = imp_implementationWithBlock(^UIInterfaceOrientationMask(UIViewController *vc) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            return [((UITabBarController *)vc).selectedViewController supportedInterfaceOrientations];
        } else if ([vc isKindOfClass:[UINavigationController class]]) {
            return [((UINavigationController *)vc).topViewController supportedInterfaceOrientations];
        }
        return UIInterfaceOrientationMaskPortrait;
    });
    method_setImplementation(m, imp1);
}

//  修改默认值：首选portrait
+ (void)aop_preferredInterfaceOrientationForPresentation {
    Class cls = [UIViewController class];
    SEL sel = @selector(preferredInterfaceOrientationForPresentation);
    Method m = class_getInstanceMethod(cls, sel);
    IMP imp1 = imp_implementationWithBlock(^UIInterfaceOrientation(UIViewController *vc) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            return [((UITabBarController *)vc).selectedViewController preferredInterfaceOrientationForPresentation];
        } else if ([vc isKindOfClass:[UINavigationController class]]) {
            return [((UINavigationController *)vc).topViewController preferredInterfaceOrientationForPresentation];
        }
        return UIInterfaceOrientationPortrait;
    });
    method_setImplementation(m, imp1);
}

@end
