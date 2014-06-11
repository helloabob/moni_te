//
//  TURBOViewController.m
//  moni_te
//
//  Created by mac0001 on 6/10/14.
//  Copyright (c) 2014 wb. All rights reserved.
//

#import "TURBOViewController.h"

#import "ParamButtonView.h"
#import "TSLocateView.h"


static int g_tag;
static ParamButtonView *g_pbv;
static unsigned char result[33];

@interface TURBOViewController (){
    TSLocateView *locateView;
    UITabView *tabView;
    int currentTabIndex;
}

@end

@implementation TURBOViewController

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
    
//    unsigned char *tmp=data.bytes;
//    result[0]=tmp[0];
//    result[1]=tmp[1];
//    result[2]=tmp[2];
//    result[3]=tmp[3];
//    result[4]=tmp[4];
//    result[5]=tmp[5];
//    //    result[6]=tmp[6];
//    result[6]=tmp[7];
//    
//    ParamButtonView *pbv=nil;
//    for (int i=0; i<7; i++) {
//        pbv=(ParamButtonView *)[[tabView viewForIndex:1] viewWithTag:(i+1000)];
//        pbv.valueString=[Global valueForKey:result[i] AtDictionary:self.dict[self.keyArray[i]]];
//    }
    
    for (int i =1;i<7; i++) {
        UIView *view=[tabView viewForIndex:i];
        for (ParamButtonView *pbv in view.subviews) {
            if ([pbv isKindOfClass:[ParamButtonView class]]) {
                [pbv setValueWithArray:(unsigned char *)data.bytes];
            }
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self onRead];
//    unsigned char a=0xd8;
//    [[NetUtils sharedInstance] sendData:[NSData dataWithBytes:&a length:1] withDelegate:self];
    //    remove BEC Voltage Output
    //    self.keyArray=@[@"BrakeType",@"BatteryType",@"CutOffVoltageThreshold",@"LowVoltageCutOffType",@"StartUpStrength",@"MotorTiming",@"SBECVoltageOutput",@"MotorRotation"];
    self.keyArray=@[@"BrakeType",@"BatteryType",@"CutOffVoltageThreshold",@"LowVoltageCutOffType",@"StartUpStrength",@"MotorTiming",@"MotorRotation"];
    self.dict=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"gecko" ofType:@"plist"]];
    
    self.backImageView.image=[UIImage imageNamed:@"FlashBackImage"];
    self.BlackAreaHidden=NO;
    
    tabView=[[[UITabView alloc]initWithFrame:CGRectMake(4, 3, self.contentView.bounds.size.width-8, self.contentView.bounds.size.height-6)]autorelease];
    tabView.delegate=self;
    [self.contentView addSubview:tabView];
    tabView.numberOfTabs=8;
    
    int contentCenterY=self.contentView.bounds.size.height/2;
    
    /*tab 1*/
    UIView *view=[tabView viewForIndex:0];
    ParamButtonView *pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(1, contentCenterY-60, 100, 65) withImageName:@"device" withDelegate:self]autorelease];
    pbv.tag=500;
    [view addSubview:pbv];
    pbv.valueString=@"";
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(106, contentCenterY-60, 100, 65) withImageName:@"hardware" withDelegate:self]autorelease];
    pbv.tag=501;
    [view addSubview:pbv];
    pbv.valueString=@"";
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(211, contentCenterY-60, 100, 65) withImageName:@"software" withDelegate:self]autorelease];
    pbv.tag=502;
    [view addSubview:pbv];
    pbv.valueString=@"";
    
    /*tab 2*/
    view=[tabView viewForIndex:1];
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(1, contentCenterY-105, 100, 65) withImageName:@"promode" withDelegate:self]autorelease];
    pbv.tag=10000;
    [view addSubview:pbv];
    pbv.valueString=@"Unkown";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(106, contentCenterY-105, 100, 65) withImageName:@"runmode" withDelegate:self]autorelease];
    pbv.tag=1000;
    [view addSubview:pbv];
    pbv.valueString=@"Forword/Brake";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(211, contentCenterY-105, 100, 65) withImageName:@"voltagecutoff" withDelegate:self]autorelease];
    pbv.tag=1002;
    [view addSubview:pbv];
    pbv.valueString=@"Auto";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(1, contentCenterY-35, 100, 65) withImageName:@"escheatprotect" withDelegate:self]autorelease];
    pbv.tag=1003;
    [view addSubview:pbv];
    pbv.valueString=@"105 Degree Celsius";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(106, contentCenterY-35, 100, 65) withImageName:@"mr" withDelegate:self]autorelease];
    pbv.tag=1004;
    [view addSubview:pbv];
    pbv.valueString=@"reverse";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(211, contentCenterY-35, 100, 65) withImageName:@"becout" withDelegate:self]autorelease];
    pbv.tag=10000;
    [view addSubview:pbv];
    pbv.valueString=@"unknown";
    
    /*tab 3*/
    view=[tabView viewForIndex:2];
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(53, contentCenterY-105, 100, 65) withImageName:@"punchrate1" withDelegate:self]autorelease];
    pbv.tag=1006;
    [view addSubview:pbv];
    pbv.valueString=@"Unkown";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(158, contentCenterY-105, 100, 65) withImageName:@"punchrate2" withDelegate:self]autorelease];
    pbv.tag=1007;
    [view addSubview:pbv];
    pbv.valueString=@"Forword/Brake";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(1, contentCenterY-35, 100, 65) withImageName:@"threversespd" withDelegate:self]autorelease];
    pbv.tag=1001;
    [view addSubview:pbv];
    pbv.valueString=@"105 Degree Celsius";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(106, contentCenterY-35, 100, 65) withImageName:@"switchpoint1" withDelegate:self]autorelease];
    pbv.tag=1005;
    [view addSubview:pbv];
    pbv.valueString=@"reverse";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(211, contentCenterY-35, 100, 65) withImageName:@"thcurve" withDelegate:self]autorelease];
    pbv.tag=1008;
    [view addSubview:pbv];
    pbv.valueString=@"unknown";
    
    /*tab 4*/
    view=[tabView viewForIndex:3];
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(103, contentCenterY-120, 100, 65) withImageName:@"initialbrake" withDelegate:self]autorelease];
    pbv.tag=1011;
    [view addSubview:pbv];
    pbv.valueString=@"Unkown";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(1, contentCenterY-60, 100, 65) withImageName:@"dragbrake" withDelegate:self]autorelease];
    pbv.tag=1009;
    [view addSubview:pbv];
    pbv.valueString=@"Unkown";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(106, contentCenterY-60, 100, 65) withImageName:@"brakestrength" withDelegate:self]autorelease];
    pbv.tag=1010;
    [view addSubview:pbv];
    pbv.valueString=@"Forword/Brake";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(211, contentCenterY-60, 100, 65) withImageName:@"brakerate1" withDelegate:self]autorelease];
    pbv.tag=1013;
    [view addSubview:pbv];
    pbv.valueString=@"Auto";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(1, contentCenterY, 100, 65) withImageName:@"switchpoint2" withDelegate:self]autorelease];
    pbv.tag=1012;
    [view addSubview:pbv];
    pbv.valueString=@"105 Degree Celsius";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(106, contentCenterY, 100, 65) withImageName:@"brakerate2" withDelegate:self]autorelease];
    pbv.tag=1014;
    [view addSubview:pbv];
    pbv.valueString=@"reverse";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(211, contentCenterY, 100, 65) withImageName:@"brakecurve" withDelegate:self]autorelease];
    pbv.tag=1015;
    [view addSubview:pbv];
    pbv.valueString=@"unknown";
    
    /*tab 5*/
    view=[tabView viewForIndex:4];
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(53, contentCenterY-105, 100, 65) withImageName:@"boosttiming" withDelegate:self]autorelease];
    pbv.tag=1016;
    [view addSubview:pbv];
    pbv.valueString=@"Unkown";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(158, contentCenterY-105, 100, 65) withImageName:@"startrpm" withDelegate:self]autorelease];
    pbv.tag=1017;
    [view addSubview:pbv];
    pbv.valueString=@"Forword/Brake";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(1, contentCenterY-35, 100, 65) withImageName:@"endrpm" withDelegate:self]autorelease];
    pbv.tag=1018;
    [view addSubview:pbv];
    pbv.valueString=@"105 Degree Celsius";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(106, contentCenterY-35, 100, 65) withImageName:@"stability" withDelegate:self]autorelease];
    pbv.tag=1020;
    [view addSubview:pbv];
    pbv.valueString=@"reverse";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(211, contentCenterY-35, 100, 65) withImageName:@"slope" withDelegate:self]autorelease];
    pbv.tag=1019;
    [view addSubview:pbv];
    pbv.valueString=@"unknown";
    
    /*tab 6*/
    view=[tabView viewForIndex:5];
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(1, contentCenterY-105, 100, 65) withImageName:@"turbotiming" withDelegate:self]autorelease];
    pbv.tag=1021;
    [view addSubview:pbv];
    pbv.valueString=@"Unkown";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(106, contentCenterY-105, 100, 65) withImageName:@"activationmethod" withDelegate:self]autorelease];
    pbv.tag=1022;
    [view addSubview:pbv];
    pbv.valueString=@"Forword/Brake";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(211, contentCenterY-105, 100, 65) withImageName:@"turbodelay" withDelegate:self]autorelease];
    pbv.tag=1023;
    [view addSubview:pbv];
    pbv.valueString=@"Auto";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(1, contentCenterY-35, 100, 65) withImageName:@"startrpm" withDelegate:self]autorelease];
    pbv.tag=1024;
    [view addSubview:pbv];
    pbv.valueString=@"105 Degree Celsius";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(106, contentCenterY-35, 100, 65) withImageName:@"turboslopeon" withDelegate:self]autorelease];
    pbv.tag=1025;
    [view addSubview:pbv];
    pbv.valueString=@"reverse";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(211, contentCenterY-35, 100, 65) withImageName:@"turboslopeoff" withDelegate:self]autorelease];
    pbv.tag=1026;
    [view addSubview:pbv];
    pbv.valueString=@"unknown";
    
    /*tab 7*/
    view=[tabView viewForIndex:6];
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(106, contentCenterY-105, 100, 65) withImageName:@"battminvoltage" withDelegate:self]autorelease];
    pbv.tag=10000;
    [view addSubview:pbv];
    pbv.valueString=@"Forword/Brake";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(1, contentCenterY-35, 100, 65) withImageName:@"escmaxtemp" withDelegate:self]autorelease];
    pbv.tag=10000;
    [view addSubview:pbv];
    pbv.valueString=@"105 Degree Celsius";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(106, contentCenterY-35, 100, 65) withImageName:@"motmaxtemp" withDelegate:self]autorelease];
    pbv.tag=10000;
    [view addSubview:pbv];
    pbv.valueString=@"reverse";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(211, contentCenterY-35, 100, 65) withImageName:@"motmaxrpm" withDelegate:self]autorelease];
    pbv.tag=10000;
    [view addSubview:pbv];
    pbv.valueString=@"unknown";
    
    self.SettingControlViewHidden=NO;
    
}
-(void)viewDidTapped:(ParamButtonView *)sender{
    if (sender.tag<1000) {
        return;
    }
    if (g_tag==sender.tag) {
        return;
    }
    g_pbv=sender;
    g_tag=sender.tag;
    NSDictionary *tmp=nil;
    tmp=self.dict[self.keyArray[sender.tag-1000]];
    if (tmp==nil) {
        return;
    }
    NSArray *array=[Global convertStringToArray:tmp forKey:@"ValuesRange"];
    
    if (locateView!=nil) {
        [locateView hidePicker];
        locateView=nil;
    }
    
    locateView = [[TSLocateView alloc] initWithTitle:@"" delegate:self];
    locateView.provinces=array;
    [locateView showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0) {
    }else {
        TSLocateView *tv=(TSLocateView *)actionSheet;
        NSDictionary *tmp=nil;
        tmp=self.dict[self.keyArray[g_tag-1000]];
        g_pbv.valueString=tv.provinces[tv.selectedIndex];
        result[g_tag-1000]=[Global dataFromDict:tmp AtIndex:tv.selectedIndex];
    }
    g_pbv=nil;
    g_tag=0;
}
-(void)onRead{
//    unsigned char a=0xd8;
//    [[NetUtils sharedInstance] sendData:[NSData dataWithBytes:&a length:1] withDelegate:self];
}
-(void)onSet{
    int send_length=7;
    unsigned char addons[send_length];
    addons[0]=0xe2;
    addons[1]=0xe3;
    addons[2]=0xe4;
    addons[3]=0xea;
    addons[4]=0xe9;
    addons[5]=0xe5;
    //    addons[6]=0xe6;
    addons[6]=0xe8;
    unsigned char ret[send_length*2];
    for (int i=0; i<send_length; i++) {
        ret[i*2]=addons[i];
        ret[i*2+1]=result[i];
    }
    [[NetUtils sharedInstance] sendData:[NSData dataWithBytes:ret length:send_length*2] withDelegate:nil];
}
-(void)viewDidChanged:(int)index{
    currentTabIndex=index;
    if (index==0) {
        self.SettingControlViewHidden=YES;
    }else{
        self.SettingControlViewHidden=NO;
    }
}
-(BOOL)tabDidClicked:(int)index{
    if (index==7) {
//        UIView *view=[tabView viewForIndex:1];
//        for (ParamButtonView *pbv in view.subviews) {
//            NSDictionary *tmp=nil;
//            tmp=self.dict[self.keyArray[pbv.tag-1000]];
//            NSArray *values=[Global convertStringToArray:tmp forKey:@"ValuesRange"];
//            int defaultKey=[tmp[@"DefaultKey"] intValue];
//            pbv.valueString=values[defaultKey];
//            result[g_tag-1000]=[Global dataFromDict:tmp AtIndex:defaultKey];
//        }
        return NO;
    }else if(index==3){
        [self changeSettingY:20];
    }else{
        [self changeSettingY:0];
    }
    return YES;
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