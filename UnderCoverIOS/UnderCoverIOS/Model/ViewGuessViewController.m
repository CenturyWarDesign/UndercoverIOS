//
//  ViewGuessViewController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-4-25.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "ViewGuessViewController.h"

@interface ViewGuessViewController ()

@end

@implementation ViewGuessViewController
@synthesize fathercount;
@synthesize soncount;
@synthesize fatherWord;
@synthesize arrContent;
@synthesize killer;
@synthesize police;


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
    PeopleCount=[fathercount intValue];
    MaxPeopleCount=PeopleCount;
    [self.btnPublish setEnabled:false];
    gameType=[self getObjectFromDefault:@"localGameType"];
    if([gameType isEqualToString:@"1"]){
        SonCount=[soncount intValue];
        MaxSonCount=SonCount;
        [self initGuess];
    }
    else{
        curTotal=PeopleCount;
        curKiller=[killer intValue];
        curPolice=[police intValue];
        curPinmin=curTotal-curKiller-curPolice;
         [self initGuess];
        [self displayJudge];
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initGuess{
    int width=self.scrollGuess.bounds.size.width;
//    int height=self.viewGuess.bounds.size.height;
    int btnWidth=(width-30)/4;
    int btnHeight=btnWidth;
    curPeople = 0;
    btnPeople = [[NSMutableArray alloc] init];
    for (int i=0; i<PeopleCount; i++) {
        CGRect frame = CGRectMake((btnWidth+5)*(i%4)+10, (i/4)*(btnHeight+10), btnWidth, btnHeight);
        UIButton *someAddButton =[self getCircleBtn:btnWidth];
        [someAddButton setTitle:[NSString stringWithFormat:@"%d号",i+1] forState:UIControlStateNormal];
        someAddButton.frame = frame;
        [someAddButton setTag:i+1];
         if([gameType isEqualToString:@"1"]){
             [someAddButton addTarget:self action:@selector(tapPeople:) forControlEvents:UIControlEventTouchUpInside];
         }
         else{
             [someAddButton addTarget:self action:@selector(tapPeopleKiller:) forControlEvents:UIControlEventTouchUpInside];
         }
        [self.scrollGuess addSubview:someAddButton];
        [btnPeople addObject:someAddButton];
    }
    //初始化用户发言表
    [self initSay:MaxPeopleCount];
    int sayindex=[self nextSay];
    [self.btnPublish setTitle:[NSString stringWithFormat:@"%d号用户开始描述", sayindex+1] forState:UIControlStateDisabled];
}





/*
 * 
 * sonSet/fatherSet格式: p1,p2,p3...
 * pn对应的是任务编号, 最大编号是15(4位偏移)
 * 所以使用long long来存储最多15个人, 应该是够的
 *
 */
-(void)splitSonFather {
    long long sw = 1, fw = 1;
    fatherSet = sonSet = 0;
    for (int i = 1; i <= [arrContent count]; ++i) {
        NSString * txtShenFen=[arrContent objectForKey:[NSString stringWithFormat:@"%d",i]];
        if([txtShenFen isEqualToString:fatherWord])
        {
            fatherSet += i * fw;
            fw <<= 4;
        }
        else{
            sonSet += i * sw;
            sw <<= 4;
        }
    }
}

/*
 * see splitSonFather()
 */
-(NSString *)getSonSetString {
    long long s = sonSet;
    NSString *ret = [NSString stringWithFormat:@"%d", (int)(s % 16)];
    while (s >>= 4) {
        ret = [NSString stringWithFormat:@"%@, %d", ret, (int)(s % 16)];
    }
    return ret;
}

-(NSString *)getFatherSetString {
    long long s = fatherSet;
    NSString *ret = [NSString stringWithFormat:@"%d", (int)(s % 16)];
    while (s >>= 4) {
        ret = [NSString stringWithFormat:@"%@, %d", ret, (int)(s % 16)];
    }
    return ret;
}

-(void)tapPeople:(UIButton *)sender{
    
    // reset for tapNext
    curPeople = -1;
    
    if(PeopleCount==MaxPeopleCount&&SonCount==MaxSonCount){
        //点投票第一步
         [self uMengClick:@"click_guess_first"];
    }
    
    int tag=(int)sender.tag;
    NSString * txtShenFen=[arrContent objectForKey:[NSString stringWithFormat:@"%d",tag]];
    if([txtShenFen isEqualToString:fatherWord])
    {
        [self playNahan];
        PeopleCount--;
    }
    else{
        [self playChuishao];
        SonCount--;
    }
   // curpeople=rand();
    srand((unsigned)time(0));
    curPeople=rand()%[btnPeople count];
    txtShenFen=@"出局";
    [sender setTitle:txtShenFen forState:UIControlStateDisabled];
    [sender setEnabled:false];
    
    BOOL finish=false;
    [self splitSonFather];
    if(PeopleCount<=SonCount){
        [self.btnPublish setTitle:[NSString stringWithFormat:@"卧底胜利,%@号接受惩罚", [self getFatherSetString]] forState:UIControlStateNormal];
        [self disabledAllButton];
        finish=true;
    }else if(SonCount<=0){
        [self.btnPublish setTitle:[NSString stringWithFormat:@"卧底失败,%@号接受惩罚", [self getSonSetString]] forState:UIControlStateNormal];
        [self disabledAllButton];
        finish=true;
    }else{
        //还没有结束，要下一个用户发言
        [self disableSay:sender.tag-1];
        int sayindex=[self nextSay];
        [self.btnPublish setTitle:[NSString stringWithFormat:@"%d号用户开始描述",sayindex+1] forState:UIControlStateDisabled];
    }
    if(finish){
        //点投票最后一步
        [self uMengClick:@"click_guess_last"];
        [self playHuanhu];
        [self.btnPublish setEnabled:true];
    }

}



-(void)tapPeopleKiller:(UIButton *)sender{
    
    //    // reset for tapNext
    //    curPeople = -1;
    //
    //    if(PeopleCount==MaxPeopleCount&&SonCount==MaxSonCount){
    //        //点投票第一步
    //        [self uMengClick:@"click_guess_first"];
    //    }
    //
    int tag=(int)sender.tag;
    NSString * txtShenFen=[arrContent objectForKey:[NSString stringWithFormat:@"%d",tag]];
    if([txtShenFen isEqualToString:@"杀手"])
    {
        [self playNahan];
        curKiller--;
    }
    else if ([txtShenFen isEqualToString:@"警察"]){
        [self playChuishao];
        curPolice--;
    }else if ([txtShenFen isEqualToString:@"平民"]){
        curPinmin--;
    }
    curpp=curPinmin+curPolice;
    
    if(curpp==curTotal-1){
        //第一次猜用户
        [self uMengClick:@"game_kill_guessfirst"];
    }
    
    txtShenFen=@"出局";
    [sender setTitle:txtShenFen forState:UIControlStateDisabled];
    [sender setEnabled:false];
    
    BOOL finish=false;
    // [self splitSonFather];
    if(curKiller<=0){
        [self.btnPublish setTitle:[NSString stringWithFormat:@"杀手失败，杀手接受惩罚！"] forState:UIControlStateNormal];
        //        [self disabledAllButton];
        finish=true;
    }else if(curKiller>=curpp){
        [self.btnPublish setTitle:[NSString stringWithFormat:@"杀手胜利，警察和平民接受惩罚！"] forState:UIControlStateNormal];
        //        [self disabledAllButton];
        finish=true;
    }else{
        //还没有结束，要下一个用户发言
        [self disableSay:sender.tag-1];
        int sayindex=[self nextSay];
        [self.btnPublish setTitle:[NSString stringWithFormat:@"%d号用户开始描述",sayindex+1] forState:UIControlStateDisabled];
    }
    if(finish){
        //点投票最后一步
        [self uMengClick:@"click_guess_last"];
        [self playHuanhu];
        [self.btnPublish setEnabled:true];
        [self disabledAllButton];
        
    }
    
}
//使所有的按键失效并显示相应的身份
-(void)disabledAllButton{
    for (int i=0; i<MaxPeopleCount; i++) {
        UIButton * tembtn=(UIButton *)[self.view viewWithTag:i+1];
        NSString * txtShenFen=[arrContent objectForKey:[NSString stringWithFormat:@"%d",i+1]];
        [tembtn setEnabled:false];
        [tembtn setTitle:txtShenFen forState:UIControlStateDisabled];
    }
//    [[self btnNext] setEnabled:NO];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"restart"]) //"goView2"是SEGUE连线的标识
    {
        id theSegue = segue.destinationViewController;
        //界面之间进行传值
        [theSegue setValue:[NSString stringWithFormat:@"%d",MaxPeopleCount] forKey:@"fathercount"];
        [theSegue setValue:[NSString stringWithFormat:@"%d",MaxSonCount] forKey:@"soncount"];
        //结束之后快速开始
        [self uMengClick:@"game_undercover_quickresert"];
    }
    [self uMengClick:@""];
}
- (IBAction)punish:(id)sender {
    //点击游戏惩罚
    [self uMengClick:@"game_undercover_punish"];
}



-(void)displayJudge{
    for (int i=0; i<PeopleCount; i++) {
        NSString * txtShenFen=[arrContent objectForKey:[NSString stringWithFormat:@"%d",i+1]];
        if ([txtShenFen isEqualToString:@"法官"]) {
            UIButton * tembtn=(UIButton *)[self.view viewWithTag:i+1];
            //NSString * txtShenFen=[arrContent objectForKey:[NSString stringWithFormat:@"%d",i+1]];
            [tembtn setEnabled:false];
            [tembtn setTitle:txtShenFen forState:UIControlStateDisabled];
            [self disableSay:i];
            return;
        }
    }
    //  [[self btnNext] setEnabled:NO];
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

@end
