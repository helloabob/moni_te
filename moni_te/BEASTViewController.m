//
//  BEASTViewController.m
//  moni_te
//
//  Created by wangbo on 6/1/14.
//  Copyright (c) 2014 wb. All rights reserved.
//

#import "BEASTViewController.h"
#import "SettingControlView.h"

@interface BEASTViewController (){
    UIImageView *logo;
}

@end

@implementation BEASTViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.backImageView.image=[UIImage imageNamed:@"BlueBackImage"];
    
    logo=[[[UIImageView alloc]initWithFrame:CGRectMake(50, self.contentView.bounds.size.height/2-48, 220, 81)]autorelease];
    logo.image=[UIImage imageNamed:@"BEAST"];
    [self.contentView addSubview:logo];
    [self performSelector:@selector(enter) withObject:nil afterDelay:1];
    
}

-(void)enter{
    [logo removeFromSuperview];
    self.backImageView.image=[UIImage imageNamed:@"FlashBackImage"];
    SettingControlView *scv=[[[SettingControlView alloc]initWithFrame:CGRectMake(10, self.contentView.bounds.size.height-100-80, 300, 100)]autorelease];
    [self.contentView addSubview:scv];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
