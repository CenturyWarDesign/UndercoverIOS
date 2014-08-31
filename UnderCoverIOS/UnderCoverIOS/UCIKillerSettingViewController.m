//
//  UCIKillerSettingViewController.m
//  UnderCoverIOS
//
//  Created by jlcao on 14-8-28.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIKillerSettingViewController.h"

@interface UCIKillerSettingViewController ()

@end

@implementation UCIKillerSettingViewController
@synthesize totalcount;
@synthesize killer;
@synthesize police;
@synthesize arrContent;

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
    // Do any additional setup after loading the view.
    curTotal=[totalcount intValue];
    curKiller=[killer intValue];
    curPolice=[police intValue];
    curPinmin=curTotal-curKiller-curPolice;
    
    [self initGuess];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/////

-(void)initGuess{
    
    int width=self.BtnView.bounds.size.width;
    //int width=230;
    //    int height=self.viewGuess.bounds.size.height;
    int btnWidth=(width-30)/4;
    int btnHeight=btnWidth;
    //int PeopleCount=8;
    curPeople = 0;
    btnPeople = [[NSMutableArray alloc] init];
    for (int i=0; i<curTotal; i++) {
        CGRect frame = CGRectMake((btnWidth+5)*(i%4)+10, (i/4)*(btnHeight+10)+80, btnWidth, btnHeight);
        UIButton *someAddButton =[self getCircleBtn:btnWidth];
        [someAddButton setTitle:[NSString stringWithFormat:@"%d号",i+1] forState:UIControlStateNormal];
        someAddButton.frame = frame;
        [someAddButton setTag:i+1];
        [someAddButton addTarget:self action:@selector(tapPeople:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:someAddButton];
        [btnPeople addObject:someAddButton];
    }
    [[self BtnPunish] setTitle:@"1号描述中" forState:UIControlStateNormal];
    [self selectPeople:[btnPeople objectAtIndex:curPeople]];
        [self displayJudge];
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

-(void)tapPeople:(UIButton *)sender{
    
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
    
    txtShenFen=@"出局";
    [sender setTitle:txtShenFen forState:UIControlStateDisabled];
    [sender setEnabled:false];

    BOOL finish=false;
   // [self splitSonFather];
    if(curKiller<=0){
        [self.BtnPunish setTitle:[NSString stringWithFormat:@"杀手失败！！"] forState:UIControlStateNormal];
//        [self disabledAllButton];
        finish=true;
    }else if(curKiller>=curpp){
        [self.BtnPunish setTitle:[NSString stringWithFormat:@"杀手胜利！！"] forState:UIControlStateNormal];
//        [self disabledAllButton];
        finish=true;
    }else{
        //
    }
    if(finish){
        //点投票最后一步
//        [self uMengClick:@"click_guess_last"];
        [self playHuanhu];
        [self.BtnPunish setEnabled:true];
        [self disabledAllButton];

    }
    
}
-(void)disabledAllButton{
    for (int i=0; i<curTotal; i++) {
        UIButton * tembtn=(UIButton *)[self.view viewWithTag:i+1];
        NSString * txtShenFen=[arrContent objectForKey:[NSString stringWithFormat:@"%d",i+1]];
        [tembtn setEnabled:false];
        [tembtn setTitle:txtShenFen forState:UIControlStateDisabled];
        
    }
  //  [[self btnNext] setEnabled:NO];
}
-(void)displayJudge{
    for (int i=0; i<[totalcount intValue]; i++) {
        
        NSString * txtShenFen=[arrContent objectForKey:[NSString stringWithFormat:@"%d",i+1]];
        if ([txtShenFen isEqualToString:@"法官"]) {
            UIButton * tembtn=(UIButton *)[self.view viewWithTag:i+1];
            //NSString * txtShenFen=[arrContent objectForKey:[NSString stringWithFormat:@"%d",i+1]];
            [tembtn setEnabled:false];
            [tembtn setTitle:txtShenFen forState:UIControlStateDisabled];
            
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
