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
}



- (IBAction)beginTurnBottle:(id)sender
{
    srand((unsigned)time(0));
    int randnum=rand();
    NSLog(@"%d",randnum);
    float needRotate=10*M_PI+(randnum % 628)/100.0f;
    NSLog(@"%d",randnum % 628);
    NSLog(@"%f",needRotate);
    CABasicAnimation* animation=[self rotation:3 degree:needRotate direction:2 repeatCount:0];
    [self.btnBottle.layer addAnimation:animation forKey:nil];
}








-(CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount

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
@end
