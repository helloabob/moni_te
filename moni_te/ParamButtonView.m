//
//  ParamButtonView.m
//  moni_te
//
//  Created by mac0001 on 6/4/14.
//  Copyright (c) 2014 wb. All rights reserved.
//

#import "ParamButtonView.h"

@implementation ParamButtonView{
    UIImageView *titleImageView;
    NSString *_titleImageName;
    UILabel *lblValue;
    NSTimer *_timer;
    int lbl_width;
    id _delegate;
    NSArray *keys;
    NSArray *values;
    unsigned char _precode;
}
-(void)config:(NSDictionary *)info withName:(NSString *)name{
    _precode=(unsigned char)strtoul([info[@"PreCode"] UTF8String], 0, 16);
    keys=[Global convertStringToArray:info forKey:@"KeysRange"];
    _index=[info[@"DefaultKey"]intValue];
    NSMutableArray *array=[NSMutableArray array];
    if ([name isEqualToString:@"voltagecutoff"]) {
        array[0]=@"disable";
        array[1]=@"AUTO";
        for (int i=2; i<112; i++) {
            float f=i;
            f=i/10.0;
            array[i]=[NSString stringWithFormat:@"%fV",f];
        }
    }else if([name isEqualToString:@"switchpoint1"]){
        for (int i=0; i<99; i++) {
            array[i]=[NSString stringWithFormat:@"%d%%",i+1];
        }
    }else if([name isEqualToString:@"dragbrake"]){
        for (int i=0; i<101; i++) {
            array[i]=[NSString stringWithFormat:@"%d%%",i];
        }
    }else if([name isEqualToString:@"switchpoint2"]){
        for (int i=0; i<99; i++) {
            array[i]=[NSString stringWithFormat:@"%d%%",i+1];
        }
    }else if([name isEqualToString:@"boosttiming"]){
        for (int i=0; i<65; i++) {
            array[i]=[NSString stringWithFormat:@"%d",i];
        }
    }else if([name isEqualToString:@"startrpm1"]){
        for (int i=0; i<69; i++) {
            array[i]=[NSString stringWithFormat:@"%d",i*500+1000];
        }
    }else if([name isEqualToString:@"endrpm"]){
        for (int i=0; i<115; i++) {
            array[i]=[NSString stringWithFormat:@"%d",i*500+3000];
        }
    }else if([name isEqualToString:@"turbotiming"]){
        for (int i=0; i<65; i++) {
            array[i]=[NSString stringWithFormat:@"%d",i];
        }
    }else if([name isEqualToString:@"turbodelay"]){
        array[0]=@"Instant";
        for (int i=1; i<21; i++) {
            float f=i;
            array[i]=[NSString stringWithFormat:@"%f",f*0.05];
        }
    }else if([name isEqualToString:@"startrpm2"]){
        for (int i=0; i<43; i++) {
            array[i]=[NSString stringWithFormat:@"%d",i*1000+8000];
        }
    }else if([name isEqualToString:@"turboslopeon"]){
        for (int i=0; i<10; i++) {
            array[i]=[NSString stringWithFormat:@"%ddeg/0.1S",i*3+3];
        }
        array[10]=@"Instant";
    }else if([name isEqualToString:@"turboslopeoff"]){
        for (int i=0; i<5; i++) {
            array[i]=[NSString stringWithFormat:@"%ddeg/0.1S",i*6+6];
        }
        array[5]=@"Instant";
    }
}
-(void)setKeyWithResponseBytes:(unsigned char *)bytes{
}
-(NSData *)postedData{
    unsigned char ret[2]={_precode,[keys[_index]intValue]};
    return [NSData dataWithBytes:ret length:2];
}
- (id)initWithFrame:(CGRect)frame withImageName:(NSString *)imageName withDelegate:(id)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _delegate=delegate;
        _titleImageName=[[NSString alloc] initWithString:imageName];
        
        UIImageView *imageView=[[[UIImageView alloc]initWithFrame:self.bounds]autorelease];
        imageView.image=[UIImage imageNamed:@"paramicon"];
        [self addSubview:imageView];
        
        titleImageView=[[[UIImageView alloc]initWithFrame:CGRectMake(17, 13, 66, 14)]autorelease];
        titleImageView.contentMode=UIViewContentModeScaleAspectFit;
        [self addSubview:titleImageView];
        
        UIView *innerView=[[[UIView alloc]initWithFrame:CGRectMake(10, 35, self.bounds.size.width-20, 25)]autorelease];
        [self addSubview:innerView];
        innerView.layer.masksToBounds=YES;
        
        lblValue=[[[UILabel alloc]initWithFrame:innerView.bounds]autorelease];
        lblValue.textColor=[UIColor whiteColor];
        lblValue.textAlignment=NSTextAlignmentCenter;
        lblValue.font=[UIFont systemFontOfSize:12];
        lbl_width=lblValue.bounds.size.width;
        [innerView addSubview:lblValue];
        
        [self renderImage];
        
        UIButton *btn=[[[UIButton alloc]initWithFrame:self.bounds]autorelease];
        btn.backgroundColor=[UIColor clearColor];
        [btn addTarget:self action:@selector(btnTapped) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return self;
}
-(void)btnTapped{
    if (_delegate&&[_delegate respondsToSelector:@selector(viewDidTapped:)]) {
        [_delegate viewDidTapped:self];
    }
}
-(void)setValueString:(NSString *)valueString{
//    if (lblValue.text==valueString) {
//        return;
//    }
//    dispatch_async(dispatch_get_main_queue(), ^(){
        lblValue.text=valueString;
        [lblValue.layer removeAllAnimations];
        CGSize textSize = [lblValue.text sizeWithFont:lblValue.font];
        
        if (textSize.width > lbl_width) {
            
            CGRect lframe = lblValue.frame;
            lframe.size.width = textSize.width;
            lblValue.frame = lframe;
            
            float offset = textSize.width - lbl_width;
            [UIView animateWithDuration:3.0
                                  delay:0
                                options:UIViewAnimationOptionRepeat //动画重复的主开关
             |UIViewAnimationOptionAutoreverse //动画重复自动反向，需要和上面这个一起用
             |UIViewAnimationOptionCurveLinear //动画的时间曲线，滚动字幕线性比较合理
                             animations:^{
                                 lblValue.transform = CGAffineTransformMakeTranslation(-offset, 0);
                             }
                             completion:^(BOOL finished) {
                                 
                             }
             ];
        }else{
            lblValue.textAlignment=NSTextAlignmentCenter;
        }
//    });
}

-(void)renderImage{
    titleImageView.image=[UIImage imageNamed:LocalizableString(_titleImageName)];
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
