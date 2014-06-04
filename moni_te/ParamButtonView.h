//
//  ParamButtonView.h
//  moni_te
//
//  Created by mac0001 on 6/4/14.
//  Copyright (c) 2014 wb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParamButtonView : UIView
- (id)initWithFrame:(CGRect)frame withImageName:(NSString *)imageName;
@property(nonatomic,retain)NSString *valueString;
-(void)renderImage;
@end
