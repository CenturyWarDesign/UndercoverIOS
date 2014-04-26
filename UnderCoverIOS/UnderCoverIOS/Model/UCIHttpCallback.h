//
//  UCIHttpCallback.h
//  UnderCoverIOS
//
//  Created by 斌万 on 14-3-10.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UCIHttpCallback <NSObject>
@required
-(void)callBack:(NSDictionary *)data commandName:(NSString*) command;
@end
