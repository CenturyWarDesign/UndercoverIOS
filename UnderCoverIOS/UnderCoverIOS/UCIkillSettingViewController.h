//
//  UCIkillSettingViewController.h
//  UnderCoverIOS
//
//  Created by jlcao on 14-8-24.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "ViewUndercoverViewController.h"

@interface UCIkillSettingViewController : UCIBaseViewController
{
    int totalCount;
}
@property (weak, nonatomic) IBOutlet UISlider *totalSlider;
@property (weak, nonatomic) IBOutlet UILabel *totalLable;

@end
