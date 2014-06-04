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
}

- (id)initWithFrame:(CGRect)frame withImageName:(NSString *)imageName
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _titleImageName=[[NSString alloc] initWithString:imageName];
        
        UIImageView *imageView=[[[UIImageView alloc]initWithFrame:self.bounds]autorelease];
        imageView.image=[UIImage imageNamed:@"paramicon"];
        [self addSubview:imageView];
        
        titleImageView=[[[UIImageView alloc]initWithFrame:CGRectMake(17, 13, 66, 14)]autorelease];
        [self addSubview:titleImageView];
        
        lblValue=[[[UILabel alloc]initWithFrame:CGRectMake(0, 40, self.bounds.size.width, 25)]autorelease];
        lblValue.textColor=[UIColor whiteColor];
        lblValue.textAlignment=NSTextAlignmentCenter;
        lblValue.font=[UIFont systemFontOfSize:12];
        [self addSubview:lblValue];
        
        [self renderImage];
    }
    return self;
}

-(void)setValueString:(NSString *)valueString{
    lblValue.text=valueString;
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
