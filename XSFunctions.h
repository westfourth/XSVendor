//
//  XSFunctions.h
//  PDF
//
//  Created by xisi on 2020/4/19.
//  Copyright © 2020 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//  格式：KEY(UIView, frame)
#define KEY(x, y)           ([x new].y, @#y)
//  格式：IMAGE(logo)
#define IMAGE(s)            [UIImage imageNamed:@#s]

#define WEAK(x)             __weak typeof (x) weak_##x = x
#define STRONG(x)           __strong typeof (x) x = weak_##x

//  格式：@weak(self)
#define weak(x)             autoreleasepool{} __weak typeof (x) weak_##x = x
//  格式：@strong(self)
#define strong(x)           autoreleasepool{} __strong typeof (x) x = weak_##x

NS_ASSUME_NONNULL_BEGIN

__attribute__((overloadable)) UIFont* font(CGFloat size);
__attribute__((overloadable)) UIFont* font(CGFloat size, UIFontWeight weight);

__attribute__((overloadable)) UIColor* rgb(UInt32 red, UInt32 green, UInt32 blue);
__attribute__((overloadable)) UIColor* rgb(UInt32 red, UInt32 green, UInt32 blue, CGFloat alpha);

//  格式: rgb(0x6eb92b), 不区分大小写
__attribute__((overloadable)) UIColor* rgb(UInt32 hex);

//  格式：rgb("6eb92b"), rgb("0x6eb92b"), 不区分大小写
__attribute__((overloadable)) UIColor* rgb(const char *str);

NS_ASSUME_NONNULL_END


//_______________________________________________________________________________________________________________
// MARK: -  defer

/**
    defer 延迟执行
 
    cleanup修饰的变量，在它的作用域结束时自动执行一个指定的方法
 
 @code
    defer {
        //  Do something
    };
 @endcode
 */
#define defer   __attribute__((cleanup(_clean_up_function))) \
                __attribute__((unused)) void (^block_)(void) = ^

void _clean_up_function(void (^*block_)(void));

