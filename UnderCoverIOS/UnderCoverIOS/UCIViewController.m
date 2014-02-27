//
//  UCIViewController.m
//  UnderCoverIOS
//
//  Created by WensonSmith on 14-2-20.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIViewController.h"
#import "PlayCardDeck.h"

@interface UCIViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong,nonatomic) Deck *deck;

@end

@implementation UCIViewController


- (Deck *)deck
{
    if(!_deck) _deck = [self createDeck];
    return _deck;
}

- (Deck *)createDeck
{
    return [[PlayCardDeck alloc] init];
}


- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"ClickCount:%d",self.flipCount];
    NSLog(@"Flip Count %d",self.flipCount);
}


- (IBAction)touchCardButton:(UIButton *)sender {
    
    if ([sender.currentTitle length]) {
        UIImage *cardFront = [UIImage imageNamed:@"cardBack"];
        [sender setBackgroundImage:cardFront forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    }else{
        Card *card = [self.deck drawRandomCard];
        if (card) {
            UIImage *cardFront = [UIImage imageNamed:@"cardFront"];
            [sender setBackgroundImage:cardFront forState:UIControlStateNormal];
            [sender setTitle:card.contents forState:UIControlStateNormal];
            self.flipCount++;
        }
    }
}

@end
