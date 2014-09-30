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

    
    //设置条可以拖动
    self.imgPeopleSetting.userInteractionEnabled=YES;
    
    timerCheck= [NSTimer  timerWithTimeInterval:1.0 target:self selector:@selector(checkFlash)userInfo:nil repeats:YES];
    timerReflash= [NSTimer  timerWithTimeInterval:20.0 target:self selector:@selector(reflash)userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop]addTimer:timerCheck forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop]addTimer:timerReflash forMode:NSDefaultRunLoopMode];
    
    [self reflash];
    
    addPeopleCount=0;
    
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
}



//- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    //保存触摸起始点位置
//    CGPoint point = [[touches anyObject] locationInView:self];
//    startPoint = point;
//    
//    //该view置于最前
//    [[self superview] bringSubviewToFront:self];
//}
//
//-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    //计算位移=当前位置-起始位置
//    CGPoint point = [[touches anyObject] locationInView:self];
//    float dx = point.x - startPoint.x;
//    float dy = point.y - startPoint.y;
//    
//    //计算移动后的view中心点
//    CGPoint newcenter = CGPointMake(self.center.x + dx, self.center.y + dy);
//    
//    
//    /* 限制用户不可将视图托出屏幕 */
//    float halfx = CGRectGetMidX(self.bounds);
//    //x坐标左边界
//    newcenter.x = MAX(halfx, newcenter.x);
//    //x坐标右边界
//    newcenter.x = MIN(self.superview.bounds.size.width - halfx, newcenter.x);
//    
//    //y坐标同理
//    float halfy = CGRectGetMidY(self.bounds);
//    newcenter.y = MAX(halfy, newcenter.y);
//    newcenter.y = MIN(self.superview.bounds.size.height - halfy, newcenter.y);
//    
//    //移动view
//    self.center = newcenter;
//}



-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
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
        [self ReflashUsers];
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
        [self checkifEnable:[userinfo count]+(int)self.peopleCount.value];
    }
    else if([command isEqualToString:@"RoomRemoveSomeone"]){
        [self showAlert:@"" content:@"删除玩家成功"];
        [self reflash];
        NSLog(@"RoomRemoveSomeone 函数的回调");
    }

}

//在这里画出玩家
-(void)ReflashUsers{
    
    int progress=(int)self.peopleCount.value;
    NSMutableArray * userinfotem=[[NSMutableArray alloc] init];
    for (int i=0; i<progress; i++) {
        NSDictionary * tem=[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"NO.%d",i+1],@"username",@"ddd",@"content",nil];
        [userinfotem addObject:tem];
    }
    
    for (int i=0; i<[userinfo count]; i++) {
        [userinfotem addObject:[userinfo objectAtIndex:i]];
    }

    
    //显示哪些可以显示，哪些活动不可以显示
    [self checkifEnable:[userinfotem count]];
    
    //scrollUsers = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    
    int width=self.scrollUsers.bounds.size.width;

    int btnWidth=(width-30)/4;
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
        CGRect frame = CGRectMake((btnWidth+5)*(i%4)+10, (i/4)*(btnHeight+10), btnWidth, btnHeight);
        
        UIButton *someAddButton = [self getCircleBtn:btnWidth];
        
        NSString * userName=[(NSMutableDictionary *)[userinfotem objectAtIndex:i] objectForKey:@"username"];
        NSString * photo=[(NSMutableDictionary *)[userinfotem objectAtIndex:i] objectForKey:@"photo"];
        int temgameuid=[[(NSMutableDictionary *)[userinfotem objectAtIndex:i] objectForKey:@"gameuid"] intValue];
        [someAddButton setTitle:userName forState:UIControlStateNormal];
        
        [someAddButton  sd_setBackgroundImageWithURL:[NSURL URLWithString: photo] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"default_photo.png"]];
        if ([usernamearray containsObject:userName]) {
            someAddButton.layer.borderColor=[UIColor redColor].CGColor;
        }
        
        //如果某个玩家是房方，那么特殊显示
        if(temgameuid==gameuid){
             someAddButton.layer.borderColor=[UIColor blueColor].CGColor;
        }
        [usernamearray addObject:userName];
        
        someAddButton.frame = frame;
        [someAddButton setTag:i];
        //点击删除某个玩家
        
        //[someAddButton addTarget:self action:@selector(tapPeople:) forControlEvents:UIControlEventTouchUpInside];
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
    if([segue.identifier isEqualToString:@"gameundercover"]) //"goView2"是SEGUE连线的标识
    {
     
        //界面之间进行传值,把创建游戏的数据发过来
        [theSegue setValue:datatosend forKey:@"gameData"];
            [theSegue setValue:[NSString stringWithFormat:@"%d",addPeopleCount] forKey:@"addPeople"];
    }
    else if([segue.identifier isEqualToString:@"gameKiller"]) //"goView2"是SEGUE连线的标识
    {
        //界面之间进行传值,把创建游戏的数据发过来
        [theSegue setValue:datatosend forKey:@"gameData"];
            [theSegue setValue:[NSString stringWithFormat:@"%d",addPeopleCount] forKey:@"addPeople"];
    }
    
    
}

- (IBAction)peoplechange:(UISlider *)sender {
     int progress=(int)lroundf(sender.value);
     addPeopleCount=progress;
    //addPeopleCount=5;
    [self.labPeople setText:[NSString stringWithFormat:@"%d",progress ]];

    [self ReflashUsers];
    
}

//这个用户显示未个游戏，是否可以玩，以后每个游戏都要加在这里
-(void) checkifEnable:(int) peoplecount{
    //谁是卧底 4-10人

    //到时这里还要加入收费项
    if(peoplecount>=[[self getConfig:@"UNDERCOVER_MIN_PEOPLE"] intValue]&&peoplecount<=[[self getConfig:@"UNDERCOVER_MAX_PEOPLE"] intValue]){
        [self.btnUndercover setEnabled:true];
    }
    else
    {
        [self.btnUndercover setEnabled:false];
    }
    
     //杀人游戏 6-16人
    if(peoplecount>=[[self getConfig:@"KILLER_MIN_PEOPLE"] intValue]&&peoplecount<=[[self getConfig:@"KILLER_MAX_PEOPLE"] intValue]){
        [self.btnKiller setEnabled:true];
    }
    else
    {
        [self.btnKiller setEnabled:false];
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

@end
