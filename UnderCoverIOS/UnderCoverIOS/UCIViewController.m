//
//  UCIViewController.m
//  UnderCoverIOS
//
//  Created by WensonSmith on 14-2-20.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIViewController.h"

@interface UCIViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;

@end

@implementation UCIViewController

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
        UIImage *cardFront = [UIImage imageNamed:@"cardFront"];
        [sender setBackgroundImage:cardFront forState:UIControlStateNormal];
        [sender setTitle:@"卧底" forState:UIControlStateNormal];
    }
    self.flipCount++;
}

@end
