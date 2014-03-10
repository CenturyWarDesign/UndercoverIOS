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
@property (strong,nonatomic) NSMutableArray *cards;     //of cards

@end


@implementation UnderCoverGame

- (instancetype)initGameWithCards:(NSInteger)cardCount
                          theDeck:(Deck *)deck
{
    self = [super init];
    if (self) {
        for (int i=0; i<cardCount; i++) {
            Card *card =[deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            }else{
                self = Nil;
                break;
            }
            
        }
        
        
    }
    return self;
}

- (NSMutableArray *)cards{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

static const int MATCH_BONUS = 1;
static const int MISTAKE_PENALTY = 2;
static const int COST_TO_CHOOSE = 2;

- (void)choosenCardAtIndex:(NSInteger)index
{
    Card *card = [self cardAtIndex:index];
    //如果牌还未匹配，则可继续
    if (!card.matched) {
        if (card.choosen) {
            card.choosen = NO;
        }else{
            //macth against another card
            for (Card *otherCard in self.cards) {
                if (otherCard.choosen && !otherCard.matched) {
                    int matchScore = [card match:@[otherCard]];
                    NSLog(@"matchScore:%d",matchScore);
                    if (matchScore) {
                        self.score += MATCH_BONUS;
                        card.matched = YES;
                        otherCard.matched = YES;
                    }else{
                        self.score -= MISTAKE_PENALTY;
                        otherCard.choosen = NO;
                    }
                    break;
                }
            }
            
            self.score -= COST_TO_CHOOSE;
            card.choosen = YES;
        }
    }
}

- (Card *)cardAtIndex:(NSInteger)index
{
    return (index < [self.cards count]) ? self.cards[index]:Nil;
}

@end
