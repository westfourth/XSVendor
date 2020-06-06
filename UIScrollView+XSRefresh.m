//
//  UIScrollView+XSRefresh.m
//  TableViewTest
//
//  Created by xisi on 2019/9/8.
//  Copyright © 2019 xisi. All rights reserved.
//

#import "UIScrollView+XSRefresh.h"
#import <objc/runtime.h>

@implementation UIScrollView (XSRefresh)

//_______________________________________________________________________________________________________________
//  MARK: - 核心

+ (void)load {
    Class cls = [UIScrollView class];
    SEL sel = sel_registerName("handlePan:");
    Method m = class_getInstanceMethod(cls, sel);
    IMP imp0 = method_getImplementation(m);
    IMP imp1 = imp_implementationWithBlock(^void(UIScrollView *scrollView, UIPanGestureRecognizer *pan){
        ((void (*)(UIScrollView*, SEL, UIPanGestureRecognizer*))imp0)(scrollView, sel, pan);
        [scrollView handlePan_:pan];
    });
    method_setImplementation(m, imp1);
}

/** 对 handlePan: 方法补充。
    @note   不要覆盖 handlePan: 方法
 */
- (void)handlePan_:(UIPanGestureRecognizer *)pan {
    if (pan.state == UIGestureRecognizerStateBegan) {
        
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        
    } else if (pan.state == UIGestureRecognizerStateEnded ||
               pan.state == UIGestureRecognizerStateCancelled) {
        CGPoint velocity = [pan velocityInView:self];
        CGFloat distance = [UIScrollView distanceWillBeTravelled:velocity.y decelerationRate:self.decelerationRate];
        
        if ([self shouldRefreshTop:velocity distance:distance]) {
            //  刷新
            if (self.refreshBlock) self.refreshBlock();
        }
        if ([self shouldRefreshBottom:velocity distance:distance]) {
            //  加载更多
            if (self.loadMoreBlock) self.loadMoreBlock();
        }
    }
}

//  刷新
- (BOOL)shouldRefreshTop:(CGPoint)velocity distance:(CGFloat)distance {
    if (velocity.y > 0 && self.contentOffset.y + self.contentInset.top < distance) {
        return YES;
    }
    return NO;
}

//  加载更多
- (BOOL)shouldRefreshBottom:(CGPoint)velocity distance:(CGFloat)distance {
    if (velocity.y < 0 && self.contentOffset.y + self.frame.size.height - (self.contentSize.height + self.contentInset.bottom) > distance) {
        return YES;
    }
    return NO;
}


/**
    计算手指抬起时，UIScrollView将要滑动的距离。

    @note   手指向上滑动为负；手指向下滑动为正。

    @param  velocity            速度
    @param  decelerationRate    加速度
 */
+ (CGFloat)distanceWillBeTravelled:(CGFloat)velocity decelerationRate:(CGFloat)decelerationRate {
    return (velocity / 1000.0) * decelerationRate / (1 - decelerationRate);
}


//_______________________________________________________________________________________________________________
//  MARK: - 伪属性

- (nullable void (^)(void))refreshBlock {
    return objc_getAssociatedObject(self, @selector(refreshBlock));
}
- (void)setRefreshBlock:(nullable void (^)(void))refreshBlock {
    objc_setAssociatedObject(self, @selector(refreshBlock), refreshBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (nullable void (^)(void))loadMoreBlock {
    return objc_getAssociatedObject(self, @selector(loadMoreBlock));
}
- (void)setLoadMoreBlock:(nullable void (^)(void))loadMoreBlock {
    objc_setAssociatedObject(self, @selector(loadMoreBlock), loadMoreBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
