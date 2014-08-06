//
//  BaseViewController.h
//  moni_te
//
//  Created by wangbo on 5/30/14.
//  Copyright (c) 2014 wb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController<UITextViewDelegate>
@property(nonatomic,retain)UIImageView *backImageView;
@property(nonatomic,retain)UIView *contentView;
@property(nonatomic,assign)BOOL BottomBarHidden;
@property(nonatomic,assign)BOOL SettingControlViewHidden;
@property(nonatomic,assign)BOOL BlackAreaHidden;
@property(nonatomic,retain)NSDictionary *dict;
@property(nonatomic,retain)NSArray *keyArray;
@property(nonatomic,assign)BOOL isConnected;
-(void)renderImage;
-(void)changeSettingY:(int)y;
-(void)returnToDefault;
-(void)showAlert;
-(void)setHelpMsg:(NSString *)str;
-(void)onRead;
-(void)didReceiveData:(NSData *)data;
-(void)didNotReceive;
@end
