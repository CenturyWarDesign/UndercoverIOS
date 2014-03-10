//
//  Card.h
//  UnderCoverIOS
//
//  Created by WensonSmith on 14-2-25.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong,nonatomic) NSString *contents;

@property (nonatomic) BOOL choosen;
@property (nonatomic) BOOL matched;

- (int)match:(NSArray *)cards;

@end
