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
int flag=1;

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

    num_init = arc4random() % P_count *3;
    [self.touchButton setEnabled:true];
    [self.touchButton setBackgroundColor:[UIColor yellowColor]];
    [self.punishButton setHidden:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)touchButton:(id)sender {
    num_init=num_init-1;
    //int flag=1;
    if (flag==1) {
        flag=0;
        [self.touchButton setBackgroundColor:[UIColor greenColor]];
        
    }else if (flag==0){
        flag=1;
    [self.touchButton setBackgroundColor:[UIColor yellowColor]];
    }
    if (num_init<=0)
    {//button disable
        //set button
        [self.touchButton setEnabled:false];
        [self.touchButton setBackgroundColor:[UIColor redColor]];
        [self.touchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.touchButton setTitle:@"接受惩罚" forState:normal];
        //[self.touchButton setText:@"卧底失败"];
       // [self.touchButton setTitle:@“bomp” forState:UIControlState normal];
        [self.punishButton setHidden:NO];
        
        
    }
    
}

@end
