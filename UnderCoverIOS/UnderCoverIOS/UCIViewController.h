//
//  UCIViewController.h
//  UnderCoverIOS
//
//  Created by WensonSmith on 14-2-20.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EAIntroView.h"
#import "UCIHttpCallback.h"


@interface UCIViewController : UIViewController<UCIHttpCallback>
-(void)callBack:(NSArray *)data commandName:(NSString*) command;
@end
