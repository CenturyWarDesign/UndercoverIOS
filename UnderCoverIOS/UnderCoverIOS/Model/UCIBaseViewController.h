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
    
    
     NSMutableArray *allPeopleSay;
}
-(void)uMengClick:(NSString *) event;
-(void)uMengValue:(NSString *) event val:(int)value;

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


-(void)removeliketoDefault:(NSString *)word;
-(void)addliketoDefault:(NSString *)word;
-(UIButton *)getCircleBtn:(int) width;
-(NSString *)getConfig:(NSString *)key;
-(void)reflashOneSec;
-(void)setBadgeValue:(int)val;
- (void)sessionDownload:(NSString *)urlString;
-(NSString *)intToString:(int) input;



-(void)initSay:(int)count;//点过的用户排除掉
-(void)disableSay:(int)removeid;//下一个发言人的编号
-(int)nextSay;
-(NSString*)getUserNewName:(int)gameuid oldName:(NSString *)oldName;
@end
