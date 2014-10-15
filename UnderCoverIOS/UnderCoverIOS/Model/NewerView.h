//
//  NewerView.h
//  UnderCoverIOS
//
//  Created by 斌万 on 14-10-15.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIBaseViewController.h"

@interface NewerView : UCIBaseViewController<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *viewImage;
@property (strong, nonatomic) IBOutlet UIPageControl *page;

@end
