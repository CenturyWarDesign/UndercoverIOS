//
//  Card.m
//  UnderCoverIOS
//
//  Created by WensonSmith on 14-2-25.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "Card.h"

@interface Card()



@end


@implementation Card

- (int)match:(NSArray *)cards
{
    int score = 0;
    
    for (Card *card in cards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end
