//
//  testViewController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-5-4.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "testViewController.h"
#import "UMSocial.h"
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
    [self showLogin];
//    [self uMengClick:@"game_setting"];
//    [self.soundSwitch setOn:[[self getObjectFromDefault:@"ISOPENSOUND"] boolValue]];

    //检测是否登录
//    [self checkIsLogin];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showLogin {
    BOOL isOauthSina = [UMSocialAccountManager isOauthWithPlatform:UMShareToSina];
    BOOL isOauthQQ = [UMSocialAccountManager isOauthWithPlatform:UMShareToQzone];
    if(isOauthSina){
        [self.btnQQ setHidden:YES];
        self.btnSina.center=self.view.center;
    }else if(isOauthQQ){
        [self.btnSina setHidden:YES];
        self.btnQQ.center=self.view.center;
    }

}

-(BOOL)checkIsLoginSina{
    BOOL isOauthSina = [UMSocialAccountManager isOauthWithPlatform:UMShareToSina];
    if(isOauthSina){
        [[UMSocialDataService defaultDataService] requestSocialAccountWithCompletion:^(UMSocialResponseEntity *accountResponse){
            NSString * username=[[[accountResponse.data objectForKey:@"accounts"] objectForKey:UMShareToSina] objectForKey:@"username"];
            NSString * photoPath=[[[accountResponse.data objectForKey:@"accounts"] objectForKey:UMShareToSina] objectForKey:@"icon"];
//            [self.labName setText:username];
//            [self.imgPhoto sd_setImageWithURL:[NSURL URLWithString: photoPath] placeholderImage:nil];
            [self setObjectFromDefault:username key:@"username"];
            [self updateUserNameImage:username photo:photoPath];
            
            [self showAlert:@"" content:@"微博登录成功"];
            [self.navigationController popViewControllerAnimated:YES];

        }];
//        [self hideLiginBtn];
        return true;
    }
       return false;
}


-(BOOL)checkIsLoginQQ{
    BOOL isOauthQQ = [UMSocialAccountManager isOauthWithPlatform:UMShareToQzone];
    if(isOauthQQ){
        [[UMSocialDataService defaultDataService] requestSocialAccountWithCompletion:^(UMSocialResponseEntity *accountResponse){
            NSString * username=[[[accountResponse.data objectForKey:@"accounts"] objectForKey:UMShareToQzone] objectForKey:@"username"];
            NSString * photoPath=[[[accountResponse.data objectForKey:@"accounts"] objectForKey:UMShareToQzone] objectForKey:@"icon"];
            //            [self.labName setText:username];
            //            [self.imgPhoto sd_setImageWithURL:[NSURL URLWithString: photoPath] placeholderImage:nil];
            [self setObjectFromDefault:username key:@"username"];
            [self updateUserNameImage:username photo:photoPath];
            [self showAlert:@"" content:@"QQ登录成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        //        [self hideLiginBtn];
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
                                      [self checkIsLoginSina];
                                  });

}
- (IBAction)qqLogin:(id)sender {
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQzone];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response)
                                  {
                                      NSLog(@"response is %@",response);
                                      [self checkIsLoginQQ];
                                  });

}



@end
