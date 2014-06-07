//
//  GECKOViewController.m
//  moni_te
//
//  Created by wangbo on 6/7/14.
//  Copyright (c) 2014 wb. All rights reserved.
//

#import "GECKOViewController.h"
#import "ParamButtonView.h"
#import "UITabView.h"

static int g_tag;
static ParamButtonView *g_pbv;
static unsigned char result[11];

@interface GECKOViewController ()

@end

@implementation GECKOViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)didReceiveData:(NSData *)data{
    NSLog(@"dt:%@",data);
    
    unsigned char *tmp=data.bytes;
    result[0]=tmp[0];
    result[1]=tmp[1];
    result[2]=tmp[2];
    result[3]=tmp[3];
    result[4]=tmp[4];
    result[5]=tmp[5];
    result[6]=tmp[6];
    result[7]=tmp[7];
    result[8]=tmp[8];
    
    ParamButtonView *pbv=nil;
    for (int i=0; i<8; i++) {
        pbv=(ParamButtonView *)[self.contentView viewWithTag:(i+1)];
        pbv.valueString=[Global valueForKey:result[i] AtDictionary:self.dict[self.keyArray[i]]];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    unsigned char a=0xd8;
    [[NetUtils sharedInstance] sendData:[NSData dataWithBytes:&a length:1] withDelegate:self];
    self.keyArray=@[@"BrakeType",@"BatteryType",@"CutOffVoltageThreshold",@"LowVoltageCutOffType",@"StartUpStrength",@"MotorTiming",@"SBECVoltageOutput",@"MotorRotation",@"GovernorMode"];
    self.dict=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gecko" ofType:@"plist"]];
    
    self.backImageView.image=[UIImage imageNamed:@"FlashBackImage"];
    
    UITabView *tabView=[[[UITabView alloc]initWithFrame:CGRectMake(4, 3, self.contentView.bounds.size.width-8, self.contentView.bounds.size.height-6)]autorelease];
    [self.contentView addSubview:tabView];
    tabView.numberOfTabs=3;
    
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
