//
//  PlayCard.h
//  UnderCoverIOS
//
//  Created by WensonSmith on 14-2-26.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "Card.h"

@interface PlayCard : Card


@property (strong,nonatomic) NSString *suit;
@property (nonatomic) NSInteger rank;

+ (NSArray *)validSuits;
+ (NSInteger)maxRank;

@end
