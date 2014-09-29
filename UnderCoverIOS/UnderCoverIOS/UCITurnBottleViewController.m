//
//  UCITurnBottleViewController.m
//  UnderCoverIOS
//
//  Created by Li on 14-9-9.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCITurnBottleViewController.h"

@interface UCITurnBottleViewController ()

@end

@implementation UCITurnBottleViewController

int angel = 10;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)startAnimation
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:7];
    [UIView setAnimationDelegate:self];
    self.testImage.transform = CGAffineTransformMakeRotation(angel * (M_PI / 180.0f));
    NSLog(@"angel%d",angel);
    [UIView commitAnimations];
}

- (IBAction)beginTurnBottle:(id)sender {
    
//    angel = 400;
//    [self startAnimation];

    
    int rand = arc4random() % 360;
    NSLog(@"rand,%d",rand);
    for (int i = 0; i<20; i++) {
        int addAngle = i*10;
        angel += addAngle;
        if (i==19) {
            angel += rand;
        }
        
        [self startAnimation];
    }
}

-(void)addAngel
{
    
}
@end
