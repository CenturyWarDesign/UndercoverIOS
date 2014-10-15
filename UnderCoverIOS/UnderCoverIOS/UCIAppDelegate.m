//
//  UCIAppDelegate.m
//  UnderCoverIOS
//
//  Created by WensonSmith on 14-2-20.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIAppDelegate.h"
#import "MobClick.h"
#import "APService.h"
#import "HTTPBase.h"
#import "Reachability.h"
#import "UMSocial.h"
@implementation UCIAppDelegate
static bool messageCount;
static bool GAME_DEBUG;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    GAME_DEBUG=false;
//    [self readXML];
//    NSLog(@"Hello world!");
    application.applicationSupportsShakeToEdit = YES;//添加此处
    //友盟SDK
    [MobClick startWithAppkey:@"531f3fcd56240b7b2a0415ac" reportPolicy:SEND_INTERVAL   channelId:@"TEST"];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    
    [MobClick setLogEnabled:GAME_DEBUG];
    [MobClick updateOnlineConfig];
    
    [UMSocialData setAppKey:@"531f3fcd56240b7b2a0415ac"];
    
    Class cls = NSClassFromString(@"UMANUtil");
    SEL deviceIDSelector = @selector(openUDIDString);
    NSString *deviceID = nil;
    if(cls && [cls respondsToSelector:deviceIDSelector]){
        deviceID = [cls performSelector:deviceIDSelector];
    }
    if(GAME_DEBUG){
        NSLog(@"{\"oid\": \"%@\"}", deviceID);
    }
    // Override point for customization after application launch.
    
//        NSArray * tem=[MobClick classFallbacksForKeyedArchiver];
    //取得设备标识符
//    NSString * name=[[[UIDevice currentDevice] identifierForVendor] UUIDString];
//    NSDictionary * temss=[MobClick getConfigParams];
    
    
//    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
//    self.window.backgroundColor = [UIColor whiteColor];
//    [self.window makeKeyAndVisible];
    
    // Required
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)];
    // Required
    [APService setupWithOption:launchOptions];
    
    //清除脚标
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    


    
    return YES;
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Required
    [APService registerDeviceToken:deviceToken];
    HTTPBase *http= [[HTTPBase alloc] init];
    [APService setAlias:http.getUDID callbackSelector:nil object:self];
    messageCount=0;
}


+(void)setRoomPush:(NSString *)tag{
    if([tag isEqualToString:@""]){
        [APService setTags:[NSSet set] callbackSelector:nil object:self];
    }
    else{
        [APService setTags:[NSSet setWithObjects:tag,nil] callbackSelector:nil object:self];
    }

}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *) error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}


							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)readXML
{
    //获取XML文件
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"book" ofType:@"xml"];
    NSData *data = [[NSData alloc]initWithContentsOfFile:filePath];
    
    //使用NSData 对象初始化
    GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithData:data options:0 error:Nil];
    
    //获取根节点（Books）
    GDataXMLElement *rootElement = [document rootElement];
    
    //获取根节点下的子节点们
    NSArray *books = [rootElement elementsForName:@"Book"];
    
    for (GDataXMLElement *book in books) {
        //Book节点的ID属性
        NSString *bookID = [[book attributeForName:@"id"] stringValue];
        NSLog(@"Book ID is %@",bookID);
        
        //获取book结点title的值
        GDataXMLElement *title = [[book elementsForName:@"title"] objectAtIndex:0];
        NSString *bookTitle = [title stringValue];
        NSLog(@"Book title is %@",bookTitle);
        
        //获取book结点author的值
        GDataXMLElement *author = [[book elementsForName:@"author"] objectAtIndex:0];
        NSString *bookAuthor = [author stringValue];
        NSLog(@"Book Author is %@",bookAuthor);
        
        //获取book结点summary的值
        GDataXMLElement *summary = [[book elementsForName:@"summary"] objectAtIndex:0];
        NSString *bookSummary = [summary stringValue];
        NSLog(@"Book Author is %@",bookSummary);
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Required
    [APService handleRemoteNotification:userInfo];
    messageCount++;

}


+(int)messageHandler{
    return messageCount;
}
+(void) clearHandler{
    if(messageCount>0)
    {
        messageCount--;
    }
}



+(BOOL)isdebug{
    return GAME_DEBUG;
}



//取得全局配置文件，如果有debug的取debug
+(NSString *)getConfig:(NSString *)key{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"plist"];
    NSDictionary *array = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSString *valuedefault = [array objectForKey:key];
    if([UCIAppDelegate isdebug]){
        NSString *temvalue =[array objectForKey:[NSString stringWithFormat:@"%@_debug",key]];
        if([temvalue length]>0){
            valuedefault=temvalue;
        }
    }
    return valuedefault;
}


+(BOOL) isConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
    }
    
    //    if (!isExistenceNetwork) {
    //        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];//<span style="font-family: Arial, Helvetica, sans-serif;">MBProgressHUD为第三方库，不需要可以省略或使用AlertView</span>
    //        hud.removeFromSuperViewOnHide =YES;
    //        hud.mode = MBProgressHUDModeText;
    //        hud.labelText = @"当前网络不可用，请检查网络连接";  //提示的内容
    //        hud.minSize = CGSizeMake(132.f, 108.0f);
    //        [hud hide:YES afterDelay:3];
    //        return NO;
    //    }
    return isExistenceNetwork;
}



@end
