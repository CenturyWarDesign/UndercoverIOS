//
//  PlayCard.m
//  UnderCoverIOS
//
//  Created by WensonSmith on 14-2-26.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "PlayCard.h"

@implementation PlayCard

@synthesize suit = _suit;

- (NSString *)contents
{
    NSArray *rankStrings = [PlayCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)validSuits
{
    return @[@"♣",@"♠",@"♦",@"♥"];
}

+ (NSArray *)rankStrings
{
    return @[@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSInteger)maxRank
{
    return [[PlayCard rankStrings] count]-1;
}


- (void)setSuit:(NSString *)suit
{
    if ([[PlayCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}


- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

- (void)setRank:(NSInteger)rank
{
    if (rank <= [PlayCard maxRank]) {
        _rank = rank;
    }
}

@end
