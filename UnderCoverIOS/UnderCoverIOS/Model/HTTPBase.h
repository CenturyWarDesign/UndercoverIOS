//
//  BaseModel.h
//  UnderCoverIOS
//
//  Created by 斌万 on 14-3-10.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UCIHttpCallback.h"
//#import <UIKit/UIKit.h>

@interface HTTPBase : NSObject{
    id<UCIHttpCallback>delegate;
}

@property(nonatomic,retain)id<UCIHttpCallback>delegate;

- (void)baseHttp:(NSString *)command;
- (void)baseHttp:(NSString *)command paramsdata:(NSDictionary *)data;
- (NSString *)getUDID;
@end
