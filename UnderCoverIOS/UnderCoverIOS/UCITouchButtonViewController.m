//
//  UCITouchButtonViewController.m
//  UnderCoverIOS
//
//  Created by jlcao on 14-8-19.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCITouchButtonViewController.h"

@interface UCITouchButtonViewController ()

@end

@implementation UCITouchButtonViewController

int P_count = 5;
int num_init ;
int index_n=0;
int randNum=0;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    
//    [self.touchButton setBackgroundColor:[UIColor yellowColor]];
   
//    [self.punishButton setHidden:YES];
//    [self.touchTimesContent setText:[NSString stringWithFormat:@"%d",index_n]];
}

-(void)viewWillAppear:(BOOL)animated{
    [self initStart];
}

-(void)initStart{
    [self.punishButton setHidden:YES];
    [self uMengClick:@"game_click"];
    srand((unsigned)time(0));
    randNum = rand()% (P_count *3)+2;
    num_init=randNum;
    index_n=0;
    [self.touchButton setTitle:@"点" forState:UIControlStateNormal];
    [self.touchButton setEnabled:true];
//    [self.gailvContent setText:[NSString stringWithFormat:@"%d%@",index_n*7+7,@"%"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchButton:(id)sender {
    num_init--;
    index_n++;
    [self.touchButton setTitle:[NSString stringWithFormat:@"%d",index_n] forState:UIControlStateNormal];
//    [self.gailvContent setText:[NSString stringWithFormat:@"%d%@",index_n*7+7,@"%"]];
    if (num_init<=0)
    {
        [self.touchButton setEnabled:false];
        [self.touchButton setTitle:@"罚" forState:UIControlStateNormal];
        [self.punishButton setHidden:NO];
        [self.touchButton setAlpha:1.0f];
        [self playHuanhu];
    }
    else{
        float rate= index_n /(float)(P_count*2.5)/2+0.5;
        [self.touchButton setAlpha:rate];
        [self playChuishao];
    }
}

- (IBAction)btnPunish:(id)sender {
    [self initStart];
}

@end
