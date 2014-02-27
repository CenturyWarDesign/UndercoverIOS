//
//  UnderCoverGame.m
//  UnderCoverIOS
//
//  Created by WensonSmith on 14-2-27.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UnderCoverGame.h"

@interface UnderCoverGame()

@property (nonatomic,readwrite) NSInteger score;
@property (strong,nonatomic) NSMutableArray *cards;

@end


@implementation UnderCoverGame

- (instancetype)initGameWithCards:(NSInteger)cardCount
                          theDeck:(Deck *)deck
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSMutableArray *)cards{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void)choosenCardAtIndex:(NSInteger)index
{
    Card *card = [self.cards objectAtIndex:index];
    card.choosen = YES;
}

- (Card *)cardAtIndex:(NSInteger)index
{
    Card *card = [self.cards objectAtIndex:index];
    return card;
}

@end
