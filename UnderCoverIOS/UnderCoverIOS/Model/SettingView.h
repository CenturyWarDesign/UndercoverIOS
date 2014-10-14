//
//  SettingView.h
//  UnderCoverIOS
//
//  Created by 斌万 on 14-10-10.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UCIBaseViewController.h"
@interface SettingView : UITableViewController{
    UCIBaseViewController * baseCommand;
}
@property (strong, nonatomic) IBOutlet UISwitch *swiSound;
@property (strong, nonatomic) IBOutlet UILabel *labName;
@property (strong, nonatomic) IBOutlet UIImageView *imgPhoto;
@property (strong, nonatomic) IBOutlet UILabel *labVersion;

@end
