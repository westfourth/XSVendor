//
//  UIViewController+Rotate.h
//  Test
//
//  Created by mac on 2020/7/9.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
    如果启动即为竖屏，则需要配置info.plist为Portrait；
    
    如果启动竖屏，其他页面有横竖屏，实现
    application:supportedInterfaceOrientationsForWindow: 返回AllButUpsideDown
 */
@interface UIViewController (Rotate)

/// 不支持旋转、仅portrait模式
+ (void)noRotateAndOnlyPortrait;

@end

NS_ASSUME_NONNULL_END
