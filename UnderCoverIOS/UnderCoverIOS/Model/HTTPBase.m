//
//  BaseModel.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-3-10.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "HTTPBase.h"
#import "AFHTTPRequestOperation.h"
#import "MobClick.h"

@implementation HTTPBase

@synthesize delegate;


- (void)baseHttp:(NSString *)command paramsdata:(NSDictionary *)data{
//    NSString * ipaddress=@"http://192.168.1.110/";
    NSString * ipaddress=@"http://42.121.123.185/";
    
//    NSMutableString * temstring=[[NSMutableString alloc] initWithString:@""];
//    if([data count]>0){
//        NSEnumerator * enumerator = [data keyEnumerator];;
//        id object;
//        //遍历输出
//        while(object = [enumerator nextObject])
//        {
//            //在这里我们得到的是键值，可以通过（1）得到，也可以通过这里得到的键值来得到它对应的value值
//            //通过NSDictionary对象的objectForKey方法来得到
//            //其实这里定义objectValue这个对象可以直接用NSObject，因为我们已经知道它的类型了，id在不知道类型的情况下使用
//            id objectValue = [data objectForKey:object];
//            if(objectValue != nil){
//                [temstring appendString:[NSString stringWithFormat:@"&%@=%@",objectValue,object]];
//            }
//        }
////        NSString ;
//
    NSString * temjson= [self DataTOjsonString:data];
    NSString * sign=[self DataTOjsonString:[NSDictionary dictionaryWithObjectsAndKeys:[self getUDID],@"uid",@"IOS",@"channel",nil]];
    NSString *URLTmp = [NSString stringWithFormat:@"%@CenturyServer/Entry.php?cmd=%@&sign=%@&data=%@",ipaddress,command,sign,temjson];
    NSString *URLTmp1 = [URLTmp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];  //转码成UTF-8  否则可能会出现错误
    URLTmp = URLTmp1;
    NSLog(@"调用的报文:%@",URLTmp);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: URLTmp]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", operation.responseString);
        
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        NSData *resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:resData options:NSJSONReadingMutableLeaves error:nil];
        //        NSLog(resultDic);
        NSString * datastr=[resultDic objectForKey:@"data"];
        int code=[[resultDic objectForKey:@"code"] intValue];
        
        NSData *resData2 = [[NSData alloc] initWithData:[datastr dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSDictionary *resultDic2 = [NSJSONSerialization JSONObjectWithData:resData2 options:NSJSONReadingMutableLeaves error:nil];
        
        
        [self.delegate callBack:resultDic2 commandName:command code:code];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure: %@", error);
        
    }];
    [operation start];
}



- (void)baseHttp:(NSString *)command  {
//    NSDictionary * device_id=[MobClick ];

    [self baseHttp:command paramsdata:[NSDictionary dictionaryWithObjectsAndKeys:nil]];
    
}


//- (void)winHttpFinish:(NSString *)command{
//    if([command isEqualToString:@"PublishRandomOne"]){
//        NSLog(@"PublishRandomOne 函数的回调");

//    }
//}

-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:0 // Pass 0 if you don't care about the readability of the generated string
                                                    error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

//取得设备唯一标识
-(NSString *)getUDID{
    NSString * udid= [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    udid=[udid stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSLog(@"UDID:%@",udid);
    return udid;
}

@end
