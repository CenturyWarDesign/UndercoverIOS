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
    PeopleCount=12;
    SonCount=4;
    arrContent=[[NSMutableDictionary alloc] init];
    [self initWords];
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
