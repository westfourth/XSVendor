//
//  UIScrollView+XSRefresh.h
//  TableViewTest
//
//  Created by xisi on 2019/9/8.
//  Copyright © 2019 xisi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
    采用预加载技术
 */
@interface UIScrollView (XSRefresh)

//  注意循环引用
@property (nullable, nonatomic) void (^refreshBlock)(void);     //  刷新
@property (nullable, nonatomic) void (^loadMoreBlock)(void);    //  加载更多

@end

NS_ASSUME_NONNULL_END
