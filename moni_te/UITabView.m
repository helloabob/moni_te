//
//  UITabView.m
//  moni_te
//
//  Created by wangbo on 6/7/14.
//  Copyright (c) 2014 wb. All rights reserved.
//

#import "UITabView.h"

@implementation UITabView{
    UIView *tabMenuBar;
    UIView *panel;
    NSArray *menuArray;
}

-(void)dealloc{
    [menuArray release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        panel=[[[UIView alloc]initWithFrame:CGRectMake(0, 38, frame.size.width, frame.size.height-38)]autorelease];
        [self addSubview:panel];
        
        menuArray=[[NSArray alloc]initWithObjects:@"firmware",@"general",@"default", nil];
    }
    return self;
}

-(void)setNumberOfTabs:(int)numberOfTabs{
    _numberOfTabs=numberOfTabs;
    
    tabMenuBar=[[[UIView alloc]initWithFrame:CGRectMake(0, 0, 40*numberOfTabs, 38)]autorelease];
    [self addSubview:tabMenuBar];
    
    for (int i=0; i<numberOfTabs; i++) {
        UIBaseButton *btn=[[[UIBaseButton alloc]initWithFrame:CGRectMake(i*40, 0, 39, 38)]autorelease];
        btn.offImageName=[NSString stringWithFormat:@"%@_off",menuArray[i]];
        btn.onImageName=[NSString stringWithFormat:@"%@_on",menuArray[i]];
        btn.offBackImageName=@"header_off";
        btn.onBackImageName=@"header_on";
        btn.imageView.contentMode=UIViewContentModeScaleAspectFit;
        btn.imageEdgeInsets=UIEdgeInsetsMake(2, 4, 4, 4);
        [tabMenuBar addSubview:btn];
        if (i<numberOfTabs-1) {
            UIImageView *split=[[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame), 0, 1, 38)]autorelease];
            split.image=[UIImage imageNamed:@"header_split"];
            [tabMenuBar addSubview:split];
        }
        if (i==0) {
            btn.selected=YES;
        }
    }
    tabMenuBar.center=CGPointMake(self.bounds.size.width/2, 19);
    [self renderImage];
}
-(void)renderImage{
    for (id view in tabMenuBar.subviews) {
        if ([view respondsToSelector:@selector(renderImage)]) {
            [view renderImage];
        }
    }
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
