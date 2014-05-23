//
//  UCIBaseViewController.h
//  UnderCoverIOS
//
//  Created by 斌万 on 14-3-12.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPBase.h"

@interface UCIBaseViewController : UIViewController<UCIHttpCallback>
-(void)uMengClick:(NSString *) event;
-(void)callBack:(NSArray *)data commandName:(NSString*) command;
-(id) getObjectFromDefault:(NSString *)key;
-(void) setObjectFromDefault:(NSObject *)object key:(NSString *)key;
-(void)showAlert:(NSString *)title content:(NSString *) content;
-(NSArray *)getAllWords;
-(void)hasPlayed:(NSString *)words;


-(void)playChuishsao;
-(void)playNahan;
-(void)playHuanhu;
-(void)playGuzhang;


-(void)removeliketoDefault:(NSString *)word;
-(void)addliketoDefault:(NSString *)word;
@end
