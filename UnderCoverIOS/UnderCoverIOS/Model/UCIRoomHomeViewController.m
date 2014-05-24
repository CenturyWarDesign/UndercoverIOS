//
//  UCIRoomHomeViewController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-5-21.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIRoomHomeViewController.h"
#import "UCIAppDelegate.h"

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
    NSString *username=[self getObjectFromDefault:@"username"];
    if([username length]==0){
        [self performSegueWithIdentifier:@"changeName" sender:self];
    }

    //如果已经设置过姓名，则跳过

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    NSString * welcomeword=[NSString stringWithFormat:@"%@,选一个游戏开始吧",[self getObjectFromDefault:@"username"]];
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
    HTTPBase *classBtest = [[HTTPBase alloc] init];
    classBtest.delegate = self;
    [classBtest baseHttp:@"RoomJoin" paramsdata:[NSDictionary dictionaryWithObjectsAndKeys:self.labRoomId.text,@"roomid",nil]];
}

- (IBAction)btnCreateRoom:(id)sender {
    HTTPBase *classBtest = [[HTTPBase alloc] init];
    classBtest.delegate = self;
    [classBtest baseHttp:@"RoomNew" paramsdata:[NSDictionary dictionaryWithObjectsAndKeys:nil]];
}

-(IBAction)textFieldDoneEditing:(id)sender{
    [sender resignFirstResponder];
}


- (IBAction)endClickContent:(id)sender {
    [self textFieldDoneEditing:self.labRoomId];
}


-(void)callBack:(NSDictionary *)data commandName:(NSString*) command{
    if([command isEqualToString:@"RoomNew"]){
        NSLog(@"RoomNew 函数的回调");
        NSString * roomid=[data objectForKey:@"roomid"];
        [UCIAppDelegate setRoomPush:[NSString stringWithFormat:@"ROOM_%@",roomid]];
        [self performSegueWithIdentifier:@"createroom" sender:self];
    }
    else if([command isEqualToString:@"RoomJoin"]){
        [self performSegueWithIdentifier:@"joinroom" sender:self];
//             [self showAlert:@"提示" content:@"当前房间号不存在或已超期"];
        NSString * roomid=[data objectForKey:@"roomid"];
        [UCIAppDelegate setRoomPush:[NSString stringWithFormat:@"ROOM_%@",roomid]];
        NSLog(@"RoomJoin 函数的回调");

    }
}

@end
