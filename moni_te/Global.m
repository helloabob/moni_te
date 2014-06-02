//
//  Global.m
//  moni_te
//
//  Created by wangbo on 5/31/14.
//  Copyright (c) 2014 wb. All rights reserved.
//

#import "Global.h"

static int __language;

@implementation Global
+(BOOL)setLanguage:(int)lang{
    if (lang!=__language) {
        __language=lang;
        return YES;
    }
    return NO;
}
+(int)language{
    return __language;
}
@end
