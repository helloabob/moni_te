//
//  BaseViewController.m
//  moni_te
//
//  Created by wangbo on 5/30/14.
//  Copyright (c) 2014 wb. All rights reserved.
//

#import "BaseViewController.h"
#import "ExitViewController.h"
#import "SettingControlView.h"

@interface BaseViewController (){
    UIView *bottomToolbar;
    UIBaseButton *baseButton;
//    UIView *maskView;
    SettingControlView *scv;
}

@end

@implementation BaseViewController
-(void)dealloc{
    self.dict=nil;
    self.keyArray=nil;
    [super dealloc];
}
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
    [baseButton addTarget:self action:@selector(onExit) forControlEvents:UIControlEventTouchUpInside];
    [baseButton renderImage];
    [bottomToolbar addSubview:baseButton];
    
    UIButton *btn=[[[UIButton alloc]initWithFrame:CGRectMake(bottomToolbar.bounds.size.width-80, 0, 80, 30)]autorelease];
    [btn setImage:[UIImage imageNamed:@"toolbarlanguage_off"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"toolbarlanguage_on"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(changeLanguage) forControlEvents:UIControlEventTouchUpInside];
    [bottomToolbar addSubview:btn];
    
    
//    maskView=[[UIView alloc]initWithFrame:_backImageView.bounds];
    
    scv=[[[SettingControlView alloc]initWithFrame:CGRectMake(10, self.contentView.bounds.size.height-100-50, 300, 100)]autorelease];
    scv.hidden=YES;
    [scv addTarget:self actionRead:@selector(onRead) actionSet:@selector(onSet)];
    [self.contentView addSubview:scv];
    
}
-(void)onRead{
    
}
-(void)onSet{
    
}
-(void)onExit{
    ExitViewController *vc=[[[ExitViewController alloc]init]autorelease];
    vc.isExit=YES;
    [self.navigationController pushViewController:vc animated:NO];
}
-(void)changeLanguage{
//    Global set
    ExitViewController *vc=[[[ExitViewController alloc]init]autorelease];
    [self.navigationController pushViewController:vc animated:NO];
}
-(void)renderImage{
    [baseButton renderImage];
    [scv renderImage];
    for (id view in self.contentView.subviews) {
        if ([view respondsToSelector:@selector(renderImage)]) {
            [view renderImage];
        }
    }
}
-(void)setSettingControlViewHidden:(BOOL)SettingControlViewHidden{
    scv.hidden=SettingControlViewHidden;
    [self.contentView bringSubviewToFront:scv];
}
-(void)setBottomBarHidden:(BOOL)BottomBarHidden{
    bottomToolbar.hidden=BottomBarHidden;
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
