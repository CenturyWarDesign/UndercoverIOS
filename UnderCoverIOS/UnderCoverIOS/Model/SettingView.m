//
//  SettingView.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-10-10.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "SettingView.h"

#import "UMSocial.h"
#import "UIImageView+WebCache.h"

@implementation SettingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    baseCommand=[[UCIBaseViewController alloc]init];
    
    [baseCommand uMengClick:@"game_setting"];
    //    [self.soundSwitch setOn:[[self getObjectFromDefault:@"ISOPENSOUND"] boolValue]];
    //检测是否登录
    //    [self checkIsLogin];
    // Do any additional setup after loading the view.

    
    bool soundon=[[baseCommand getObjectFromDefault:@"ISOPENSOUND"]  isEqual:@"1"];
    //把声音标记做了
    [self.swiSound setOn:soundon];
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    [self checkIsLogin];
}

- (IBAction)changeSoundSetting:(UISwitch *)sender {
//    NSString * tem=[baseCommand getObjectFromDefault:@"ISOPENSOUND"];
    BOOL isOpen = [[baseCommand getObjectFromDefault:@"ISOPENSOUND"] isEqual:@"1"];
    NSString *value =!isOpen  ? @"1" : @"0";
    [baseCommand setObjectFromDefault:value key:@"ISOPENSOUND"];
}

- (IBAction)showLogin:(id)sender {
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
            [baseCommand setObjectFromDefault:username key:@"username"];
            [self updateUserNameImage:username photo:photoPath];
        }];
//        [self hideLiginBtn];
        return true;
    }
    BOOL isOauthQQ = [UMSocialAccountManager isOauthWithPlatform:UMShareToSina];
    if(isOauthQQ){
        [[UMSocialDataService defaultDataService] requestSocialAccountWithCompletion:^(UMSocialResponseEntity *accountResponse){
            NSString * username=[[[accountResponse.data objectForKey:@"accounts"] objectForKey:UMShareToQQ] objectForKey:@"username"];
            NSString * photoPath=[[[accountResponse.data objectForKey:@"accounts"] objectForKey:UMShareToSina] objectForKey:@"icon"];
            [self.labName setText:username];
            [self.imgPhoto sd_setImageWithURL:[NSURL URLWithString: photoPath] placeholderImage:nil];
            [baseCommand setObjectFromDefault:username key:@"username"];
            [self updateUserNameImage:username photo:photoPath];
        }];
//        [self hideLiginBtn];
        return true;
    }
     [self.labName setText:@"未绑定任何帐号"];
    return false;
}
-(void) updateUserNameImage:(NSString * )username photo:(NSString *)photo{
    HTTPBase *classBtest = [[HTTPBase alloc] init];
//    classBtest.delegate = self;
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
//    [self.btnQQ setHidden:true];
//    [self.btnSina setHidden:true];
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
