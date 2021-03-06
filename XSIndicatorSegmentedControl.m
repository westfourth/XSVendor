//
//  XSIndicatorSegmentedControl.m
//  iOS-OC
//
//  Created by mac on 2020/11/12.
//

#import "XSIndicatorSegmentedControl.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation XSIndicatorSegmentedControl

//MARK:-    重载

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self customInit];
    }
    return self;
}

- (instancetype)initWithItems:(NSArray *)items {
    self = [super initWithItems:items];
    if (self) {
        [self customInit];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _indicatorView.hidden = self.selectedSegmentIndex == UISegmentedControlNoSegment;
    if (self.selectedSegmentIndex == UISegmentedControlNoSegment) {
        return;
    }
    
    _indicatorView.frame = [self indicatorFrameForIndex:self.selectedSegmentIndex];
    _indicatorView.layer.cornerRadius = CGRectGetHeight(_indicatorView.bounds) / 2;
}

- (CGRect)indicatorFrameForIndex:(NSUInteger)index {
    NSArray *subViews = self.subviews;
    
    CGSize size = _indicatorViewSize;
    //  选中segment左边总宽度
    CGFloat avgWidth = CGRectGetWidth(self.bounds) / (self.numberOfSegments == 0 ? 1 : self.numberOfSegments);
    
    CGRect frame = CGRectMake(avgWidth * index + (avgWidth - size.width) / 2, CGRectGetHeight(self.bounds) - size.height, size.width, size.height);
    return frame;
}

- (void)_setSelectedSegmentIndex:(NSInteger)index notify:(BOOL)notify animate:(BOOL)animate {
    void (^block)(BOOL) = ^(BOOL finished){
        struct objc_super s;
        s.receiver = self;
        s.super_class = [UISegmentedControl class];
        SEL sel = _cmd;
        ((void (*)(struct objc_super *, SEL, NSInteger, BOOL, BOOL))objc_msgSendSuper)(&s, sel, index, notify, animate);
    };
    
    if (!_indicatorViewAnimated) {      //  非动画
        block(YES);
    } else {                            //  动画
        [UIView animateWithDuration:0.25 animations:^{
            _indicatorView.frame = [self indicatorFrameForIndex:index];
        } completion:block];
    }
}

//MARK:-    自定义初始化

- (void)customInit {
    [self changeDefaultSetting];
    //
    _indicatorViewSize = CGSizeMake(40, 3);
    _indicatorViewAnimated = YES;
    //
    _indicatorView = [UIView new];
    [self addSubview:_indicatorView];
    _indicatorView.backgroundColor = [UIColor whiteColor];
}

- (void)changeDefaultSetting {
    //  去掉选中颜色
    if (@available(iOS 13, *)) {
        self.selectedSegmentTintColor = [UIColor clearColor];
    }
    //  去掉背景图片
    [self setBackgroundImage:[UIImage new] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //  去掉分割线
    [self setDividerImage:[UIImage new] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

@end
