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
    [self.btnTap setEnabled:true];
//    CGRect oldFrame=self.btnBottle.frame;

    self.btnBottle.layer.anchorPoint=CGPointMake(self.btnTap.bounds.size.width/self.btnBottle.bounds.size.width/2, 0.5);
//    self.btnBottle.frame=CGRectMake(143, 278, 12, 12);
//    CGRect oldFrame2=self.btnBottle.frame;
//    self.btnBottle.bounds.origin.x= self.btnTap.bounds.origin.x;
}
- (IBAction)beginTurnBottle:(id)sender
{
    srand((unsigned)time(0));
    int randnum=rand();
    float needRotate=14*M_PI+(randnum % 628)/100.0f;
    CABasicAnimation* animation=[self rotation:5 degree:needRotate  repeatCount:0];
    [self.btnBottle.layer addAnimation:animation forKey:nil];
    [self.btnTap setEnabled:false];
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
