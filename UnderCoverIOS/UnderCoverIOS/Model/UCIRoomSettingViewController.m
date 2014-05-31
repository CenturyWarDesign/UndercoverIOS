//
//  UCIRoomSettingViewController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-5-21.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIRoomSettingViewController.h"
#import "UCIAppDelegate.h"

@interface UCIRoomSettingViewController ()

@end

@implementation UCIRoomSettingViewController

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
    [self.labRoomId setText:[self getObjectFromDefault:@"gameuid"]];
    
    
    timerCheck= [NSTimer  timerWithTimeInterval:1.0 target:self selector:@selector(checkFlash)userInfo:nil repeats:YES];
    timerReflash= [NSTimer  timerWithTimeInterval:20.0 target:self selector:@selector(reflash)userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop]addTimer:timerCheck forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop]addTimer:timerReflash forMode:NSDefaultRunLoopMode];
    
    [self reflash];
    
//    [UIApplication mess]
    // Do any additional setup after loading the view.
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

-(void) reflash{
    HTTPBase *classBtest = [[HTTPBase alloc] init];
    classBtest.delegate = self;
    [classBtest baseHttp:@"RoomGetInfo"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)callBack:(NSDictionary *)data commandName:(NSString*) command{
    if([command isEqualToString:@"RoomGetInfo"]){
        userinfo=[data objectForKey:@"room_user"];
        if([userinfo count]==0){
            [self showAlert:@"" content:@"未取得任何房间信息，请重新创建"];
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        [self ReflashUsers:userinfo];
        NSLog(@"RoomGetInfo 函数的回调");
    }else if([command isEqualToString:@"RoomLevel"]){
        [self setObjectFromDefault:@"" key:@"roomtype"];
//        [self dismissViewControllerAnimated:false completion:nil];
        
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"RoomLevel 函数的回调");
    }
    else if([command isEqualToString:@"RoomStartGame"]){
        datatosend=data;
        if(gametype==1){
            [self performSegueWithIdentifier:@"gameundercover" sender:self];
        }else if(gametype==2){
            [self performSegueWithIdentifier:@"gameKiller" sender:self];
        }
        NSLog(@"RoomStartGame 函数的回调");
        [self setBtnEnable];
    }
    else if([command isEqualToString:@"RoomRemoveSomeone"]){
        [self showAlert:@"" content:@"删除玩家成功"];
        [self reflash];
        NSLog(@"RoomRemoveSomeone 函数的回调");
    }

}

//在这里画出玩家
-(void)ReflashUsers:(NSMutableArray *) userarray{
    int width=self.scrollUsers.bounds.size.width;

    int btnWidth=(width-30)/4;
    int btnHeight=btnWidth;

    for (UIView *view_ in _scrollUsers.subviews) {
        if (view_.tag == 1) {
            [view_ removeFromSuperview];
        }
    }
    //这里判断，玩家名字一样的话，特别显示
    NSMutableArray * usernamearray=[[NSMutableArray alloc] init];
    
    for(int i=0;i<[userarray count];i++){
        CGRect frame = CGRectMake((btnWidth+5)*(i%4)+10, (i/4)*(btnHeight+10), btnWidth, btnHeight);
        
        UIButton *someAddButton = [self getCircleBtn:btnWidth];
        
        NSString * userName=[(NSMutableDictionary *)[userarray objectAtIndex:i] objectForKey:@"username"];
        [someAddButton setTitle:userName forState:UIControlStateNormal];
        if ([usernamearray containsObject:userName]) {
            someAddButton.layer.borderColor=[UIColor redColor].CGColor;
        }
        [usernamearray addObject:userName];
        
        someAddButton.frame = frame;
        [someAddButton setTag:i];
        //点击删除某个玩家
        
        [someAddButton addTarget:self action:@selector(tapPeople:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollUsers addSubview:someAddButton];
    }
}

-(void)tapPeople:(UIButton *)sender{
    int tag=(int)sender.tag;
    HTTPBase *classBtest = [[HTTPBase alloc] init];
    NSString * gameuid= [[userinfo objectAtIndex:tag]objectForKey:@"gameuid"];
    classBtest.delegate = self;
    [classBtest baseHttp:@"RoomRemoveSomeone" paramsdata:[NSDictionary dictionaryWithObjectsAndKeys:gameuid,@"gameuid",nil]];
    gametype=1;
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
- (IBAction)btnLevel:(id)sender {
    HTTPBase *classBtest = [[HTTPBase alloc] init];
    classBtest.delegate = self;
    [classBtest baseHttp:@"RoomLevel"];
}

- (IBAction)btnStartUndercover:(id)sender {
    HTTPBase *classBtest = [[HTTPBase alloc] init];
    classBtest.delegate = self;
    [classBtest baseHttp:@"RoomStartGame" paramsdata:[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"type",nil]];
    gametype=1;
    [self uMengClick:@"room_undercover"];
        [self setBtnDisable];
}

//开始杀人游戏
- (IBAction)btnStartKiller:(id)sender {
    HTTPBase *classBtest = [[HTTPBase alloc] init];
    classBtest.delegate = self;
    [classBtest baseHttp:@"RoomStartGame" paramsdata:[NSDictionary dictionaryWithObjectsAndKeys:@"2",@"type",nil]];
    gametype=2;
    [self uMengClick:@"room_killer"];
        [self setBtnDisable];
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"gameundercover"]) //"goView2"是SEGUE连线的标识
    {
        id theSegue = segue.destinationViewController;
        //界面之间进行传值,把创建游戏的数据发过来
        [theSegue setValue:datatosend forKey:@"gameData"];
    }
    else if([segue.identifier isEqualToString:@"gameKiller"]) //"goView2"是SEGUE连线的标识
    {
        id theSegue = segue.destinationViewController;
        //界面之间进行传值,把创建游戏的数据发过来
        [theSegue setValue:datatosend forKey:@"gameData"];
    }

    
}


-(void) setBtnDisable{
    [self.btnDouble setEnabled:false];
    [self.btnKiller setEnabled:false];
    [self.btnUndercover setEnabled:false];
    
}
-(void) setBtnEnable{
    [self.btnDouble setEnabled:true];
    [self.btnKiller setEnabled:true];
    [self.btnUndercover setEnabled:true];
}
//提示房间信息
- (IBAction)btnInfo:(id)sender {
    [self showAlert:@"" content:@"玩家输入该房间号即可开启网络模式"];
}

@end
