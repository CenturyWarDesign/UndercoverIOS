//
//  Deck.m
//  UnderCoverIOS
//
//  Created by WensonSmith on 14-2-26.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "Deck.h"

@interface Deck()

@property (strong,nonatomic) NSMutableArray *cards;

@end


@implementation Deck


- (NSMutableArray *)cards{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}


- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    }else{
        [self.cards addObject:card];
    }
    
}

- (Card *)drawRandomCard
{
    Card *randomCard = Nil;
    if ([self.cards count]) {
        unsigned index = arc4random()%[self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}


- (void)addCard:(Card *)card
{
    [self addCard:card atTop:NO];
}

@end
