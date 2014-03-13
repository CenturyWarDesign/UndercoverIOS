//
//  UCIPublishNet.h
//  UnderCoverIOS
//
//  Created by 斌万 on 14-3-13.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//  网络谁是卧底
//

#import "UCIBaseViewController.h"

@interface UCIPublishNet : UCIBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (copy,nonatomic)NSArray *dowarves;
@end
