//
//  ChangeUserName.h
//  UnderCoverIOS
//
//  Created by 斌万 on 14-10-13.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIBaseViewController.h"

@interface ChangeUserName : UCIBaseViewController{
    NSString * gameuidWillchange;
}


@property (strong, nonatomic) IBOutlet UITextField *labUserName;
@property(nonatomic,weak)NSString *username;
@property(nonatomic,weak)NSString *gameuid;

@end
