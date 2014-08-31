//
//  UCIKillerSettingViewController.h
//  UnderCoverIOS
//
//  Created by jlcao on 14-8-28.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIBaseViewController.h"

@interface UCIKillerSettingViewController : UCIBaseViewController{
    int curPeople;
    NSMutableArray *btnPeople;
    int curPolice;
    int curKiller;
    int curTotal;
    int curPinmin;
    int curpp;
    
}
@property (weak, nonatomic) IBOutlet UIButton *BtnPunish;
@property (weak, nonatomic) IBOutlet UIView *BtnView;
@property(nonatomic,weak)NSMutableDictionary *arrContent;
@property(nonatomic,weak)NSString *totalcount;
@property(nonatomic,weak)NSString *killer;
@property(nonatomic,weak)NSString *police;

@end
