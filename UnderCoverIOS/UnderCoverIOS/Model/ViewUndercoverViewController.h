//
//  ViewUndercoverViewController.h
//  UnderCoverIOS
//
//  Created by 斌万 on 14-4-23.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIBaseViewController.h"

@interface ViewUndercoverViewController : UCIBaseViewController
{
    int PeopleCount;
    int UndercoverCount;
}
@property (strong, nonatomic) IBOutlet UISlider *sliPeople;
@property (strong, nonatomic) IBOutlet UISlider *sliUndercover;
@property (strong, nonatomic) IBOutlet UILabel *labPeopleCount;
@property (strong, nonatomic) IBOutlet UILabel *labUndercoverCount;

@end
