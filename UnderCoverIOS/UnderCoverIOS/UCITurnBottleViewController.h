//
//  UCITurnBottleViewController.h
//  UnderCoverIOS
//
//  Created by Li on 14-9-9.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIBaseViewController.h"

@interface UCITurnBottleViewController : UCIBaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *testImage;
@property (weak, nonatomic) IBOutlet UIButton *beginTurnBottleButton;
- (IBAction)beginTurnBottle:(id)sender;

@end
