//
//  UCIRoomUndercoverViewController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-5-24.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIRoomUndercoverViewController.h"

@interface UCIRoomUndercoverViewController ()

@end

@implementation UCIRoomUndercoverViewController
@synthesize gameundercover;

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
    
    [self.labStatus setText:@""];
//    datagame=gameundercover;
    [self.labGameName setText:[gameundercover objectForKey:@"name"]];
    [self.labRoomID setText:[gameundercover objectForKey:@"gameuid"]];
    
    PeopleCount=[(NSArray *)[gameundercover objectForKey:@"room_user"] count];
    MaxPeopleCount=PeopleCount;
    SonCount=[[[gameundercover objectForKey:@"room_contente"] objectForKey:@"soncount" ] intValue];
    sonWord=[[gameundercover objectForKey:@"room_contente"] objectForKey:@"son"];
        fatherWord=[[gameundercover objectForKey:@"room_contente"] objectForKey:@"father"];
    NSArray * room_user=[gameundercover objectForKey:@"room_user"];
    datagame =[[NSMutableArray alloc] init];
    for (int i=0; i<[room_user count]; i++) {
        [datagame addObject:[NSDictionary dictionaryWithObjectsAndKeys:[(NSDictionary *)[room_user objectAtIndex:i] objectForKey:@"username"],@"user",[(NSDictionary *)[room_user objectAtIndex:i] objectForKey:@"content"],@"content",[(NSDictionary *)[room_user objectAtIndex:i] objectForKey:@"gameuid"],@"gameuid",nil]];
        if([[gameundercover objectForKey:@"gameuid"]isEqualToString:[(NSDictionary *)[room_user objectAtIndex:i] objectForKey:@"gameuid"]]){
            [self.labMeWord setText:[(NSDictionary *)[room_user objectAtIndex:i] objectForKey:@"content"]];
        }
    }
    
    
    [self initGuess:datagame];
    // Do any additional setup after loading the view.
}

/**
 *initArray 里面是字典，名称，user，内容,content
 */
-(void)initGuess:(NSArray *)initArray{
    
    int width=self.view.bounds.size.width;
    //    int height=self.viewGuess.bounds.size.height;
    int btnWidth=(width-30)/4;
    int btnHeight=40;
    for (int i=0; i<[initArray count]; i++) {
        CGRect frame = CGRectMake((btnWidth+5)*(i%4)+10, (i/4)*(btnHeight+10)+100, btnWidth, btnHeight);
        UIButton *someAddButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        someAddButton.backgroundColor = [UIColor clearColor];
        [someAddButton setTitle:[(NSDictionary *)[initArray objectAtIndex:i] objectForKey:@"user"] forState:UIControlStateNormal];
        [someAddButton setFrame:frame];
        [someAddButton setTag:i+1];
        [someAddButton addTarget:self action:@selector(tapPeople:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:someAddButton];
    }
}
-(void)tapPeople:(UIButton *)sender{
    int tag=(int)sender.tag;
    NSString * txtShenFen= [[datagame objectAtIndex:tag-1] objectForKey:@"user"];
    if([txtShenFen isEqualToString:sonWord]){
       PeopleCount--;
    }
    else{
         SonCount--;
    }
    txtShenFen=@"出局";
    [sender setTitle:txtShenFen forState:UIControlStateDisabled];
    [sender setEnabled:false];
    BOOL finish=false;
    if(PeopleCount<=SonCount){
        [self.labStatus setText:@"卧底胜利"];
        //取得失败都gameuid,发送到服务器去发推送；
        NSString *loserStr= [self getLoserStr:fatherWord];
        [self sendToSendPunish:loserStr];
        
        [self disabledAllButton];
        finish=true;
    }else if(SonCount<=0){
        [self.labStatus setText:@"卧底失败"];
        NSString *loserStr= [self getLoserStr:sonWord];
        [self sendToSendPunish:loserStr];
//        [self.btnPublish setTitle:@"卧底失败" forState:UIControlStateNormal];
        [self disabledAllButton];
        finish=true;
    }
    if(finish){
        //点投票最后一步
        [self uMengClick:@"click_guess_last"];
        [self playHuanhu];
    }
}

-(void) sendToSendPunish:(NSString *) str{
    HTTPBase *classBtest = [[HTTPBase alloc] init];
    classBtest.delegate = self;
    [classBtest baseHttp:@"RoomPunish" paramsdata:[NSDictionary dictionaryWithObjectsAndKeys:str,@"gameuidstr",nil]];
}

-(NSString *) getLoserStr:(NSString *)loser
{
    NSString * result=@"";
    for (int i=0; i<[datagame count]; i++) {
        NSString * content=[[datagame objectAtIndex:i] objectForKey:@"content"];
        if([content isEqualToString:loser]){
             NSString * gameuid=[[datagame objectAtIndex:i] objectForKey:@"gameuid"];
            result=[NSString stringWithFormat:@"%@_%@",result,gameuid];
        }
    }
    return result;
}


//使所有的按键失效并显示相应的身份
-(void)disabledAllButton{
    for (int i=0; i<[datagame count]; i++) {
        UIButton * tembtn=(UIButton *)[self.view viewWithTag:i+1];
        NSString * txtShenFen=[[datagame objectAtIndex:i] objectForKey:@"content"];
        [tembtn setEnabled:false];
        [tembtn setTitle:txtShenFen forState:UIControlStateDisabled];
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


-(void)callBack:(NSDictionary *)data commandName:(NSString*) command{
    if([command isEqualToString:@"RoomPunish"]){
        [self.labPunishTitle setHidden:false];
        NSString * punishStr=@"";
        NSArray *dataarr=[data objectForKey:@"punish"];
        for (int i=0; i<[dataarr count]; i++) {
            punishStr=[NSString stringWithFormat:@"%@\n%@\n\t%@",punishStr,[(NSDictionary *)[dataarr objectAtIndex:i] objectForKey:@"username" ],[(NSDictionary *)[dataarr objectAtIndex:i] objectForKey:@"content" ] ];
        }
        [self.labPunishContent setText:punishStr];
        NSLog(@"RoomPunish 函数的回调");
    }
}
- (IBAction)restert:(id)sender {
        [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)showWord:(id)sender {
    if(self.btnShowWord.isOn){
        [self.labMeWord setHidden:false];
    }
    else{
        [self.labMeWord setHidden:true];
    }
}


@end
