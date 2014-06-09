//
//  UCIHelpViewController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-5-31.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIHelpViewController.h"
#import "UCIAppDelegate.h"

@interface UCIHelpViewController ()

@end

@implementation UCIHelpViewController

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
-(void) viewWillAppear:(BOOL)animated{
    
    
    NSString * help=[UCIAppDelegate getConfig:@"help"] ;
    NSURLRequest * request=[NSURLRequest requestWithURL:[NSURL URLWithString:help]];
    [self.webView loadRequest:request];
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

@end
