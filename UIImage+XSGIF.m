//
//  UIImage+XSGIF.m
//  Test
//
//  Created by mac on 2019/11/5.
//  Copyright © 2019 mac. All rights reserved.
//

#import "UIImage+XSGIF.h"
#import <MobileCoreServices/MobileCoreServices.h>

@implementation UIImage (XSGIF)

+ (nullable UIImage *)gifImageNamed:(NSString *)name {
    return [self gifImageNamed:name inBundle:nil];
}

+ (nullable UIImage *)gifImageNamed:(NSString *)name inBundle:(nullable NSBundle *)bundle {
    NSBundle *bundle2 = bundle ? bundle : [NSBundle mainBundle];
    NSString *path = [bundle2 pathForResource:name ofType:nil];
    return [self gifImageWithContentsOfFile:path];
}

+ (nullable UIImage *)gifImageWithContentsOfFile:(NSString *)path {
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [self gifImageWithData:data];
}

+ (nullable UIImage *)gifImageWithData:(NSData *)data {
    CGImageSourceRef imageSource = CGImageSourceCreateWithData((CFDataRef)data, NULL);
    CFStringRef type = CGImageSourceGetType(imageSource);
    if (CFStringCompare(type, kUTTypeGIF, 0) != kCFCompareEqualTo) {
        CFRelease(imageSource);
        return nil;
    }
        
    NSMutableArray<UIImage *> *images = [NSMutableArray new];
    NSTimeInterval duration = 0;
    size_t count = CGImageSourceGetCount(imageSource);
    for (int i = 0; i < count; i++) {
        //  获取每帧时间
        CFDictionaryRef dict = CGImageSourceCopyPropertiesAtIndex(imageSource, i, NULL);
        CFDictionaryRef gifDict = CFDictionaryGetValue(dict, kCGImagePropertyGIFDictionary);
        NSTimeInterval time = 0;
        CFNumberRef delayTime = (CFNumberRef)CFDictionaryGetValue(gifDict, kCGImagePropertyGIFDelayTime);
        CFNumberGetValue(delayTime, CFNumberGetType(delayTime), &time);
        duration += time;
        CFRelease(dict);
        
        //  获取每帧图片
        CGImageRef image = CGImageSourceCreateImageAtIndex(imageSource, i, NULL);
        UIImage *aImage = [UIImage imageWithCGImage:image];
        [images addObject:aImage];
        CGImageRelease(image);
    }
    CFRelease(imageSource);
    
    UIImage *image = [UIImage animatedImageWithImages:images duration:duration];
    return image;
}

@end


NSData * __nullable UIImageGIFRepresentation(UIImage * __nonnull image) {
    //  设置LoopCount = 0
    CFMutableDictionaryRef gifDict = CFDictionaryCreateMutable(NULL, 0, NULL, NULL);
    SInt32 lpCount = 0;
    CFNumberRef loopCount = CFNumberCreate(NULL, kCFNumberSInt32Type, &lpCount);
    CFDictionarySetValue(gifDict, kCGImagePropertyGIFLoopCount, loopCount);
    
    CFMutableDictionaryRef props = CFDictionaryCreateMutable(NULL, 0, NULL, NULL);
    CFDictionarySetValue(props, kCGImagePropertyGIFDictionary, gifDict);
    
    //  生成CGImageDestinationRef
    size_t count = image.images.count;
    CFMutableDataRef data = CFDataCreateMutable(NULL, 0);
    CGImageDestinationRef destination = CGImageDestinationCreateWithData(data, kUTTypeGIF, count, props);
    
    CFRelease(gifDict);
    CFRelease(loopCount);
    CFRelease(props);
    
    for (int i = 0; i < count; i++) {
        //  设置DelayTime、UnclampedDelayTime
        CFMutableDictionaryRef gifDict = CFDictionaryCreateMutable(NULL, 0, NULL, NULL);
        NSTimeInterval duration = image.duration / count;
        CFNumberRef delayTime = CFNumberCreate(NULL, kCFNumberFloat64Type, &duration);
        CFDictionarySetValue(gifDict, kCGImagePropertyGIFDelayTime, delayTime);
        CFDictionarySetValue(gifDict, kCGImagePropertyGIFUnclampedDelayTime, delayTime);
        
        CFMutableDictionaryRef props = CFDictionaryCreateMutable(NULL, 0, NULL, NULL);
        CFDictionarySetValue(props, kCGImagePropertyGIFDictionary, gifDict);
        
        //  依次添加CGImageRef
        UIImage *aImage = image.images[i];
        CGImageDestinationAddImage(destination, aImage.CGImage, props);
        
        CFRelease(gifDict);
        CFRelease(delayTime);
        CFRelease(props);
    }
    CGImageDestinationFinalize(destination);
    CFRelease(destination);
    NSData *mData = CFBridgingRelease(data);
    return mData;
}
