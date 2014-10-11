//
//  UCIRoomHomeViewController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-5-21.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIRoomHomeViewController.h"
#import "UCIAppDelegate.h"
#import "HTTPBase.h"


@interface UCIRoomHomeViewController ()

@end

@implementation UCIRoomHomeViewController

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
    [self uMengClick:@"game_net"];
    bool isonline=UCIAppDelegate.isConnectionAvailable;
   
    if(!isonline){
        [self showAlert:@"提示" content:@"网络连接异常，无法进行游戏"];
        return;
    }
    
    [self.loadIng setHidden:true];
    
    NSString *username=[self getObjectFromDefault:@"username"];
    
    if([username length]==0){
        [self performSegueWithIdentifier:@"changeName" sender:self];
        return;
    }
    
    [self checkIsInRoom];
    //如果已经设置过姓名，则跳过
    
    [self setEnable];
    // Do any additional setup after loading the view.
}

-(IBAction) checkIsInRoom{
    int roomid=[[self getObjectFromDefault:@"roomid"] intValue];
    //如果已经在一个房间内，那么直接跳过去
    NSString *roomtype= [self getObjectFromDefault:@"roomtype"];
    if([roomtype isEqualToString:@"create"]&&roomid>0){
        [self performSegueWithIdentifier:@"createroom" sender:self];
        [self.his_join setHidden:true];
        [self.his_create setHidden:false];
    }else if([roomtype isEqualToString:@"join"]&&roomid>0){
        [self performSegueWithIdentifier:@"joinroom" sender:self];
        [self.his_join setHidden:false];
        [self.his_create setHidden:true];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    NSString * welcomeword=[NSString stringWithFormat:@"%@,创建或加入一个游戏吧",[self getObjectFromDefault:@"username"]];
    [self.labName setText: welcomeword];
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
- (IBAction)btnJoinRoom:(id)sender {
    if ([self.labRoomId.text isEqualToString:@""]) {
        [self showAlert:@"提示" content:@"请输入房间号"];
        return;
    }
    
    HTTPBase *classBtest = [[HTTPBase alloc] init];
    classBtest.delegate = self;
    [classBtest baseHttp:@"RoomJoin" paramsdata:[NSDictionary dictionaryWithObjectsAndKeys:self.labRoomId.text,@"roomid",nil]];
    [self setLoading];
    
}

- (IBAction)btnCreateRoom:(id)sender {
    HTTPBase *classBtest = [[HTTPBase alloc] init];
    classBtest.delegate = self;
    [classBtest baseHttp:@"RoomNew" paramsdata:[NSDictionary dictionaryWithObjectsAndKeys:nil]];
    [self setLoading];
}

-(void) setLoading{
    [self.loadIng setHidden:false];
    [self.loadIng startAnimating];
    [self.btnCreate setEnabled:false];
    [self.btnJoin setEnabled:false];
}
-(void) setEnable{
    [self.loadIng setHidden:true];
    [self.loadIng stopAnimating];
    [self.btnCreate setEnabled:true];
    [self.btnJoin setEnabled:true];
}

-(IBAction)textFieldDoneEditing:(id)sender{
    [sender resignFirstResponder];
}


- (IBAction)endClickContent:(id)sender {
    [self textFieldDoneEditing:self.labRoomId];
}

-(IBAction)backgroundTap:(id)sender
{
    [self.labRoomId resignFirstResponder];
}


-(void)callBack:(NSDictionary *)data commandName:(NSString*) command{
    [self setEnable];
    if([command isEqualToString:@"RoomNew"]){
        NSLog(@"RoomNew 函数的回调");
//        NSString * roomid=[data objectForKey:@"roomid"];
//        [UCIAppDelegate setRoomPush:[NSString stringWithFormat:@"ROOM_%@",roomid]];
        [self setObjectFromDefault:@"create" key:@"roomtype"];
        [self setObjectFromDefault:[data objectForKey:@"roomid"] key:@"roomid"];
//        [self setObjectFromDefault:@"create" key:@"historyroomtype"];
        [self uMengClick:@"room_create"];
        //这时候加入房间成功，房间历史记录显示出来，然后点击可以直接这历史房间
        [self.his_join setHidden:true];
        [self.his_create setHidden:false];
        [self performSegueWithIdentifier:@"createroom" sender:self];
    }
    else if([command isEqualToString:@"RoomJoin"]){
//             [self showAlert:@"提示" content:@"当前房间号不存在或已超期"];
//        NSString * roomid=[data objectForKey:@"roomid"];
        [self uMengClick:@"room_join"];
        [self setObjectFromDefault:@"join" key:@"roomtype"];
         [self setObjectFromDefault:[data objectForKey:@"roomid"] key:@"roomid"];
//         [self setObjectFromDefault:@"join" key:@"historyroomtype"];
        //这时候加入房间成功，房间历史记录显示出来，然后点击可以直接这历史房间
        [self.his_join setHidden:false];
        [self.his_create setHidden:true];
        [self performSegueWithIdentifier:@"joinroom" sender:self];
        NSLog(@"RoomJoin 函数的回调");

    }

}

-(void)callback:(int)code
{
    if (code == 1101) {
        [self setEnable];
    }
}

@end
