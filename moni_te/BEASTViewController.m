//
//  BEASTViewController.m
//  moni_te
//
//  Created by wangbo on 6/1/14.
//  Copyright (c) 2014 wb. All rights reserved.
//

#import "BEASTViewController.h"
#import "SettingControlView.h"
#import "ParamButtonView.h"
#import "TSLocateView.h"

static int g_tag;
static ParamButtonView *g_pbv;
static unsigned char result[11];

@interface BEASTViewController (){
    UIImageView *logo;
    TSLocateView *locateView;
}
@property(nonatomic,retain)NSDictionary *dict;
@property(nonatomic,retain)NSArray *keyArray;

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
-(void)didReceiveData:(NSData *)data{
    NSLog(@"dt:%@",data);
    
    unsigned char *tmp=data.bytes;
    result[0]=tmp[0];
    result[1]=tmp[2];
    result[2]=tmp[3];
    result[3]=tmp[4];
    result[4]=tmp[5];
    result[5]=tmp[6];
    result[6]=tmp[7];
    result[7]=tmp[8];
    result[8]=tmp[10];
    result[9]=tmp[11];
    result[10]=tmp[12];
    
    ParamButtonView *pbv=nil;
    for (int i=0; i<10; i++) {
        pbv=(ParamButtonView *)[self.contentView viewWithTag:(i+1)];
        pbv.valueString=[self valueForKey:result[i] AtDictionary:self.dict[_keyArray[i]]];
    }
}
-(NSArray *)convertStringToArray:(NSString *)values{
    NSArray *array=nil;
    if ([values rangeOfString:@","].length==0) {
        if ([values rangeOfString:@"-"].length>0) {
            NSArray *arr=[values componentsSeparatedByString:@"-"];
            int start=[arr[0] intValue];
            int end=[arr[1] intValue];
            NSMutableArray *ar=[NSMutableArray array];
            for (int i=start; i<=end; i++) {
                [ar addObject:[NSString stringWithFormat:@"%d",i]];
            }
            array=[NSArray arrayWithArray:ar];
        }else{
            return nil;
        }
    }else{
        array=[values componentsSeparatedByString:@","];
    }
    return array;
}
-(NSString *)valueForKey:(unsigned char)key AtDictionary:(NSDictionary *)dic{
    NSArray *array=[self convertStringToArray:dic[@"KeysRange"]];
    int index=-1;
    for (int i=0; i<array.count; i++) {
        if ([array[i] intValue]==key) {
            index=i;
            break;
        }
    }
    if (index==-1) {
        index=[dic[@"DefaultKey"] intValue];
    }
    if (index>-1) {
        NSArray *arr=[self convertStringToArray:dic[@"ValuesRange"]];
        return arr[index];
    }
    return nil;
}
-(void)onRead{
    unsigned char a=0xd8;
    [[NetUtils sharedInstance] sendData:[NSData dataWithBytes:&a length:1] withDelegate:self];
}
-(void)onSet{
    unsigned char addons[11];
    addons[0]=0xec;
    addons[1]=0xe2;
    addons[2]=0xe3;
    addons[3]=0xe4;
    addons[4]=0xe5;
    addons[5]=0xe6;
    addons[6]=0xe7;
    addons[7]=0xe8;
    addons[8]=0xea;
    addons[9]=0xeb;
    addons[10]=0xa1;
    
    unsigned char ret[22];
    for (int i=0; i<11; i++) {
        ret[i*2]=addons[i];
        ret[i*2+1]=result[i];
    }
    
    [[NetUtils sharedInstance] sendData:[NSData dataWithBytes:ret length:22] withDelegate:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    unsigned char a=0xd8;
    [[NetUtils sharedInstance] sendData:[NSData dataWithBytes:&a length:1] withDelegate:self];
    self.keyArray=@[@"CutOffVoltage",@"RunningMode",@"PercentageBraking",@"PercentageDragBrake",@"MotorTiming",@"InitialAcceleration",@"ThrottleLimit",@"ThrottlePercentReverse",@"NeutralRange",@"MotorRotation"];
    self.dict=[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"beast" ofType:@"plist"]];
    
    self.backImageView.image=[UIImage imageNamed:@"FlashBackImage"];
    self.SettingControlViewHidden=NO;
    
    ParamButtonView *pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(110, 30, 100, 65) withImageName:@"runningmode" withDelegate:self]autorelease];
    pbv.tag=2;
    [self.contentView addSubview:pbv];
    pbv.valueString=@"Forward/Reverse";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(5, 100, 100, 65) withImageName:@"mt" withDelegate:self]autorelease];
    pbv.tag=5;
    [self.contentView addSubview:pbv];
    pbv.valueString=@"Normal";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(110, 100, 100, 65) withImageName:@"ic" withDelegate:self]autorelease];
    pbv.tag=6;
    [self.contentView addSubview:pbv];
    pbv.valueString=@"High";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(215, 100, 100, 65) withImageName:@"mr" withDelegate:self]autorelease];
    pbv.tag=10;
    [self.contentView addSubview:pbv];
    pbv.valueString=@"Normal";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(5, 170, 100, 65) withImageName:@"tpr" withDelegate:self]autorelease];
    pbv.tag=8;
    [self.contentView addSubview:pbv];
    pbv.valueString=@"60%";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(110, 170, 100, 65) withImageName:@"tl" withDelegate:self]autorelease];
    pbv.tag=7;
    [self.contentView addSubview:pbv];
    pbv.valueString=@"50%";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(215, 170, 100, 65) withImageName:@"nr" withDelegate:self]autorelease];
    pbv.tag=9;
    [self.contentView addSubview:pbv];
    pbv.valueString=@"4%";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(5, 240, 100, 65) withImageName:@"pb" withDelegate:self]autorelease];
    pbv.tag=3;
    [self.contentView addSubview:pbv];
    pbv.valueString=@"50%";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(110, 240, 100, 65) withImageName:@"pdb" withDelegate:self]autorelease];
    pbv.tag=4;
    [self.contentView addSubview:pbv];
    pbv.valueString=@"0%";
    
    pbv=[[[ParamButtonView alloc]initWithFrame:CGRectMake(215, 240, 100, 65) withImageName:@"cov" withDelegate:self]autorelease];
    pbv.tag=1;
    [self.contentView addSubview:pbv];
    pbv.valueString=@"3.0V/Cell";
}
-(void)viewDidTapped:(ParamButtonView *)sender{
    
    if (g_tag==sender.tag) {
        return;
    }
    g_pbv=sender;
    g_tag=sender.tag;
    NSDictionary *tmp=nil;
    tmp=_dict[_keyArray[sender.tag-1]];
    if (tmp==nil) {
        return;
    }
    NSArray *array=[self convertStringToArray:tmp[@"ValuesRange"]];
    
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
        NSLog(@"Cancel");
    }else {
        NSLog(@"Select");
        TSLocateView *tv=(TSLocateView *)actionSheet;
        NSDictionary *tmp=nil;
        tmp=_dict[_keyArray[g_tag-1]];
        g_pbv.valueString=tv.provinces[tv.selectedIndex];
    }
    g_pbv=nil;
    g_tag=0;
}
-(unsigned char)dataFromDict:(NSDictionary *)dic AtIndex:(int)index{
    NSArray *array=[self convertStringToArray:dic[@"KeysRange"]];
    int ret=[array[index] intValue];
    unsigned char a=ret;
    return a;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)enter{
    [logo removeFromSuperview];
    self.backImageView.image=[UIImage imageNamed:@"FlashBackImage"];
    
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
