//
//  UCIAppDelegate.h
//  UnderCoverIOS
//
//  Created by WensonSmith on 14-2-20.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDataXMLNode.h"

@interface UCIAppDelegate : UIResponder <UIApplicationDelegate>{

}

@property (strong, nonatomic) UIWindow *window;


+(int)messageHandler;
+(void) clearHandler;
+(void)setRoomPush:(NSString *)tag;
+(BOOL)isdebug;
//全局配置文件
+(NSString *)getConfig:(NSString *)key;
+(BOOL) isConnectionAvailable;
@end
