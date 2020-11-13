//
//  XSIndicatorSegmentedControl.h
//  iOS-OC
//
//  Created by mac on 2020/11/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//  带有指示器的SegmentedControl
@interface XSIndicatorSegmentedControl : UISegmentedControl

//  底部选中指示器
@property (readonly, nonatomic) UIView *indicatorView;

//  默认为{40, 3}
@property (nonatomic) CGSize indicatorViewSize;

//  是否动画滚动，默认为YES
@property (nonatomic) BOOL indicatorViewAnimated;

@end

NS_ASSUME_NONNULL_END
