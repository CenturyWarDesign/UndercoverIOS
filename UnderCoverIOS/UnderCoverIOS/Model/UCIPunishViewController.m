//
//  UCIPunishViewController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-3-12.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIPunishViewController.h"

@interface UCIPunishViewController ()

@end

@implementation UCIPunishViewController

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
    
//    NSString * temstring=[self getObjectFromDefault:@"tem"];
//    [self setObjectFromDefault:@"wanbin" key:@"tem"];
//    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//一个新词汇
- (IBAction)clickNew:(id)sender {
    [self initnewword];
    [self uMengClick:@"click_reflash"];
}

-(void) reflashWords:(NSString *)words{
    self.publishWords.text=words;
    punishText=words;
}


-(void)initnewword{
    [self playGuzhang];
    NSMutableArray * punisharr=[[NSMutableArray alloc]init];
    [punisharr addObjectsFromArray: (NSMutableArray *)[self getObjectFromDefault:@"punisharray"]];
    
    
    if([punisharr count]<100){
        srand((unsigned)time(0));
        int randisdefault=rand()%100;
        if(randisdefault>[punisharr count]){
            NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"punish" ofType:@"plist"];
            punisharr = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
        }
    }
    
    srand((unsigned)time(0));
    int i=rand()%[punisharr count];
    [self reflashWords:[punisharr objectAtIndex:i]];
    
    //摇一摇
    [self uMengClick:@"punish_shack"];
}
-(void)initwordfromnet{
    HTTPBase *classBtest = [[HTTPBase alloc] init];
    classBtest.delegate = self;
    [classBtest baseHttp:@"PublishRandomOne"];
}


////以下为摇啊摇代码

-(BOOL)canBecomeFirstResponder {
    return YES;
}

//-(void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    [self becomeFirstResponder];
//}

- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}
- (IBAction)netPunish:(id)sender {
    //点击网络版
    [self uMengClick:@"click_intenet"];
    
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        [self initnewword];
        NSLog(@"摇啊摇");
    }
    [self uMengClick:@"shack"];
}
////以上为摇啊摇代码



- (IBAction)btnShare:(id)sender {
    [self shareSomeThing:punishText imageName:@""];
}

-(void)callBack:(NSDictionary *)data commandName:(NSString*) command{
    if([command isEqualToString:@"PublishRandomOne"]){
        NSArray * punishArr=[data objectForKey:@"content"];
        if([punishArr count]>0){
            NSDictionary * contentone=[punishArr objectAtIndex:0];
            [self reflashWords:[contentone objectForKey:@"content"]];
        }
        else{
            [self reflashWords:@"可以免除惩罚"];
        }
        
        NSLog(@"PublishRandomOne 函数的回调");
    }
}


//从网上获取喜欢的真心话大冒险,以后每次维护
-(void)getPunishFromNet{
    HTTPBase *classBtest = [[HTTPBase alloc] init];
    classBtest.delegate = self;
    [classBtest baseHttp:@"PublishRandomOne"];
}

@end
