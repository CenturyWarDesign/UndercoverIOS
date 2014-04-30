//
//  NewPunishViewController.h
//  UnderCoverIOS
//
//  Created by 斌万 on 14-5-1.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIBaseViewController.h"

@interface NewPunishViewController : UCIBaseViewController

@property (strong, nonatomic) IBOutlet UITextField *txtField;
@property (strong, nonatomic) IBOutlet UITextView *txtPlace;
@property (strong, nonatomic) IBOutlet UIButton *btnSubmit2;


@property(nonatomic,weak)NSString *temContent;

@end
