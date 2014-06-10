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
-(void)setValueWithArray:(unsigned char *)data{
    
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
