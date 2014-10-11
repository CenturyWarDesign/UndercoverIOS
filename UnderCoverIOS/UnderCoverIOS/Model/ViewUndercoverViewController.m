//
//  ViewUndercoverViewController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-4-23.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "ViewUndercoverViewController.h"

@interface ViewUndercoverViewController ()

@end

@implementation ViewUndercoverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.tabBarController.tabBar setHidden:TRUE];
}

- (void)viewDidLoad
{

    [super viewDidLoad];
    self.gameType=[self getObjectFromDefault:@"localGameType"];
    
    //判断游戏类别
    if([self.gameType isEqualToString:@"1"]){
        [self initUndercover];
        self.title=@"谁是卧底";
    }else if([self.gameType isEqualToString:@"2"]){
        [self initKiller];
        self.title=@"杀人游戏";
    }
    
    
    // Do any additional setup after loading the view.
}

-(void)initUndercover{
    self.labUnderDes.hidden=NO;
    self.sliUndercover.hidden=NO;
    self.labUndercoverCount.hidden=NO;
    
    PeopleCount=4;
    UndercoverCount=1;
    self.labPeopleCount.text=[NSString stringWithFormat:@"%d",PeopleCount];
    self.labUndercoverCount.text=[NSString stringWithFormat:@"%d",UndercoverCount];
    self.sliPeople.maximumValue=12;
    self.sliPeople.minimumValue=4;
    self.sliUndercover.maximumValue=4;
    self.sliUndercover.minimumValue=1;
    self.sliPeople.value=PeopleCount;
    self.sliUndercover.value=UndercoverCount;
    
}
-(void)initKiller{
     PeopleCount=6;
    self.sliPeople.maximumValue=16;
    self.sliPeople.minimumValue=6;
    self.labUnderDes.hidden=YES;
    self.sliUndercover.hidden=YES;
    self.labUndercoverCount.hidden=YES;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)sliPeoplechange:(UISlider *)sender {
    int progress=(int)lroundf(sender.value);
    PeopleCount=progress;
    UndercoverCount=MIN((int)lroundf(PeopleCount/3), UndercoverCount);
    //计算平民和卧底的比例
    [self updateCount];
}
- (IBAction)sliUndercoverChange:(UISlider *)sender {
    int progress=(int)lroundf(sender.value);
    UndercoverCount=progress;
    //计算平民和卧底的比例
    PeopleCount=MAX(UndercoverCount*3, PeopleCount);
    [self updateCount];
}

-(void)updateCount{
    self.sliPeople.value=PeopleCount;
    self.labPeopleCount.text=[NSString stringWithFormat:@"%d",PeopleCount];
    self.sliUndercover.value=UndercoverCount;
    self.labUndercoverCount.text=[NSString stringWithFormat:@"%d",UndercoverCount];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"segueFenpei"]) //"goView2"是SEGUE连线的标识
    {
//        id theSegue = segue.destinationViewController;
        [self setObjectFromDefault:[NSString stringWithFormat:@"%d",PeopleCount] key:@"fathercount"];
        if([self.gameType isEqualToString:@"1"]){
            [self setObjectFromDefault:[NSString stringWithFormat:@"%d",UndercoverCount] key:@"soncount"];
        }
        //点击之后开始游戏
//        [self uMengClick:@"game_undercover_start"];
    }
}




@end
