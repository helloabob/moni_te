//
//  UIBaseImageView.h
//  moni_te
//
//  Created by wangbo on 5/30/14.
//  Copyright (c) 2014 wb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBaseImageView : UIImageView
@property(nonatomic,retain)NSArray *arrayImageNames;
@property(nonatomic,assign)int currentImageIndex;
@end
