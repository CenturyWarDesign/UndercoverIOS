//
//  Deck.h
//  UnderCoverIOS
//
//  Created by WensonSmith on 14-2-26.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
