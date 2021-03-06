//
//  UCIRoomSettingViewController.h
//  UnderCoverIOS
//
//  Created by 斌万 on 14-5-21.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIBaseViewController.h"

@interface UCIRoomSettingViewController : UCIBaseViewController{
    NSTimer *timerCheck;
    NSTimer *timerReflash;
    NSDictionary * datatosend;
    int gametype;
    NSMutableArray *userinfo;
    int addPeopleCount;
    int thistotalpeople;
    CGPoint startPoint;
    CGPoint nowPoint;
    BOOL istouch;
    NSMutableArray * userinfotem;
    NSString * willChangeUserName;
    int willChangeUserGameuid;
}
@property (strong, nonatomic) IBOutlet UILabel *labRoomId;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollUsers;

@property (strong, nonatomic) IBOutlet UIButton *btnUndercover;
@property (strong, nonatomic) IBOutlet UIButton *btnKiller;
@property (strong, nonatomic) IBOutlet UIButton *btnDouble;

@property (strong, nonatomic) IBOutlet UIButton *btnInfoRoomId;

@property (strong, nonatomic) IBOutlet UILabel *labPeople;
@property (strong, nonatomic) IBOutlet UISlider *peopleCount;

@property (strong, nonatomic) IBOutlet UIButton *btnPeople;
@property (strong, nonatomic) IBOutlet UIView *viewAllGamel;
@property (strong, nonatomic) IBOutlet UILabel *lab_under_error;
@property (strong, nonatomic) IBOutlet UILabel *lab_killer_error;

@end
