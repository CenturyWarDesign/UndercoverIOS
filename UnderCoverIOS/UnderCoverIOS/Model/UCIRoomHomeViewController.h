//
//  UCIRoomHomeViewController.h
//  UnderCoverIOS
//
//  Created by 斌万 on 14-5-21.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//


#import "UCIBaseViewController.h"

@interface UCIRoomHomeViewController : UCIBaseViewController
@property (strong, nonatomic) IBOutlet UITextField *labRoomId;
@property (strong, nonatomic) IBOutlet UILabel *labName;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadIng;
@property (strong, nonatomic) IBOutlet UIButton *btnJoin;
@property (strong, nonatomic) IBOutlet UIButton *btnCreate;

@property (strong, nonatomic) IBOutlet UIButton *his_join;
@property (strong, nonatomic) IBOutlet UIButton *his_create;
@end
