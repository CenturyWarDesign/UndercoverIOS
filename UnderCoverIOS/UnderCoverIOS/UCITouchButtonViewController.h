//
//  UCITouchButtonViewController.h
//  UnderCoverIOS
//
//  Created by jlcao on 14-8-19.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIBaseViewController.h"

@interface UCITouchButtonViewController : UCIBaseViewController
@property (weak, nonatomic) IBOutlet UIButton *touchButton;
@property (strong, nonatomic) IBOutlet UIView *punishButton;
@property (weak, nonatomic) IBOutlet UILabel *touchTimes;
@property (weak, nonatomic) IBOutlet UILabel *gailv;
@property (weak, nonatomic) IBOutlet UILabel *touchTimesContent;
@property (weak, nonatomic) IBOutlet UILabel *gailvContent;

@end
