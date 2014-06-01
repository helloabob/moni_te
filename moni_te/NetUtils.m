//
//  NetUtils.m
//  moni_te
//
//  Created by mac0001 on 6/1/14.
//  Copyright (c) 2014 wb. All rights reserved.
//

#import "NetUtils.h"

@implementation NetUtils
+ (instancetype)sharedInstance{
    static NetUtils *sharedNetUtilsInstance = nil;
    static dispatch_once_t predicate; dispatch_once(&predicate, ^{
        sharedNetUtilsInstance = [[self alloc] init];
    });
    return sharedNetUtilsInstance;
}
@end
