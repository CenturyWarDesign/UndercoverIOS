//
//  testViewController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-5-4.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "testViewController.h"

@interface testViewController ()

@end

@implementation testViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnTest:(id)sender {
//    NSString * tem =@"dlkajdl;fjal";
//    NSString * tem2=[NSString stringWithFormat:@"%d",3];
//    NSLog(@"dddd");
//    [[self.labTest setText:tem2];
}



- (IBAction)btnT:(UIButton *)sender {
    sender.backgroundColor=[UIColor redColor];
}

@end
