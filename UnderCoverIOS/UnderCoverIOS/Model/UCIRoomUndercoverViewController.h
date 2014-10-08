//
//  UCIRoomUndercoverViewController.h
//  UnderCoverIOS
//
//  Created by 斌万 on 14-5-24.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIBaseViewController.h"

@interface UCIRoomUndercoverViewController : UCIBaseViewController
{
    NSMutableArray * datagame;
    int PeopleCount;
    int SonCount;
    int MaxPeopleCount;
    int MaxSonCount;
    NSString * sonWord;
    NSString * fatherWord;
    int roomtype;
    //这个显示用户身份的时间
    int showShenfenSec;
    NSMutableDictionary * showShenfen;
    
    //杀人游戏点击
    int KillerCount;
    int PoliceCount;
    int Pinmin;
    
    //1.谁是卧底2.杀人游戏
//    int gameType;
    
}
@property (strong, nonatomic) IBOutlet UILabel *labStatus;
@property(nonatomic,weak)NSDictionary *gameData;
@property(nonatomic,retain)NSString *addPeople;
@property(nonatomic,retain)NSString *gameType;

@property (strong, nonatomic) IBOutlet UILabel *labPunishTitle;
@property (strong, nonatomic) IBOutlet UITextView *labPunishContent;
@property (strong, nonatomic) IBOutlet UILabel *labMeWord;
@property (strong, nonatomic) IBOutlet UISwitch *btnShowWord;
@property (strong, nonatomic) IBOutlet UIScrollView *viewPop;


-(void) sendToSendPunish:(NSString *) str;
-(NSString *) getLoserStr:(NSString *)loser;
-(void)disabledAllButton;


@property (strong, nonatomic) IBOutlet UIButton *btn_self;
@property (strong, nonatomic) IBOutlet UIButton *btn_no1;
@property (strong, nonatomic) IBOutlet UIButton *btn_no2;
@property (strong, nonatomic) IBOutlet UIButton *btn_no3;
@property (strong, nonatomic) IBOutlet UIButton *btn_no4;




@end
