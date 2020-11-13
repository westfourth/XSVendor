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

@property (readonly, nonatomic) UIView *indicatorView;

@property (nonatomic) CGSize indicatorViewSize;         //  默认为{40, 3}

@end

NS_ASSUME_NONNULL_END
