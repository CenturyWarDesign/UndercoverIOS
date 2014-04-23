//
//  UCIAppDelegate.m
//  UnderCoverIOS
//
//  Created by WensonSmith on 14-2-20.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIAppDelegate.h"
#import "MobClick.h"
@implementation UCIAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    [self readXML];
//    NSLog(@"Hello world!");
    application.applicationSupportsShakeToEdit = YES;//添加此处
    //友盟SDK
    [MobClick startWithAppkey:@"531f3fcd56240b7b2a0415ac" reportPolicy:SEND_INTERVAL   channelId:@"TEST"];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    [MobClick setLogEnabled:YES];
    // Override point for customization after application launch.
    
//        NSArray * tem=[MobClick classFallbacksForKeyedArchiver];
    //取得设备标识符
//    NSString * name=[[[UIDevice currentDevice] identifierForVendor] UUIDString];
//    NSDictionary * temss=[MobClick getConfigParams];
    return YES;
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
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

@end
