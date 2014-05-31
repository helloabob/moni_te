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
+(void)setLanguage:(int)lang{
    __language=lang;
}
+(int)language{
    return __language;
}
@end
