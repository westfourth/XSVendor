//
//  UIImage+XSGIF.h
//  Test
//
//  Created by mac on 2019/11/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
    扩展UIImage对GIF的支持
 */
@interface UIImage (XSGIF)

//  读取mainBundle中的gif。
+ (nullable UIImage *)gifImageNamed:(NSString *)name;

/**
    读取GIF，生成_UIAnimatedImage。
 
    @note   gif文件需要放在工程目录下，不能放在Asssets中。
 
    @param  bundle      bundle = nil时为mainBundle。
 */
+ (nullable UIImage *)gifImageNamed:(NSString *)name inBundle:(nullable NSBundle *)bundle;

+ (nullable UIImage *)gifImageWithContentsOfFile:(NSString *)path;

+ (nullable UIImage *)gifImageWithData:(NSData *)data;

@end


//  生成GIF数据。
UIKIT_EXTERN  NSData * __nullable UIImageGIFRepresentation(UIImage * __nonnull image);


NS_ASSUME_NONNULL_END
