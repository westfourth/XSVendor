//
//  XSFunctions.m
//  PDF
//
//  Created by xisi on 2020/4/19.
//  Copyright © 2020 mac. All rights reserved.
//

#import "XSFunctions.h"

//_______________________________________________________________________________________________________________
// MARK: - UIFont

__attribute__((overloadable)) UIFont* font(CGFloat size) {
    return font(size, UIFontWeightRegular);
}

__attribute__((overloadable)) UIFont* font(CGFloat size, UIFontWeight weight) {
    NSString *fontName = @"";
    if (weight == UIFontWeightUltraLight) {
        fontName = @"PingFangSC-Ultralight";
    } else if (weight == UIFontWeightThin) {
        fontName = @"PingFangSC-Thin";
    } else if (weight == UIFontWeightLight) {
        fontName = @"PingFangSC-Light";
    } else if (weight == UIFontWeightRegular) {
        fontName = @"PingFangSC-Regular";
    } else if (weight == UIFontWeightMedium) {
        fontName = @"PingFangSC-Medium";
    } else if (weight == UIFontWeightSemibold) {
        fontName = @"PingFangSC-Semibold";
    } else {
        printf(">>> 平方字体不支持：%f\n", weight);
        assert(false);
    }
    UIFontDescriptor *fontDesc = [UIFontDescriptor fontDescriptorWithName:fontName size:size];
    UIFont *font = [UIFont fontWithDescriptor:fontDesc size:0];
    return font;
//    return [UIFont systemFontOfSize:size weight:weight];
}

//_______________________________________________________________________________________________________________
// MARK: - UIColor

__attribute__((overloadable)) UIColor* rgb(UInt32 red, UInt32 green, UInt32 blue) {
    return [UIColor colorWithRed:red/255.0
                           green:green/255.0
                            blue:blue/255.0
                           alpha:1.0];
}

__attribute__((overloadable)) UIColor* rgb(UInt32 red, UInt32 green, UInt32 blue, CGFloat alpha) {
    return [UIColor colorWithRed:red/255.0
                           green:green/255.0
                            blue:blue/255.0
                           alpha:alpha];
}

__attribute__((overloadable)) UIColor* rgb(UInt32 hex) {
    return [UIColor colorWithRed:((hex & 0xFF0000) >> 16)/255.0
                           green:((hex & 0xFF00) >> 8)/255.0
                            blue:((hex & 0xFF))/255.0
                           alpha:1.0];
}

__attribute__((overloadable)) UIColor* rgb(const char *str) {
    return [UIColor colorWithRed:((strtol(str, NULL, 16) & 0xFF0000) >> 16)/255.0
                           green:((strtol(str, NULL, 16) & 0xFF00) >> 8)/255.0
                            blue:((strtol(str, NULL, 16) & 0xFF))/255.0
                           alpha:1.0];
}

//_______________________________________________________________________________________________________________
// MARK: -

void _clean_up_function(void (^*block_)(void)) {
    (*block_)();
}
