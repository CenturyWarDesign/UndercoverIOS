//
//  UCIallocationViewController.h
//  UnderCoverIOS
//
//  Created by jlcao on 14-8-26.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIBaseViewController.h"

@interface UCIallocationViewController : UCIBaseViewController
{
    int totalCount;
    int Killer;
    int Police;
    NSMutableDictionary *arrContent;
    BOOL showContent;
    int nowIndex;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *labContent;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property(nonatomic,weak)NSString *totalcount;
@property(nonatomic,weak)NSString *police;
@property(nonatomic,weak)NSString *killer;


@end
