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
}
@property (strong, nonatomic) IBOutlet UILabel *labRoomID;
@property (strong, nonatomic) IBOutlet UIScrollView *viewPeople;
@property (strong, nonatomic) IBOutlet UILabel *labGameName;
@property (strong, nonatomic) IBOutlet UILabel *labStatus;
@property(nonatomic,weak)NSDictionary *gameData;
@property (strong, nonatomic) IBOutlet UILabel *labPunishTitle;
@property (strong, nonatomic) IBOutlet UITextView *labPunishContent;
@property (strong, nonatomic) IBOutlet UILabel *labMeWord;
@property (strong, nonatomic) IBOutlet UISwitch *btnShowWord;
@property (strong, nonatomic) IBOutlet UIScrollView *viewPop;
@property (strong, nonatomic) IBOutlet UIButton *btnShowPunish;

-(void) sendToSendPunish:(NSString *) str;
-(NSString *) getLoserStr:(NSString *)loser;
-(void)disabledAllButton;
@end