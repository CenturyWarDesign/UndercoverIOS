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
}
@property (strong, nonatomic) IBOutlet UIImageView *imgHide;
@property (strong, nonatomic) IBOutlet UILabel *labContent;
@property (strong, nonatomic) IBOutlet UIButton *btnNext;


@end
