//
//  UCIBaseViewController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-3-12.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIBaseViewController.h"
#import "MobClick.h"

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
//    [MobClick event:event];
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
@end
