//
//  UCIBaseViewController.h
//  UnderCoverIOS
//
//  Created by 斌万 on 14-3-12.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPBase.h"

@interface UCIBaseViewController : UIViewController<UCIHttpCallback>{
    //每秒的倒计时
    NSTimer *timerSec;
}
-(void)uMengClick:(NSString *) event;
-(void)callBack:(NSArray *)data commandName:(NSString*) command;
-(void)callback:(int)code;
-(id) getObjectFromDefault:(NSString *)key;
-(void) setObjectFromDefault:(NSObject *)object key:(NSString *)key;
-(void)showAlert:(NSString *)title content:(NSString *) content;
-(NSArray *)getAllWords;
-(void)hasPlayed:(NSString *)words;


-(void)playChuishao;
-(void)playNahan;
-(void)playHuanhu;
-(void)playGuzhang;
-(BOOL)getSoundStatus;


-(void)removeliketoDefault:(NSString *)word;
-(void)addliketoDefault:(NSString *)word;
-(UIButton *)getCircleBtn:(int) width;
-(NSString *)getConfig:(NSString *)key;
-(void)setConfig:(NSString*) key newvalue:(NSString*) newvalue;
-(void)reflashOneSec;
@end
