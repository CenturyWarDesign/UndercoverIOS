//
//  UCIViewController.m
//  UnderCoverIOS
//
//  Created by WensonSmith on 14-2-20.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIViewController.h"
#import "PlayCardDeck.h"
#import "UnderCoverGame.h"

@interface UCIViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong,nonatomic) Deck *deck;
@property (nonatomic,strong) UnderCoverGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end

@implementation UCIViewController

- (UnderCoverGame *)game
{
    NSLog(@"%lu",(unsigned long)[self.cardButtons count]);

    if (_game) {
        _game = [[UnderCoverGame alloc] initGameWithCards:[self.cardButtons count]
                                                  theDeck:[self createDeck]];
    }
    return _game;
}


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
    
    NSInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game choosenCardAtIndex:cardIndex];
    
    [self updateUI];
    
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        NSInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.matched;

    }
}

- (NSString *)titleForCard:(Card *)card
{
    return card.choosen ? card.contents:Nil;
}


- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.choosen ? @"cardFront":@"cardBack"];
}


@end
