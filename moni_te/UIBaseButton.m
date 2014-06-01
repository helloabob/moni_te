//
//  UIBaseButton.m
//  moni_te
//
//  Created by wangbo on 5/30/14.
//  Copyright (c) 2014 wb. All rights reserved.
//

#import "UIBaseButton.h"

@implementation UIBaseButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)renderImage{[self setImage:[UIImage imageNamed:LocalizableString(self.offImageName)] forState:UIControlStateNormal];[self setImage:[UIImage imageNamed:LocalizableString(self.onImageName)] forState:UIControlStateHighlighted];}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
