//
//  UCIRoomSettingViewController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-5-21.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIRoomSettingViewController.h"
#import "UCIAppDelegate.h"
#import "UIButton+WebCache.h"

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
    int roomid=[[self getObjectFromDefault:@"roomid"] intValue];
    self.navigationItem.title=[NSString  stringWithFormat:@"房间%d",roomid];
    
    timerCheck= [NSTimer  timerWithTimeInterval:1.0 target:self selector:@selector(checkFlash)userInfo:nil repeats:YES];
    timerReflash= [NSTimer  timerWithTimeInterval:20.0 target:self selector:@selector(reflash)userInfo:nil repeats:YES];
    
     //设置条可以拖动
    istouch=0;
     [self.btnPeople addTarget:self action:@selector(dragMoving:withEvent: )forControlEvents: UIControlEventTouchDragInside];
    
    [self.btnPeople addTarget:self action:@selector(dragStart:withEvent: )forControlEvents: UIControlEventTouchDown];
    
    [self.btnPeople addTarget:self action:@selector(dragEnd:withEvent: )forControlEvents: UIControlEventTouchUpInside];
    
    
    startPoint=self.btnPeople.center;
    [[NSRunLoop currentRunLoop]addTimer:timerCheck forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop]addTimer:timerReflash forMode:NSDefaultRunLoopMode];
    
    [self reflash];
    
    addPeopleCount=0;
    thistotalpeople=1;
    
    [self.btnUndercover setEnabled:false];
    [self.btnKiller setEnabled:false];
//    [UIApplication mess]
    // Do any additional setup after loading the view.
    
    //如果是测试的，就把最大值调大点
    if([UCIAppDelegate isdebug]){
        [self.peopleCount setMaximumValue:5];
    }
    else{
        [self.peopleCount setMaximumValue:2];
    }
//    [self.view addSubview:self.navigationController.view];
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//
//}

- (void) dragMoving: (UIButton *) c withEvent:ev
{
    istouch=true;
    CGPoint point = [[[ev allTouches] anyObject] locationInView:self.view];
    float dx = point.x - startPoint.x;
    CGPoint newcenter = CGPointMake(c.center.x + dx,startPoint.y);
    newcenter.x =MAX(c.superview.bounds.size.width-c.bounds.size.width/2,newcenter.x);
    newcenter.x =MIN(c.superview.bounds.size.width+10,newcenter.x);
    c.center = newcenter;
    startPoint.x=point.x;
}


-(void) dragEnd: (UIButton *) c withEvent:ev{
//    NSLog(@"end");
    //判断一下停在第几个格那里
//        self.view.bounds.size.width;
    float btnRight=c.center.x+c.bounds.size.width/2;
    int count=5-floorf((btnRight-self.view.bounds.size.width)/36);
    [self moveToCount:count];
    thistotalpeople=count;
    [self setObjectFromDefault:[NSString stringWithFormat:@"%d",thistotalpeople] key:@"addOtherPeople"];
//    NSLog(@"%d",count);
}

//把选择条移到相应位置上
-(void) moveToCount:(int)count{
//    float btnRight=self.btnPeople.center.x+self.btnPeople.bounds.size.width/2;
    int right=(5-count)*36;
//    self.btnPeople.center.x=(float)right+self.view.bounds.size.width-self.btnPeople.bounds.size.width/2;
    
    CGPoint newcenter = CGPointMake((float)right+self.view.bounds.size.width-self.btnPeople.bounds.size.width/2, self.btnPeople.center.y);
    self.btnPeople.center=newcenter;
    nowPoint=newcenter;
    addPeopleCount=count-1;
    //addPeopleCount=5;
//    [self.labPeople setText:[NSString stringWithFormat:@"%d",progress ]];
    
    [self ReflashUsers];
//    self.btnPeople.center.x

}





- (void) dragStart: (UIButton *) c withEvent:ev
{
    CGPoint point= [[[ev allTouches] anyObject] locationInView:self.view];
    startPoint.x=point.x;
    [[c superview] bringSubviewToFront:self.view];
}



-(IBAction)doClick:(UIButton*)sender
{
    if (!istouch)
    {
        thistotalpeople++;
        if(thistotalpeople>5){
            thistotalpeople=1;
        }
        [self moveToCount:thistotalpeople];
    }
    istouch=false;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    int peoplecount=(int)[[self getObjectFromDefault:@"addOtherPeople"] integerValue];
    if(peoplecount<=0){
        peoplecount=1;
    }
    thistotalpeople=peoplecount;
    int totalcount=(int)[userinfo count]+peoplecount-1;
    [self checkifEnable:totalcount];
//    self.btnPeople.center=nowPoint;
//    [self moveToCount:peoplecount];
    [self ReflashUsers];
}




-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //注意，这里添加的定时器必须给清理掉，不然退出的时候会一直运行
    [timerCheck invalidate];
    [timerReflash invalidate];
}

-(void)checkFlash{
    int a=[UCIAppDelegate messageHandler];
    if(a>0){
//        NSLog(@"reflash");
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
            //把房间信息清空
            [self setObjectFromDefault:@"" key:@"roomtype"];
            [self setObjectFromDefault:@"" key:@"roomid"];
            
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        [self ReflashUsers];
        NSLog(@"RoomGetInfo 函数的回调");
    }else if([command isEqualToString:@"RoomLevel"]){
        [self setObjectFromDefault:@"" key:@"roomtype"];
//        [self dismissViewControllerAnimated:false completion:nil];
        
        [self.navigationController popViewControllerAnimated:YES];
//        NSLog(@"RoomLevel 函数的回调");
    }
    else if([command isEqualToString:@"RoomStartGame"]){
        datatosend=data;
//        if(gametype==1){
            [self performSegueWithIdentifier:@"gamestart" sender:self];
//        }else if(gametype==2){
//            [self performSegueWithIdentifier:@"gameKiller" sender:self];
//        }
//        NSLog(@"RoomStartGame 函数的回调");
        [self checkifEnable:(int)[userinfo count]+(int)self.peopleCount.value];
    }
    else if([command isEqualToString:@"RoomRemoveSomeone"]){
        [self showAlert:@"" content:@"删除玩家成功"];
        [self reflash];
//        NSLog(@"RoomRemoveSomeone 函数的回调");
    }

}

//在这里画出玩家
-(void)ReflashUsers{
    
    int progress=addPeopleCount;
    userinfotem=[[NSMutableArray alloc] init];
    for (int i=0; i<progress; i++) {
        NSDictionary * tem=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"NO.%d",i+1],@"username",@"ddd",@"content",[self intToString:-i-1],@"gameuid",nil];
        [userinfotem addObject:tem];
    }
    
    for (int i=0; i<[userinfo count]; i++) {
        [userinfotem addObject:[userinfo objectAtIndex:i]];
    }

    
    //显示哪些可以显示，哪些活动不可以显示
    [self checkifEnable:(int)[userinfotem count]];
    
    //scrollUsers = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    
    int width=self.scrollUsers.bounds.size.width;

    int btnWidth=(width-40)/4;
    int btnHeight=btnWidth;
    
    //
   //self.scrollUsers = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    //self.scrollUsers.contentSize=CGSizeMake(400,800);
    //self.scrollUsers.showsVerticalScrollIndicator=true;
   // _scrollUsers.backgroundColor=[UIColororangeColor];
    //_scrollUsers.pagingEnabled=YES;

    for (UIView *view_ in _scrollUsers.subviews) {
        [view_ removeFromSuperview];
    }
    //这里判断，玩家名字一样的话，特别显示
    NSMutableArray * usernamearray=[[NSMutableArray alloc] init];
   // UIScrollView * scrollUsers =[[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0,self.view.frame.size.width, 400)];
//设置scrollusers的大小
    CGSize newSize = CGSizeMake(width , width * 2);
    [self.scrollUsers setContentSize:newSize];
    
    int gameuid=[[self getObjectFromDefault:@"gameuid"] intValue];
    for(int i=0;i<[userinfotem count];i++){
        CGRect frame = CGRectMake((btnWidth+5)*(i%4)+10, (i/4)*(btnHeight+10)+10, btnWidth, btnHeight);
        
       
        
        UIButton *someAddButton = [self getCircleBtn:btnWidth];
        
        int temgameuid=[[(NSMutableDictionary *)[userinfotem objectAtIndex:i] objectForKey:@"gameuid"] intValue];
        NSString * userName=[(NSMutableDictionary *)[userinfotem objectAtIndex:i] objectForKey:@"username"];
        NSString * userNameChange=[self getObjectFromDefault:[NSString stringWithFormat:@"%d_Newname",temgameuid]];
        if(userNameChange.length>0){
            userName=userNameChange;
        }
        NSString * photo=[(NSMutableDictionary *)[userinfotem objectAtIndex:i] objectForKey:@"photo"];
 
        [someAddButton setTitle:userName forState:UIControlStateNormal];
        
        [someAddButton  sd_setBackgroundImageWithURL:[NSURL URLWithString: photo] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_photo.png"]];
        if ([usernamearray containsObject:userName]) {
            someAddButton.layer.borderColor=[UIColor redColor].CGColor;
        }
        
        bool showdel=false;
        //如果某个玩家是房方，那么特殊显示
        if(temgameuid==gameuid||temgameuid<=0){
             someAddButton.layer.borderColor=[UIColor blueColor].CGColor;
        }
        else{
            showdel=true;
                   }
        [usernamearray addObject:userName];
        
        someAddButton.frame = frame;
        [someAddButton setTag:i];
        //点击删除某个玩家
        
        [someAddButton addTarget:self action:@selector(clickPeople:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.scrollUsers addSubview:someAddButton];
        if(showdel){
            //这里是删除按键
            UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            delBtn.backgroundColor = [UIColor clearColor];
            CGRect frameDel = CGRectMake((btnWidth+5)*(i%4)+10+btnWidth-22, (i/4)*(btnHeight+10)+2, 30, 30);
            delBtn.frame = frameDel;
            [delBtn setTag:temgameuid];
            [delBtn setBackgroundImage:[UIImage imageNamed:@"remove.png"] forState:UIControlStateNormal];
            [delBtn addTarget:self action:@selector(tapPeopleToRemove:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollUsers addSubview:delBtn];

        }
        
    }
}

-(void)tapPeopleToRemove:(UIButton *)sender{
    int tag=(int)sender.tag;
    HTTPBase *classBtest = [[HTTPBase alloc] init];
    classBtest.delegate = self;
    [classBtest baseHttp:@"RoomRemoveSomeone" paramsdata:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",tag],@"gameuid",nil]];
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
    //[self ReflashU;
    HTTPBase *classBtest = [[HTTPBase alloc] init];
    classBtest.delegate = self;
    [classBtest baseHttp:@"RoomStartGame" paramsdata:[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"type",[NSString stringWithFormat:@"%d",addPeopleCount],@"addPeople",nil]];
    gametype=1;
    [self uMengClick:@"room_undercover"];
    [self uMengValue:@"room_add_people_count" val:addPeopleCount];
    [self setBtnDisable];
   // [self ReflashUsers];
    //[self.btnKiller setEnabled:false];
    
}

//开始杀人游戏
- (IBAction)btnStartKiller:(id)sender {
    HTTPBase *classBtest = [[HTTPBase alloc] init];
    classBtest.delegate = self;
    [classBtest baseHttp:@"RoomStartGame" paramsdata:[NSDictionary dictionaryWithObjectsAndKeys:@"2",@"type",[NSString stringWithFormat:@"%d",addPeopleCount],@"addPeople",nil]];
    gametype=2;
    [self uMengValue:@"room_add_people_count" val:addPeopleCount];
    [self uMengClick:@"room_killer"];
    [self setBtnDisable];
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id theSegue = segue.destinationViewController;
    
    //谁是卧底，杀人游戏，都走这个逻辑
    if([segue.identifier isEqualToString:@"gamestart"]) //"goView2"是SEGUE连线的标识
    {
        //界面之间进行传值,把创建游戏的数据发过来
        [theSegue setValue:datatosend forKey:@"gameData"];
        [theSegue setValue:[NSString stringWithFormat:@"%d",gametype] forKey:@"gameType"];
        [theSegue setValue:[NSString stringWithFormat:@"%d",addPeopleCount] forKey:@"addPeople"];
    }
    else if([segue.identifier isEqualToString:@"changeName"]){
        [theSegue setValue:willChangeUserName forKey:@"username"];
        [theSegue setValue:[self intToString:willChangeUserGameuid] forKey:@"gameuid"];
    }
}



//这个用户显示未个游戏，是否可以玩，以后每个游戏都要加在这里
-(void) checkifEnable:(int) peoplecount{
    //谁是卧底 4-10人

    //到时这里还要加入收费项
    if(peoplecount<[[self getConfig:@"UNDERCOVER_MIN_PEOPLE"] intValue]){
        [self.btnUndercover setEnabled:false];
        self.lab_under_error.hidden=false;
        self.lab_under_error.text=[NSString stringWithFormat:@"还差%d人",[[self getConfig:@"UNDERCOVER_MIN_PEOPLE"] intValue]-peoplecount];
    }else if(peoplecount>[[self getConfig:@"UNDERCOVER_MAX_PEOPLE"] intValue]){
        [self.btnUndercover setEnabled:false];
        self.lab_under_error.hidden=false;
        self.lab_under_error.text=[NSString stringWithFormat:@"超出%d人",peoplecount-[[self getConfig:@"UNDERCOVER_MAX_PEOPLE"] intValue]];
    }
    else
    {
        [self.btnUndercover setEnabled:true];
        self.lab_under_error.hidden=true;
    }
    
     //杀人游戏 6-16人
    if(peoplecount<[[self getConfig:@"KILLER_MIN_PEOPLE"] intValue]){
        [self.btnKiller setEnabled:false];
        self.lab_killer_error.hidden=false;
        self.lab_killer_error.text=[NSString stringWithFormat:@"还差%d人",[[self getConfig:@"KILLER_MIN_PEOPLE"] intValue]-peoplecount];
    }else if(peoplecount>[[self getConfig:@"KILLER_MAX_PEOPLE"] intValue]){
        [self.btnKiller setEnabled:false];
        self.lab_killer_error.hidden=false;
        self.lab_killer_error.text=[NSString stringWithFormat:@"超出%d人",peoplecount-[[self getConfig:@"KILLER_MAX_PEOPLE"] intValue]];
    }
    else
    {
        [self.btnKiller setEnabled:true];
        self.lab_killer_error.hidden=true;
       
    }
    [self.btnDouble setEnabled:true];
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
- (IBAction)btnPeople:(id)sender {
    [self showAlert:@"" content:@"可以最多支持两人没有智能设备的玩家参加"];
}
- (IBAction)clickShowAllGame:(id)sender {
    [self.viewAllGamel setHidden:NO];
}
- (IBAction)clickHideAllGame:(id)sender {
    [self.viewAllGamel setHidden:YES];
}

//打开修改某人昵称页面
-(void)clickPeople:(UIButton *)sender{
    int tag=(int)sender.tag;
    willChangeUserName=[(NSMutableDictionary *)[userinfotem objectAtIndex:tag] objectForKey:@"username"];
    willChangeUserGameuid=(int)[[(NSMutableDictionary *)[userinfotem objectAtIndex:tag] objectForKey:@"gameuid"] integerValue];
    [self performSegueWithIdentifier:@"changeName" sender:self];
}


@end
