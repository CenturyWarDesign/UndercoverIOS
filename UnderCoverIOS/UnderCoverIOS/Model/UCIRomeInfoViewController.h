//
//  UCIRomeInfoViewController.h
//  UnderCoverIOS
//
//  Created by 斌万 on 14-5-21.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIBaseViewController.h"

@interface UCIRomeInfoViewController : UCIBaseViewController{
    NSTimer *timerCheck;
    NSTimer *timerReflash;
}

@property (strong, nonatomic) IBOutlet UILabel *labContent;
@property (strong, nonatomic) IBOutlet UILabel *labGameName;

//-(void)callBack:(int)code;
@end
