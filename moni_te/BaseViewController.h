//
//  BaseViewController.h
//  moni_te
//
//  Created by wangbo on 5/30/14.
//  Copyright (c) 2014 wb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property(nonatomic,retain)UIImageView *backImageView;
@property(nonatomic,retain)UIView *contentView;
@property(nonatomic,assign)BOOL BottomBarHidden;
@property(nonatomic,assign)BOOL SettingControlViewHidden;
@property(nonatomic,retain)NSDictionary *dict;
@property(nonatomic,retain)NSArray *keyArray;
-(void)renderImage;
@end
