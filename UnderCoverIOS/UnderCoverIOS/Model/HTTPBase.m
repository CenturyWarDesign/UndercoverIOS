//
//  BaseModel.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-3-10.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "HTTPBase.h"
#import "AFHTTPRequestOperation.h"

@implementation HTTPBase

@synthesize delegate;

- (void)baseHttp:(NSString *)command {
    NSString *URLTmp = [NSString stringWithFormat:@"http://42.121.123.185/CenturyServer/Entry.php?cmd=%@",command];
    NSString *URLTmp1 = [URLTmp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];  //转码成UTF-8  否则可能会出现错误
    URLTmp = URLTmp1;
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
        
        NSData *resData2 = [[NSData alloc] initWithData:[datastr dataUsingEncoding:NSUTF8StringEncoding]];
        //系统自带JSON解析
        NSArray *resultDic2 = [NSJSONSerialization JSONObjectWithData:resData2 options:NSJSONReadingMutableLeaves error:nil];
        
        
        [self.delegate callBack:resultDic2 commandName:command];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure: %@", error);
        
    }];
    [operation start];
    
}


//- (void)winHttpFinish:(NSString *)command{
//    if([command isEqualToString:@"PublishRandomOne"]){
//        NSLog(@"PublishRandomOne 函数的回调");

//    }
//}
@end
