//
//  ViewFenpeiViewController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-4-23.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "ViewFenpeiViewController.h"

@interface ViewFenpeiViewController ()

@end

@implementation ViewFenpeiViewController

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
    PeopleCount=4;
    SonCount=1;
    arrContent=[[NSMutableDictionary alloc] init];
    [self initWords];
    showContent=true;
    nowIndex=1;
    [self.labContent setText:@""];
    [self.btnNext setTitle:[NSString stringWithFormat:@"第%d号",nowIndex] forState:UIControlStateNormal];
//       [self performSegueWithIdentifier:@"segueToGuess" sender:self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initWords{
    NSString * fatherWrod=@"父亲";
    NSString * sonWord=@"孩子";
    for (int i=1;i<=PeopleCount; i++) {
        [arrContent setValue:fatherWrod forKey:[NSString stringWithFormat:@"%d",i]];
    }
    while (SonCount>0) {
        int tem=lroundf(rand()%PeopleCount);
        NSString * temword=[arrContent objectForKey:[NSString stringWithFormat:@"%d",tem]];
        if(![temword isEqualToString:sonWord]){
            [arrContent setValue:sonWord forKey:[NSString stringWithFormat:@"%d",tem]];
            SonCount--;
        }
    }
}


- (IBAction)nextOne:(id)sender {
    if(showContent){
        NSString * showtem=[arrContent objectForKey:[NSString stringWithFormat:@"%d",nowIndex]];
        [self.labContent setText:showtem];
        [self.btnNext setTitle:@"请交给下一位" forState:UIControlStateNormal];
        if(nowIndex==PeopleCount){
            [self.btnNext setTitle:@"开始竞猜" forState:UIControlStateNormal];
            [self performSegueWithIdentifier:@"segueToGuess" sender:self];
        }
    }
    else{
        nowIndex++;
        [self.labContent setText:@""];
        [self.btnNext setTitle:[NSString stringWithFormat:@"第%d号",nowIndex] forState:UIControlStateNormal];
    }
    showContent=!showContent;
    [self.imgHide setHidden:!showContent];
    [self.labContent setHidden:showContent];
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

@end
