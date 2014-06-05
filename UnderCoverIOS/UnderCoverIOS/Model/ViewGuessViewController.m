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
    for (int i=0; i<PeopleCount; i++) {
        CGRect frame = CGRectMake((btnWidth+5)*(i%4)+10, (i/4)*(btnHeight+10)+80, btnWidth, btnHeight);
        UIButton *someAddButton =[self getCircleBtn:btnWidth];
        [someAddButton setTitle:[NSString stringWithFormat:@"%d号",i+1] forState:UIControlStateNormal];
        someAddButton.frame = frame;
        [someAddButton setTag:i+1];
        [someAddButton addTarget:self action:@selector(tapPeople:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:someAddButton];
    }
}

-(void)tapPeople:(UIButton *)sender{
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
    if(PeopleCount<=SonCount){
        [self.btnPublish setTitle:@"卧底胜利,接受惩罚" forState:UIControlStateNormal];
        [self disabledAllButton];
        finish=true;
    }else if(SonCount<=0){
        [self.btnPublish setTitle:@"卧底失败,接受惩罚" forState:UIControlStateNormal];
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
