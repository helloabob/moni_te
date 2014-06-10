//
//  ParamButtonView.h
//  moni_te
//
//  Created by mac0001 on 6/4/14.
//  Copyright (c) 2014 wb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParamButtonView : UIView
- (id)initWithFrame:(CGRect)frame withImageName:(NSString *)imageName withDelegate:(id)delegate;
@property(nonatomic,retain)NSString *valueString;
-(void)renderImage;
/*TURBO*/
@property(nonatomic,retain)NSDictionary *info;
@property(nonatomic,assign)unsigned char value;
@property(nonatomic,assign)unsigned char precode;
-(void)setValueWithArray:(unsigned char *)data;
@end
