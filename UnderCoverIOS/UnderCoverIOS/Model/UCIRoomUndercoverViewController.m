//
//  UCIRoomUndercoverViewController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-5-24.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIRoomUndercoverViewController.h"
#import "UIButton+WebCache.h"
@interface UCIRoomUndercoverViewController ()

@end

@implementation UCIRoomUndercoverViewController
@synthesize gameData;
@synthesize addPeople;
//1.谁是卧底2.杀人游戏
@synthesize gameType;

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
    //［self.navigationItem setBackButtonHide：YES］;
    //self.navigationItem.hidesBackButton=YES;
    
//    [self.labStatus setText:@""];
//    datagame=gameundercover;
//    [self.labGameName setText:[gameData objectForKey:@"name"]];
//    [self.labRoomID setText:[gameData objectForKey:@"gameuid"]];
    
    PeopleCount=[(NSArray *)[gameData objectForKey:@"room_user"] count];
    MaxPeopleCount=PeopleCount;
    
    //初始化用户发言表
    [self initSay:PeopleCount];
    
    SonCount=[[[gameData objectForKey:@"room_contente"] objectForKey:@"soncount" ] intValue];
    sonWord=[[gameData objectForKey:@"room_contente"] objectForKey:@"son"];
    roomtype=[[gameData objectForKey:@"roomtype"] intValue];
    
    fatherWord=[[gameData objectForKey:@"room_contente"] objectForKey:@"father"];
    NSArray * room_user=[gameData objectForKey:@"room_user"];
    datagame =[[NSMutableArray alloc] init];
    //主持人的gameuid
    int zhuchigameuid=[[gameData objectForKey:@"gameuid"] intValue];
    for (int i=0; i<[room_user count]; i++) {
        int temgameuid=[[(NSDictionary *)[room_user objectAtIndex:i] objectForKey:@"gameuid"] intValue];
        NSString * temcontent=[(NSDictionary *)[room_user objectAtIndex:i] objectForKey:@"content"];
        NSString * temusername=[(NSDictionary *)[room_user objectAtIndex:i] objectForKey:@"username"];
        NSString * temphoto=[(NSDictionary *)[room_user objectAtIndex:i] objectForKey:@"photo"];
        NSString * temgameuidStr=[NSString stringWithFormat:@"%d",temgameuid];
        [datagame addObject:[NSDictionary dictionaryWithObjectsAndKeys:temusername,@"user",temcontent,@"content",temgameuidStr,@"gameuid",temphoto,@"photo",nil]];
        
        
        if(temgameuid==-1){
            NSString * content=[NSString stringWithFormat:@"NO1:%@",temcontent];
            [self.btn_no1 setTitle:content forState:UIControlStateNormal];
        }else if(temgameuid==-2){
            NSString * content=[NSString stringWithFormat:@"NO2:%@",temcontent];
            [self.btn_no2 setTitle:content forState:UIControlStateNormal];
        }else if(temgameuid==-3){
            NSString * content=[NSString stringWithFormat:@"NO3:%@",temcontent];
            [self.btn_no3 setTitle:content forState:UIControlStateNormal];
        }
        else if(temgameuid==-4){
            NSString * content=[NSString stringWithFormat:@"NO4:%@",temcontent];
            [self.btn_no4 setTitle:content forState:UIControlStateNormal];
        }
        else if(zhuchigameuid==temgameuid){
            NSString * content=[NSString stringWithFormat:@"自己:%@",temcontent];
            [self.btn_self setTitle:content forState:UIControlStateNormal];
        }
    }
    
    showShenfen=[[NSMutableDictionary alloc] init];
    
    [self initGuess:datagame];
    [self initaddPeople];
    showShenfenSec=0;
    
    if([gameType isEqual:@"1"]){
        self.navigationItem.title=@"谁是卧底";
    }
    else if([gameType isEqual:@"2"]){
        self.navigationItem.title=@"杀人游戏";
        KillerCount=[[[[self gameData] objectForKey:@"room_contente"] objectForKey:@"killer" ] intValue];
        PoliceCount=[[[[self gameData] objectForKey:@"room_contente"] objectForKey:@"police" ] intValue];
        
        Pinmin=PeopleCount-KillerCount-PoliceCount-1;
        
    }
    
    needSeeShenfen=[addPeople intValue]+1;
    if(addPeople>0){
        [self setGameStatus:@"请本地玩家依次查看自己的身份"];
    }
    else{
        [self nextSayTextChange];
    }
        [self nextSayTextChange];
    // Do any additional setup after loading the view.

}


//下一位用户发言并且修改状态
-(void)nextSayTextChange{
    int sayindex=[self nextSay];
    NSString * username=[(NSDictionary *)[datagame objectAtIndex:sayindex-1] objectForKey:@"user"];
    [self setGameStatus:[NSString stringWithFormat:@"『%@』开始描述",username]];
}


-(void) initaddPeople{
    int people=[addPeople intValue];
    if(people==0)
    {
        [self.btn_no4 setHidden:true];
        [self.btn_no3 setHidden:true];
        [self.btn_no2 setHidden:true];
        [self.btn_no1 setHidden:true];
    }else if(people==1)
    {
        [self.btn_no4 setHidden:true];
        [self.btn_no3 setHidden:true];
        [self.btn_no2 setHidden:true];
    }else if(people==2)
    {
        [self.btn_no4 setHidden:true];
        [self.btn_no3 setHidden:true];
    }else if(people==3)
    {
        [self.btn_no4 setHidden:true];
    }
}

- (IBAction)btnAddPeopleTap:(UIButton *)sender {
    int tap=sender.tag;
    NSArray * room_user=[gameData objectForKey:@"room_user"];
    int  alterindex=tap-101;
    NSString * content=[(NSDictionary *)[room_user objectAtIndex:alterindex] objectForKey:@"content"];
    [self showAlert:@"" content:[NSString stringWithFormat:@"%d号：%@",alterindex+1,content]];
}


/**
 *initArray 里面是字典，名称，user，内容,content
 */
-(void)initGuess:(NSArray *)initArray{
    
    int width=self.viewPop.bounds.size.width;
    //    int height=self.viewGuess.bounds.size.height;
    int btnWidth=(width-30)/4;
    int btnHeight=btnWidth;
    
    //这里判断，玩家名字一样的话，特别显示
    NSMutableArray * usernamearray=[[NSMutableArray alloc] init];
    
     
    //这里有两个添加的玩家
    for (int i=0; i<[initArray count]; i++) {
        CGRect frame = CGRectMake((btnWidth+5)*(i%4)+10, (i/4)*(btnHeight+10)+10, btnWidth, btnHeight);
        UIButton *someAddButton = [self getCircleBtn:btnWidth];
     
        NSString * shenfen=[(NSDictionary *)[initArray objectAtIndex:i] objectForKey:@"content"];
        NSString * userName=[(NSDictionary *)[initArray objectAtIndex:i] objectForKey:@"user"];
         NSString * photo=[(NSDictionary *)[initArray objectAtIndex:i] objectForKey:@"photo"];
        [someAddButton setTitle:userName forState:UIControlStateNormal];
        [someAddButton  sd_setBackgroundImageWithURL:[NSURL URLWithString: photo] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_photo.png"]];
        
        if(roomtype==2&&[shenfen isEqualToString:@"法官"])
        {
//                NSString * tem=[NSString stringWithFormat:@"%@:%@",[(NSDictionary *)[initArray objectAtIndex:i] objectForKey:@"user"],@"法官"];
            
            [self disableSay:i];
            [someAddButton setTitle:@"法官" forState:UIControlStateNormal];
            [someAddButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [someAddButton setEnabled:false];
        }
        
        
 
        if ([usernamearray containsObject:userName]) {
            someAddButton.layer.borderColor=[UIColor redColor].CGColor;
        }
         [usernamearray addObject:userName];
        
        [someAddButton setFrame:frame];
        [someAddButton setTag:i+1];
        [someAddButton addTarget:self action:@selector(tapPeople:) forControlEvents:UIControlEventTouchUpInside];
        [self.viewPop addSubview:someAddButton];
    }
}
-(void)tapPeople:(UIButton *)sender{
    if([gameType isEqual:@"2"]){
        [self tapPeopleKiller:sender];
        return;
    }
    int tag=(int)sender.tag;
    NSString * txtShenFen= [[datagame objectAtIndex:tag-1] objectForKey:@"content"];
    if([txtShenFen isEqualToString:sonWord]){
      // PeopleCount--;
        SonCount--;
    }
    else{
         //SonCount--;
        PeopleCount--;
    }
    txtShenFen=@"出局";
    [sender setTitle:txtShenFen forState:UIControlStateDisabled];
    [sender setEnabled:false];
    BOOL finish=false;
    if(PeopleCount<=SonCount){
//        [self.labStatus setText:@"卧底胜利"];
         [self showChengfa:@"卧底胜利,开始惩罚"];
        //取得失败都gameuid,发送到服务器去发推送；
        NSString *loserStr= [self getLoserStr:fatherWord];
        [self sendToSendPunish:loserStr];
        
        [self disabledAllButton];
        finish=true;
    }else if(SonCount<=0){
//        [self.labStatus setText:@"卧底失败"];
        [self showChengfa:@"卧底失败,开始惩罚"];
        NSString *loserStr= [self getLoserStr:sonWord];
        [self sendToSendPunish:loserStr];
//        [self.btnPublish setTitle:@"卧底失败" forState:UIControlStateNormal];
        [self disabledAllButton];
        finish=true;
    }
    else{
        [self disableSay:tag-1];
        [self nextSayTextChange];

    }
    if(finish){
        //点投票最后一步
        [self uMengClick:@"click_guess_last"];
        [self playHuanhu];
    }
}
//杀人游戏点击
-(void)tapPeopleKiller:(UIButton *)sender{
    int tag=(int)sender.tag;
    NSString * txtShenFen= [[datagame objectAtIndex:tag-1] objectForKey:@"user"];
    if([txtShenFen isEqualToString:@"杀手"]){
        KillerCount--;
    }
    else if([txtShenFen isEqualToString:@"警察"]){
        PoliceCount--;
    }
    else{
        Pinmin--;
    }
    [sender setEnabled:false];
    BOOL finish=false;
    if(KillerCount<=0){
//        [self.labStatus setText:@"平民和警察胜利"];
        [self showChengfa:@"平民和警察胜利,开始惩罚"];
        //取得失败都gameuid,发送到服务器去发推送；
        NSString *loserStr= [self getLoserStr:@"杀手"];
        [self sendToSendPunish:loserStr];
        
        [self disabledAllButton];
        finish=true;
    }else if(PoliceCount<=0||Pinmin<=0){
//        [self.labStatus setText:@"杀手胜利"];
        [self showChengfa:@"杀手胜利,开始惩罚"];
        NSString *loserStr=[NSString stringWithFormat:@"%@%@", [self getLoserStr:@"平民"], [self getLoserStr:@"警察"]] ;
        [self sendToSendPunish:loserStr];
        //        [self.btnPublish setTitle:@"卧底失败" forState:UIControlStateNormal];
        [self disabledAllButton];
        finish=true;
    }else{
        [self disableSay:tag-1];
        [self nextSayTextChange];
    }
    if(finish){
        //点投票最后一步
        [self uMengClick:@"click_guess_last"];
        [self playHuanhu];
    }
}

-(void)showChengfa:(NSString*)chengfa{
    [self.btnPunish setEnabled:true];
    [self.btnPunish setTitle:chengfa forState:UIControlStateNormal];
//    [self.btnPunish ]
}

-(void)setGameStatus:(NSString *)status{
    [self.btnPunish setEnabled:false];
    [self.btnPunish setTitle:status forState:UIControlStateDisabled];
//    [self.btnPunish setTitleColor:[UIColor greenColor] forState:UIControlStateDisabled];
//        [self.btnPunish setTitle:status forState:UIControlStateDisabled];
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
        punishinfo=[data objectForKey:@"punish"];
        NSLog(@"RoomPunish 函数的回调");
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id theSegue = segue.destinationViewController;
    if([segue.identifier isEqualToString:@"gamepunish"])
    {
        //界面之间进行传值,把创建游戏的数据发过来
        [theSegue setValue:punishinfo forKey:@"punishinfo"];
    }
}

- (IBAction)restert:(id)sender {
        [self.navigationController popViewControllerAnimated:YES];
}



//每秒刷新
-(void)reflashOneSec{
//    NSString * needRemove=@"";
    for(NSString *compKey in showShenfen) {    // 正确的字典遍历方
        int listTime=[[showShenfen objectForKey:compKey] intValue];
        if(listTime>0){
            listTime--;
            [showShenfen setObject:[self intToString:listTime] forKey:compKey];
        }
        else if(listTime==0){
            [self hideTag:[compKey intValue]];
//            needRemove=compKey;
            break;
        }
             
    }
//    if(![needRemove isEqual:@""]){
//       
//    }
    
    if(showShenfenSec>0)
    {
        showShenfenSec--;
        if(showShenfenSec==0){
//            [self.labMeWord setHidden:true];
        }
    }
}
-(void)hideTag:(int)btnTag{
    UIButton * tembutton=(UIButton *)[self.view viewWithTag:btnTag];
    float left=self.view.bounds.size.width+tembutton.bounds.size.width/2-10;
    CGPoint pointnew=CGPointMake(left,tembutton.center.y);
    tembutton.center=pointnew;
//    [tembutton setAlpha:0.3];
    [showShenfen removeObjectForKey:[self intToString:btnTag]];
    [self otherSetDisabble:true];
}



//以下是点击查看身份事件
- (IBAction)clickTagAction:(UIButton *)sender {
    //如果没有弹出的时候
    if([showShenfen objectForKey:[self intToString:sender.tag]]>0){
        [self hideTag:sender.tag];
        needSeeShenfen--;
    }
    else{
        [self otherSetDisabble:false];
        float left=sender.superview.bounds.size.width-sender.bounds.size.width/2;
        CGPoint pointnew=CGPointMake(left,sender.center.y);
        sender.center=pointnew;
        //记时，进行回退
        [showShenfen setObject:[self intToString:3] forKey:[self intToString:sender.tag]];
        [sender setEnabled:true];
//        [sender setAlpha:1];
    }
}

-(void)otherSetDisabble:(BOOL) isenable{
    [self.btn_self setEnabled:isenable];
    [self.btn_no1 setEnabled:isenable];
    [self.btn_no2 setEnabled:isenable];
    [self.btn_no3 setEnabled:isenable];
    [self.btn_no4 setEnabled:isenable];
}


@end
