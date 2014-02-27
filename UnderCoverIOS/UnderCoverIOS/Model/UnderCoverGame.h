//
//  UnderCoverGame.h
//  UnderCoverIOS
//
//  Created by WensonSmith on 14-2-27.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface UnderCoverGame : NSObject

@property (nonatomic,readonly) NSInteger score;

- (instancetype)initGameWithCards:(NSInteger) cardCount
                          theDeck:(Deck *)deck;

- (void)choosenCardAtIndex:(NSInteger)index;
- (Card *)cardAtIndex:(NSInteger)index;

@end
