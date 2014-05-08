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
    


	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//友盟打点数据
-(void)uMengClick:(NSString *) event{
    [MobClick event:event];
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
    
    return array;
}

-(void)playChuishsao{
    [self initSound:@"whistle.mp3"];
}

-(void)playNahan{
    [self initSound:@"failshout.mp3"];
}

-(void)playHuanhu{
    [self initSound:@"hiscore02.mp3"];
}

-(void)playGuzhang{
    [self initSound:@"normalscore.mp3"];
}


-(void) initSound:(NSString *)soundName{
    NSString *path = [NSString stringWithFormat: @"%@/%@",
                      [[NSBundle mainBundle] resourcePath], soundName];
    
    NSURL* filePath = [NSURL fileURLWithPath: path isDirectory: NO];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &soundID);
    AudioServicesPlaySystemSound(soundID);
}

@end
