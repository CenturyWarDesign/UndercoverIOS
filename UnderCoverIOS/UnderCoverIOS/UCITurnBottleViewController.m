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
    [self initGame];
}


-(void)initGame{
    [self.btnPunish setHidden:YES];
    [self.btnBottle setEnabled:true];
}
- (IBAction)beginTurnBottle:(id)sender
{
    srand((unsigned)time(0));
    int randnum=rand();
    float needRotate=14*M_PI+(randnum % 628)/100.0f;
    CABasicAnimation* animation=[self rotation:5 degree:needRotate  repeatCount:0];
    [self.btnBottle.layer addAnimation:animation forKey:nil];
    [self.btnBottle setEnabled:false];
}

-(CABasicAnimation *)rotation:(float)dur degree:(float)degree repeatCount:(int)repeatCount
{
    CABasicAnimation* animation;
    animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue = [NSNumber numberWithFloat:degree];
    animation.duration= dur;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses= NO;
    animation.cumulative= YES;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    animation.repeatCount= repeatCount;
    animation.delegate= self;
    return animation;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
//    [self.btnBottle setEnabled:YES];
    [self.btnPunish setHidden:false];
    [self playHuanhu];
}
- (IBAction)chengfa:(id)sender {
    [self initGame];
}

@end
