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
}
@property (strong, nonatomic) IBOutlet UILabel *labRoomId;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollUsers;


@end
