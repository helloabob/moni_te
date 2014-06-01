//
//  BaseViewController.m
//  moni_te
//
//  Created by wangbo on 5/30/14.
//  Copyright (c) 2014 wb. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController (){
    UIView *bottomToolbar;
    UIBaseButton *baseButton;
    UIView *maskView;
}

@end

@implementation BaseViewController

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
    UIView *viewBack=[[[UIView alloc]initWithFrame:CGRectMake(0, IsIOS7System?20:0, 320, IsiPhone5?548:460)]autorelease];
    [self.view addSubview:viewBack];
//    _backImageView=[[[UIImageView alloc]initWithFrame:CGRectMake(0, IsIOS7System?20:0, 320, IsiPhone5?548:460)]autorelease];
    _backImageView=[[[UIImageView alloc]initWithFrame:viewBack.bounds]autorelease];
    _backImageView.image=[UIImage imageNamed:@"BlueBackImage"];
    [viewBack addSubview:_backImageView];
    
//    _contentView=[[[UIView alloc]initWithFrame:_backImageView.frame]autorelease];
//    [self.view addSubview:_contentView];
    _contentView=[[[UIView alloc]initWithFrame:_backImageView.bounds]autorelease];
    [viewBack addSubview:_contentView];
    
    bottomToolbar=[[[UIView alloc]initWithFrame:CGRectMake(4, _backImageView.bounds.size.height-34, 312, 30)]autorelease];
    [viewBack addSubview:bottomToolbar];
    
    UIImageView *toolbarcenter=[[[UIImageView alloc]initWithFrame:CGRectMake(bottomToolbar.bounds.size.width/2-115, 0, 230, 30)]autorelease];
    toolbarcenter.image=[UIImage imageNamed:@"toolbarcenter"];
    [bottomToolbar addSubview:toolbarcenter];
    
    baseButton=[[[UIBaseButton alloc]initWithFrame:CGRectMake(0, 0, 80, 30)]autorelease];
    baseButton.offImageName=@"toolbarexit_off";
    baseButton.onImageName=@"toolbarexit_on";
    [baseButton renderImage];
    [bottomToolbar addSubview:baseButton];
    
    UIButton *btn=[[[UIButton alloc]initWithFrame:CGRectMake(bottomToolbar.bounds.size.width-80, 0, 80, 30)]autorelease];
    [btn setImage:[UIImage imageNamed:@"toolbarlanguage_off"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"toolbarlanguage_on"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(changeLanguage) forControlEvents:UIControlEventTouchUpInside];
    [bottomToolbar addSubview:btn];
    
    
    maskView=[[UIView alloc]initWithFrame:_backImageView.bounds];
    
}
-(void)changeLanguage{
//    Global set
    
}
-(void)renderImage{
    [baseButton renderImage];
}
-(void)setBottomBarHidden:(BOOL)BottomBarHidden{
    if (BottomBarHidden==YES) {
        bottomToolbar.hidden=YES;
    }else{
        bottomToolbar.hidden=NO;
    }
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
