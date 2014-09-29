//
//  testViewController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-5-4.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "testViewController.h"
#import "UMSocial.h"

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
    
    [self uMengClick:@"game_setting"];
    [self.soundSwitch setOn:[[self getObjectFromDefault:@"ISOPENSOUND"] boolValue]];
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

- (IBAction)changeSoundSetting:(id)sender {
    BOOL isOpen = [self.soundSwitch isOn];
    NSString *value = isOpen ? @"1" : @"0";
    [self setObjectFromDefault:value key:@"ISOPENSOUND"];
}
- (IBAction)showLogin:(id)sender {

//    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
//    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//        NSLog(@"response is %@",response);
//    });
    
//    
//    UINavigationController *accountViewController =[[UMSocialControllerServiceComment defaultControllerService] getSnsAccountController];
//    
//    [self presentModalViewController:accountViewController animated:YES];

    
    BOOL isOauth = [UMSocialAccountManager isOauthWithPlatform:UMShareToQQ];
    if(!isOauth){
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToTencent];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response)
                                  {
                                      NSLog(@"response is %@",response);
                                  });
    }
    else{
        [[UMSocialDataService defaultDataService] requestSocialAccountWithCompletion:^(UMSocialResponseEntity *accountResponse){
            NSLog(@"SinaWeibo's user name is %@",[[[accountResponse.data objectForKey:@"accounts"] objectForKey:UMShareToTencent] objectForKey:@"username"]);
        }];
    }
}
@end
