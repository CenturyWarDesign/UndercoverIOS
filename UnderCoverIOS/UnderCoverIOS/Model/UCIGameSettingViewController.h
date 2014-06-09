//
//  UCIGameSettingViewController.h
//  UnderCoverIOS
//
//  Created by 斌万 on 14-6-8.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIBaseViewController.h"

#import <StoreKit/StoreKit.h>
enum{
    IPAvip1,
    IPAvip2,
    IPAvip3,
}buyCoinisTag;

@interface UCIGameSettingViewController : UCIBaseViewController<SKProductsRequestDelegate,SKPaymentTransactionObserver>
{
    int  buyType;
}
@property (strong, nonatomic) IBOutlet UISwitch * switchOn;



@end
