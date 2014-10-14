//
//  ViewGuessViewController.h
//  UnderCoverIOS
//
//  Created by 斌万 on 14-4-25.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIBaseViewController.h"

@interface ViewGuessViewController : UCIBaseViewController{
    int PeopleCount;
    int SonCount;
    long long fatherSet;
    long long sonSet;
    int MaxPeopleCount;
    int MaxSonCount;
    int curPeople;
    NSMutableArray *btnPeople;
    //这一块是发言人顺序进行发言
    
    int curPolice;
    int curKiller;
    int curTotal;
    int curPinmin;
    int curpp;
    
    NSString * gameType;
   
}


@property(nonatomic,weak)NSString *fathercount;
@property(nonatomic,weak)NSString *soncount;
@property(nonatomic,weak)NSString *fatherWord;
@property(nonatomic,weak)NSMutableDictionary *arrContent;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollGuess;
@property (strong, nonatomic) IBOutlet UIButton *btnPublish;

@property(nonatomic,weak)NSString *killer;
@property(nonatomic,weak)NSString *police;
@end
