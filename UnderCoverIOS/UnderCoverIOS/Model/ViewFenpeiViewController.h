//
//  ViewFenpeiViewController.h
//  UnderCoverIOS
//
//  Created by 斌万 on 14-4-23.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIBaseViewController.h"

@interface ViewFenpeiViewController : UCIBaseViewController{
    NSMutableDictionary * arrContent;
    int PeopleCount;
    int SonCount;
    BOOL showContent;
    int nowIndex;
    NSString * fatherWrod;
    NSString * sonWord;
    NSString * wordkind;
    BOOL kongbai;
}
@property (strong, nonatomic) IBOutlet UIImageView *imgHide;
@property (strong, nonatomic) IBOutlet UILabel *labContent;
@property (strong, nonatomic) IBOutlet UIButton *btnNext;
@property (strong, nonatomic) IBOutlet UIButton *btnRelaodWords;


@property(nonatomic,weak)NSString *fathercount;
@property(nonatomic,weak)NSString *soncount;

@end
