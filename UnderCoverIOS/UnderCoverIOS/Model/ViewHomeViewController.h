//
//  ViewHomeViewController.h
//  UnderCoverIOS
//
//  Created by 斌万 on 14-4-27.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIBaseViewController.h"
#define PAGENUM 5

@interface ViewHomeViewController : UCIBaseViewController<UIScrollViewDelegate>{
}
@property (strong, nonatomic) IBOutlet UILabel *labMessage;

@property (strong, nonatomic) IBOutlet UIPageControl *page;

@property (strong, nonatomic) IBOutlet UIScrollView *imageScrollView;

@end
