//
//  testViewController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-5-4.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "testViewController.h"
#import "UMSocial.h"
#import "AFHTTPRequestOperation.h"
#import "UIImageView+WebCache.h"
//#import "SDImageCache.h"
//#import "SDWebImage/UIImageView+WebCache.h"

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

    //检测是否登录
    [self checkIsLogin];
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

    
    BOOL isOauth = [UMSocialAccountManager isOauthWithPlatform:UMShareToSina];
    if(!isOauth){
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response)
                                  {
                                      NSLog(@"response is %@",response);
                                  });
    }
    else{
        [[UMSocialDataService defaultDataService] requestSocialAccountWithCompletion:^(UMSocialResponseEntity *accountResponse){
            NSLog(@"SinaWeibo's user name is %@",[[[accountResponse.data objectForKey:@"accounts"] objectForKey:UMShareToSina] objectForKey:@"username"]);
        }];
    }
}

-(BOOL)checkIsLogin{
    BOOL isOauthSina = [UMSocialAccountManager isOauthWithPlatform:UMShareToSina];
    if(isOauthSina){
        [[UMSocialDataService defaultDataService] requestSocialAccountWithCompletion:^(UMSocialResponseEntity *accountResponse){
            NSString * username=[[[accountResponse.data objectForKey:@"accounts"] objectForKey:UMShareToSina] objectForKey:@"username"];
            NSString * photoPath=[[[accountResponse.data objectForKey:@"accounts"] objectForKey:UMShareToSina] objectForKey:@"icon"];
            [self.labName setText:username];
            [self.imgPhoto sd_setImageWithURL:[NSURL URLWithString: photoPath] placeholderImage:nil];
            [self setObjectFromDefault:username key:@"username"];
            [self updateUserNameImage:username photo:photoPath];
        }];
        [self hideLiginBtn];
        return true;
    }
    BOOL isOauthQQ = [UMSocialAccountManager isOauthWithPlatform:UMShareToSina];
    if(isOauthQQ){
        [[UMSocialDataService defaultDataService] requestSocialAccountWithCompletion:^(UMSocialResponseEntity *accountResponse){
            NSString * username=[[[accountResponse.data objectForKey:@"accounts"] objectForKey:UMShareToQQ] objectForKey:@"username"];
            NSString * photoPath=[[[accountResponse.data objectForKey:@"accounts"] objectForKey:UMShareToSina] objectForKey:@"icon"];
            [self.labName setText:username];
            [self.imgPhoto sd_setImageWithURL:[NSURL URLWithString: photoPath] placeholderImage:nil];
            [self setObjectFromDefault:username key:@"username"];
            [self updateUserNameImage:username photo:photoPath];
        }];
        [self hideLiginBtn];
        return true;
    }
    return false;
}
-(void) updateUserNameImage:(NSString * )username photo:(NSString *)photo{
    HTTPBase *classBtest = [[HTTPBase alloc] init];
    classBtest.delegate = self;
    [classBtest baseHttp:@"NameChange" paramsdata:[NSDictionary dictionaryWithObjectsAndKeys:username,@"username",photo,@"photo",nil]];
}



-(void) setImage:(NSString *)url{
//   self.imgPhoto seti
}

-(UIImage *) loadImage:(NSString *)fileName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath {
    UIImage * result = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.%@", directoryPath, fileName, extension]];
    return result;
}


-(void) hideLiginBtn{
    [self.btnQQ setHidden:true];
    [self.btnSina setHidden:true];
}



- (IBAction)sinaLogin:(id)sender {
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response)
                                  {
                                      NSLog(@"response is %@",response);
                                  });

}
- (IBAction)qqLogin:(id)sender {
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response)
                                  {
                                      NSLog(@"response is %@",response);
                                  });

}



@end
