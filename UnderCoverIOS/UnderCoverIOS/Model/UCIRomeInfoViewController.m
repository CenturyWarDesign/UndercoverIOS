//
//  UCIRomeInfoViewController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-5-21.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIRomeInfoViewController.h"
#import "UCIAppDelegate.h"

@interface UCIRomeInfoViewController ()

@end

@implementation UCIRomeInfoViewController

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
    
    
    timerCheck= [NSTimer  timerWithTimeInterval:1.0 target:self selector:@selector(checkFlash)userInfo:nil repeats:YES];
    timerReflash= [NSTimer  timerWithTimeInterval:20.0 target:self selector:@selector(reflash)userInfo:nil repeats:YES];
    
    
    [[NSRunLoop currentRunLoop]addTimer:timerCheck forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop]addTimer:timerReflash forMode:NSDefaultRunLoopMode];

     [self reflash];
}

-(void)viewWillDisappear:(BOOL)animated{
    //注意，这里添加的定时器必须给清理掉，不然退出的时候会一直运行
    [timerCheck invalidate];
    [timerReflash invalidate];
}


-(void)checkFlash{
    int a=[UCIAppDelegate messageHandler];
    if(a>0){
        NSLog(@"reflash");
        [UCIAppDelegate clearHandler];
        [self reflash];
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
-(void) reflash{
    HTTPBase *classBtest = [[HTTPBase alloc] init];
    classBtest.delegate = self;
    [classBtest baseHttp:@"RoomGetContent"];
}
- (IBAction)btnReflash:(id)sender {
    [self reflash];
}

//退出房间
- (IBAction)btnLevelRoom:(id)sender {
    HTTPBase *classBtest = [[HTTPBase alloc] init];
    classBtest.delegate = self;
    [classBtest baseHttp:@"RoomLevel"];
}

-(void)callBack:(NSDictionary *)data commandName:(NSString*) command{
    if([command isEqualToString:@"RoomGetContent"]){
        NSString *roomid=[data objectForKey:@"roomid"];
        NSString *content=[data objectForKey:@"content"];
        NSString *gamename=[data objectForKey:@"gamename"];
//        NSString *createtime=[data objectForKey:@"createtime"];
        if(roomid==nil){
            [self showAlert:@"" content:@"房间已经不存在"];
//            [self performSegueWithIdentifier:@"backRoomSetting" sender:self];
            [UCIAppDelegate setRoomPush:@""];
        }
        [self.labRoomId setText:roomid];
        [self.labContent setText:content];
        [self.labGameName setText:gamename];
        NSLog(@"RoomGetContent 函数的回调");
    }
    else if([command isEqualToString:@"RoomLevel"]){
        [self performSegueWithIdentifier:@"backRoomSetting" sender:self];
        [UCIAppDelegate setRoomPush:@""];
        NSLog(@"RoomLevel 函数的回调");
    }
}
@end
