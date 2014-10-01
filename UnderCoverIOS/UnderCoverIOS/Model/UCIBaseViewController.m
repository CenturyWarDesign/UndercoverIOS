//
//  UCIBaseViewController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-3-12.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIBaseViewController.h"
#import "MobClick.h"
#import <AudioToolbox/AudioToolbox.h>
#import "UCIAppDelegate.h"
#import "AFNetworking.h"
@interface UCIBaseViewController ()

@end

@implementation UCIBaseViewController

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

    NSString * httpurl=[MobClick getConfigParams:@"httpurl"];
    //从友盟取到网络地址
    [self setObjectFromDefault:httpurl key:@"httpurl"];
    
    
    NSString * homepage=[MobClick getConfigParams:@"homepage"];
    //从友盟取到网络地址
    [self setObjectFromDefault:homepage key:@"homepage"];
    
    timerSec= [NSTimer  timerWithTimeInterval:1.0 target:self selector:@selector(reflashOneSec)userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:timerSec forMode:NSDefaultRunLoopMode];
	// Do any additional setup after loading the view.
}

//每秒刷新动作
-(void)reflashOneSec{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //注意，这里添加的定时器必须给清理掉，不然退出的时候会一直运行
    [timerSec invalidate];
 
}

//友盟打点数据
-(void)uMengClick:(NSString *) event{
    if([event isEqual:@""])
        return;
    [MobClick event:event];
    [self ClickToServer:event];
}

//友盟打点数据
-(void)uMengValue:(NSString *) event val:(int)value{
    if([event isEqual:@""])
        return;
    NSString *numberKey = @"__ct__";
    NSMutableDictionary *mutableDictionary = [[NSMutableDictionary alloc] init];
    [mutableDictionary setObject:[NSString stringWithFormat:@"%d",value] forKey:numberKey];
    [MobClick event:event attributes:mutableDictionary];
    
    [self ClickToServer:event];
}


-(void)ClickToServer:(NSString *)event{
        HTTPBase *classBtest = [[HTTPBase alloc] init];
        classBtest.delegate = self;
        [classBtest baseHttp:@"BehaveAdd" paramsdata:[NSDictionary dictionaryWithObjectsAndKeys: event,@"behave",nil]];
}
-(void)callBack:(NSArray *)data commandName:(NSString*) command code:(int)code{
    if(code==1000||code==0){
         [self callBack:data commandName:command ];
        return;
    }
    switch (code) {
        case 1101:
            [self callback:code];
            [self showAlert:@"" content:@"房间号不正确或已退出房间"];
            break;
            
        default:
            break;
    }
   
}

-(void)callback:(int)code
{
    
}

-(void)callBack:(NSArray *)data commandName:(NSString*) command{
}

//取持久化对象
-(id) getObjectFromDefault:(NSString *)key{
    NSUserDefaults *persistentDefaults=[NSUserDefaults standardUserDefaults];
    return [persistentDefaults objectForKey:key];
}
//设置持久化对象
-(void) setObjectFromDefault:(NSObject *)object key:(NSString *)key{
    NSUserDefaults *persistentDefaults=[NSUserDefaults standardUserDefaults];
     [persistentDefaults setObject:object forKey:key];
}





- (void)timerFireMethod:(NSTimer*)theTimer
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    
    promptAlert =NULL;
}


- (void)showAlert:(NSString *)title content:(NSString *) content
{
    
//    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"my test title" message:@"my test message 1" delegate:self cancelButtonTitle:@"yes" otherButtonTitles:@"no",@"what", @"you sure", nil];
//    [alertView show];
//    return;
    
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:title message:content delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:NO];
    
    [promptAlert show];
}

//取得所有词汇，包括本地的和网络的
-(NSArray *)getAllWords{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"];
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
    NSString * wordstring=[MobClick getConfigParams:@"under_string_version"];
    

    //    NSString* str = @"here be dragons";
    NSArray * wordArray= [wordstring componentsSeparatedByString:@"\n"];
    for (int i=0; i<[wordArray count]; i++) {
        [array addObject:[wordArray objectAtIndex:i]];
    }
    NSMutableArray *array2=[[NSMutableArray alloc] init];
    
    //排除已经玩过的词汇
    NSMutableArray * hasreturn =[self getObjectFromDefault:@"hasPlayed"];
    for (int j=0; j<[array count]; j++) {
        if(![hasreturn containsObject:[array objectAtIndex:j ]])
        {
            [array2 addObject:[array objectAtIndex:j ]];
        }
    }
    if([array2 count]<20){
        array2=array;
        [self setObjectFromDefault:NULL key:@"hasPlayed"];
    }
    
    return array2;
}



//已经玩过的词汇
-(void)hasPlayed:(NSString *)words{
    NSMutableArray * hasreturn =[[NSMutableArray alloc] initWithArray:[self getObjectFromDefault:@"hasPlayed"]];
    if(hasreturn==nil)
    {
        hasreturn =[[NSMutableArray alloc]init];
    }
    [hasreturn addObject:words];
    [self setObjectFromDefault:hasreturn key:@"hasPlayed"];
}


-(void)playChuishao{
    if (![self getSoundStatus]) {
        return;
    }
    
    [self initSound:@"whistle.mp3"];
}

-(void)playNahan{
    if (![self getSoundStatus]) {
        return;
    }
    
    [self initSound:@"failshout.mp3"];
}

-(void)playHuanhu{
    if (![self getSoundStatus]) {
        return;
    }
    
    [self initSound:@"hiscore02.mp3"];
}

-(void)playGuzhang{
    if (![self getSoundStatus]) {
        return;
    }
    
    [self initSound:@"normalscore.mp3"];
}

-(BOOL)getSoundStatus
{
    id value = [self getObjectFromDefault:@"ISOPENSOUND"];
    
    return [value boolValue];
}


-(void) initSound:(NSString *)soundName{
    NSString *path = [NSString stringWithFormat: @"%@/%@",
                      [[NSBundle mainBundle] resourcePath], soundName];
    
    NSURL* filePath = [NSURL fileURLWithPath: path isDirectory: NO];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &soundID);
    AudioServicesPlaySystemSound(soundID);
}


-(void)addliketoDefault:(NSString *)word{
    NSMutableArray * punisharr=[[NSMutableArray alloc]init];
    [punisharr addObjectsFromArray: (NSMutableArray *)[self getObjectFromDefault:@"punisharray"]];
    if(![punisharr containsObject:word]){
        [punisharr addObject:word];
    }
    [self setObjectFromDefault:punisharr key:@"punisharray"];
}
-(void)removeliketoDefault:(NSString *)word{
    NSMutableArray * punisharr=[[NSMutableArray alloc]init];
    [punisharr addObjectsFromArray: (NSMutableArray *)[self getObjectFromDefault:@"punisharray"]];
    if([punisharr containsObject:word]){
        [punisharr removeObject:word];
        [self setObjectFromDefault:punisharr key:@"punisharray"];
    }
}


//返回基础原型按键
-(UIButton *)getCircleBtn:(int) width{
    UIButton *someAddButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    someAddButton.backgroundColor = [UIColor clearColor];
    //        [someAddButton setBackgroundImage:[UIImage imageNamed:@"cerlightblue01.png"] forState:UIControlStateNormal];
    someAddButton.layer.borderWidth=1;
    someAddButton.layer.borderColor=[UIColor greenColor].CGColor;
//    someAddButton.layer.cornerRadius=width/2;
    UIEdgeInsets insets = {width-20, 0 , 0, 0};
    someAddButton.titleEdgeInsets=insets;
    someAddButton.layer.masksToBounds=YES;
    return someAddButton;

}

-(NSString *)getConfig:(NSString *)key{
 return [UCIAppDelegate getConfig:key];
}

-(void)setBadgeValue:(int)val
{
    if(val>0){
        self.tabBarItem.badgeValue=[NSString stringWithFormat:@"%d",val];
    }else{
        self.tabBarItem.badgeValue=nil;
    }


}


- (void)sessionDownload:(NSString *)urlString
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    
 
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        // 指定下载文件保存的路径
        //        NSLog(@"%@ %@", targetPath, response.suggestedFilename);
        // 将下载文件保存在缓存路径中
        NSString *cacheDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSString *path = [cacheDir stringByAppendingPathComponent:response.suggestedFilename];
        
        // URLWithString返回的是网络的URL,如果使用本地URL,需要注意
        NSURL *fileURL1 = [NSURL URLWithString:path];
        NSURL *fileURL = [NSURL fileURLWithPath:path];
        
        NSLog(@"== %@ |||| %@", fileURL1, fileURL);
        
        return fileURL;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"%@ %@", filePath, error);
    }];
    
    [task resume];
}

-(NSString *)intToString:(int) input{
    return [NSString stringWithFormat:@"%d",input];
}

@end
