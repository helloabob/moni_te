//
//  SettingControlView.m
//  moni_te
//
//  Created by wangbo on 6/1/14.
//  Copyright (c) 2014 wb. All rights reserved.
//

#import "SettingControlView.h"

@implementation SettingControlView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.commonImageName=@"settingcontrol";
        
        UIBaseButton *btn=[[[UIBaseButton alloc]initWithFrame:CGRectMake(20, 60, 100, 21)]autorelease];
        btn.offImageName=@"readsetting_off";
        btn.onImageName=@"readsetting_on";
        [self addSubview:btn];
        btn=[[[UIBaseButton alloc]initWithFrame:CGRectMake(180, 60, 100, 21)]autorelease];
        btn.offImageName=@"sendsetting_off";
        btn.onImageName=@"sendsetting_on";
        [self addSubview:btn];
        
        [self renderImage];
        
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
