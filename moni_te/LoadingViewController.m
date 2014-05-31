//
//  LoadingViewController.m
//  moni_te
//
//  Created by wangbo on 5/31/14.
//  Copyright (c) 2014 wb. All rights reserved.
//

#import "LoadingViewController.h"

@interface LoadingViewController ()

@end

@implementation LoadingViewController

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
    
    UILabel *lblConnecting=[[[UILabel alloc]initWithFrame:CGRectMake(0, self.contentView.bounds.size.height/2-20, 320, 40)]autorelease];
    lblConnecting.font=[UIFont boldSystemFontOfSize:16];
    lblConnecting.textAlignment=NSTextAlignmentCenter;
    lblConnecting.textColor=[UIColor whiteColor];
    lblConnecting.text=NSLocalizedString(LocalizableString(@"connecting"), nil);
    [self.contentView addSubview:lblConnecting];
    
    [self performSelector:@selector(onSuccess) withObject:nil afterDelay:1];
}

-(void)onSuccess{
    UIButton *btn=[[[UIButton alloc]initWithFrame:CGRectMake(50, self.contentView.bounds.size.height/2-48, 220, 81)]autorelease];
    [btn setImage:[UIImage imageNamed:@"BEAST"] forState:UIControlStateNormal];
    [self.contentView addSubview:btn];
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
