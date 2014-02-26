//
//  PlayCardDeck.m
//  UnderCoverIOS
//
//  Created by WensonSmith on 14-2-26.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "PlayCardDeck.h"
#import "PlayCard.h"

@implementation PlayCardDeck

- (instancetype)init
{
    self = [super init];
    if (self) {
        for (NSString *suit in [PlayCard validSuits]) {
            for (NSInteger rank = 1; rank <= [PlayCard maxRank]; rank++) {
                PlayCard *card = [[PlayCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                
                [self addCard:card];
            }
        }
    }
    
    return self;
}

@end
