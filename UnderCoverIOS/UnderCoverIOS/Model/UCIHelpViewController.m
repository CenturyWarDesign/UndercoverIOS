//
//  UCIHelpViewController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-5-31.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIHelpViewController.h"
#import "UCIAppDelegate.h"
#import "HTTPBase.h"

@interface UCIHelpViewController ()

@end

@implementation UCIHelpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self setObjectFromDefault:[data objectForKey:@"newgame"] key:@"newgame"];
//        int a=self.getAllWords;
//        self.
//        self.tabBarItem.badgeValue=@"1";
    }
   
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self uMengClick:@"game_help"];
    [self setBadgeValue:0];
 
    [self loadPage:@"help"];
    // Do any additional setup after loading the view.
}
-(void)loadPage:(NSString *)page{
    HTTPBase *ht=[[HTTPBase alloc] init];;
    
    NSString * homepage=[self getObjectFromDefault:@"homepage"];
    if(homepage.length==0||[UCIAppDelegate isdebug]){
        homepage=[UCIAppDelegate getConfig:@"homepage"];
    }
    NSString * ipaddress=[NSString stringWithFormat:@"%@?showpage=%@&username=%@", homepage,page,[ht getUDID]];
    NSURLRequest * request=[NSURLRequest requestWithURL:[NSURL URLWithString:ipaddress]];
    [self.webView loadRequest:request];
}
-(void) viewWillAppear:(BOOL)animated{
    NSString * showPage=[self getObjectFromDefault:@"HELP_OPEN"];
    if(showPage.length>0){
        [self loadPage:showPage];
        [self setObjectFromDefault:@"" key:@"HELP_OPEN"];
    }

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
