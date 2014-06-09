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
@synthesize btnNext;

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
    SonCount=[soncount intValue];
    MaxSonCount=SonCount;
    [self initGuess];
    [self.btnPublish setEnabled:false];
    // Do any additional setup after loading the view.
    [self setBtnNext:[UIButton buttonWithType:UIButtonTypeRoundedRect]];
    [[self btnNext] setFrame:CGRectMake(60, 240, 200, 30)];
    [[self btnNext] setTitle:@"请下一位开始描述" forState:UIControlStateNormal];
    [self.view addSubview:[self btnNext]];
    [[self btnNext] addTarget:self action:@selector(tapNext:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initGuess{
    
    int width=self.viewGuess.bounds.size.width;
//    int height=self.viewGuess.bounds.size.height;
    int btnWidth=(width-30)/4;
    int btnHeight=btnWidth;
    
    curPeople = 0;
    btnPeople = [[NSMutableArray alloc] init];
    for (int i=0; i<PeopleCount; i++) {
        CGRect frame = CGRectMake((btnWidth+5)*(i%4)+10, (i/4)*(btnHeight+10)+80, btnWidth, btnHeight);
        UIButton *someAddButton =[self getCircleBtn:btnWidth];
        [someAddButton setTitle:[NSString stringWithFormat:@"%d号",i+1] forState:UIControlStateNormal];
        someAddButton.frame = frame;
        [someAddButton setTag:i+1];
        [someAddButton addTarget:self action:@selector(tapPeople:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:someAddButton];
        [btnPeople addObject:someAddButton];
    }
    [[self btnPublish] setTitle:@"1号描述中" forState:UIControlStateNormal];
    [self selectPeople:[btnPeople objectAtIndex:curPeople]];
}

-(void)tapNext:(UIView *)sender{
    int cur = (++curPeople % [btnPeople count]);
    UIButton *b = [btnPeople objectAtIndex:cur];
    while (![b isEnabled]) {
        cur = (++curPeople % [btnPeople count]);
        b = [btnPeople objectAtIndex:cur];
    }
    [[self btnPublish] setTitle:[NSString stringWithFormat:@"%d号描述中", (cur+1)] forState:UIControlStateDisabled];
    [self selectPeople:[btnPeople objectAtIndex:cur]];
}

-(void)selectPeople:(UIButton *)p {
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut animations:^(void){
                            p.alpha = 0.5;
                            [p setBackgroundColor:[UIColor redColor]];
                        }completion:^(BOOL finished){
                            [UIView animateWithDuration:0.5
                                                  delay:1.0
                                                options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat
                                             animations:^(void){
                                                 [UIView setAnimationRepeatCount:5];
                                                 p.alpha = 1.0;
                                                 [p setBackgroundColor:[UIColor whiteColor]];
                                             }completion:^(BOOL finished){  
                                                 
                                             }];  
                            
                        }];
}

// set max capacity is 15
-(void)splitSonFather {
    int sw = 1, fw = 1;
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

-(NSString *)getSonSetString {
    int s = sonSet;
    NSString *ret = [NSString stringWithFormat:@"%d", (s % 16)];
    while (s >>= 4) {
        ret = [NSString stringWithFormat:@"%@, %d", ret, (s % 16)];
    }
    return ret;
}

-(NSString *)getFatherSetString {
    int s = fatherSet;
    NSString *ret = [NSString stringWithFormat:@"%d", (s % 16)];
    while (s >>= 4) {
        ret = [NSString stringWithFormat:@"%@, %d", ret, (s % 16)];
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
        [self playChuishsao];
        SonCount--;
    }
    
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
    }
    if(finish){
        //点投票最后一步
        [self uMengClick:@"click_guess_last"];
        [self playHuanhu];
        [self.btnPublish setEnabled:true];
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
    [[self btnNext] setEnabled:NO];
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
