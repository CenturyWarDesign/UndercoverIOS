//
//  UCIViewNetPunishController.h
//  UnderCoverIOS
//
//  Created by 斌万 on 14-10-9.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIBaseViewController.h"

@interface UCIViewNetPunishController : UCIBaseViewController<UITableViewDataSource,UITableViewDelegate>{
    BOOL nibsRegistered;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,weak)NSMutableArray *punishinfo;
@end
