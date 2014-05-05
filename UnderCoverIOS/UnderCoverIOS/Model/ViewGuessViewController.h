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
    int MaxPeopleCount;
    int MaxSonCount;
}


@property(nonatomic,weak)NSString *fathercount;
@property(nonatomic,weak)NSString *soncount;
@property(nonatomic,weak)NSString *fatherWord;
@property(nonatomic,weak)NSMutableDictionary *arrContent;
@property (strong, nonatomic) IBOutlet UIView *viewGuess;
@property (strong, nonatomic) IBOutlet UIButton *btnPublish;

@end