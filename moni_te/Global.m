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
+(NSString *)valueForKey:(unsigned char)key AtDictionary:(NSDictionary *)dic{
    NSArray *array=[self convertStringToArray:dic forKey:@"KeysRange"];
    int index=-1;
    for (int i=0; i<array.count; i++) {
        if ([array[i] intValue]==key) {
            index=i;
            break;
        }
    }
    if (index==-1) {
        index=[dic[@"DefaultKey"] intValue];
    }
    if (index>-1) {
        NSArray *arr=[self convertStringToArray:dic forKey:@"ValuesRange"];
        return arr[index];
    }
    return nil;
}
+(NSArray *)convertStringToArray:(NSDictionary *)dict forKey:(NSString *)key{
    NSString *values=dict[key];
    NSArray *array=nil;
    if ([values rangeOfString:@","].length==0) {
        if ([values rangeOfString:@"-"].length>0) {
            NSArray *arr=[values componentsSeparatedByString:@"-"];
            int start=[arr[0] intValue];
            int end=[arr[1] intValue];
            NSMutableArray *ar=[NSMutableArray array];
            for (int i=start; i<=end; i++) {
                [ar addObject:[NSString stringWithFormat:@"%d",i]];
            }
            array=[NSArray arrayWithArray:ar];
        }else{
            return nil;
        }
    }else{
        array=[values componentsSeparatedByString:@","];
    }
    return array;
}
@end
