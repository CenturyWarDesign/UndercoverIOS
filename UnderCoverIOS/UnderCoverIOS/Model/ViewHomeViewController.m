//
//  ViewHomeViewController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-4-27.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "ViewHomeViewController.h"
#import "MobClick.h"
@interface ViewHomeViewController ()

@end

@implementation ViewHomeViewController

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
    [self getMessage];

//
    // Do any additional setup after loading the view.
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
-(void) getMessage{
    HTTPBase *classBtest = [[HTTPBase alloc] init];
    classBtest.delegate = self;
    [classBtest baseHttp:@"UserGetInfo"];
}

-(void)callBack:(NSDictionary *)data commandName:(NSString*) command{
    if([command isEqualToString:@"UserGetInfo"]){
        if([data count]>0){
            if([[data allKeys] containsObject:@"mail"]){
                NSArray * mailarr=[data objectForKey:@"mail"];
                NSDictionary * mailfirst=[mailarr objectAtIndex:0];
                [self.labMessage setText:[mailfirst objectForKey:@"content"]];
            }
            [self setObjectFromDefault:[data objectForKey:@"gameuid"] key:@"gameuid"];
            [self setObjectFromDefault:[data objectForKey:@"username"] key:@"username"];
            [self setObjectFromDefault:[data objectForKey:@"newgame"] key:@"newgame"];
            
            
            UCIBaseViewController * tem= [self.tabBarController.childViewControllers objectAtIndex:2];
          
            [tem setBadgeValue:[[data objectForKey:@"newgame"] intValue]];
//         UITabBarItem * tem=   (UITabBarItem *)[self.tabBarController.toolbarItems objectAtIndex:[@"2" intValue]];
//            tem.badgeValue=@"3";

//            [self setBadgeValue:[data objectForKey:@"newgame"] atTabIndex:3 tap:(UITabBar *)self.tabBarItem];
        }
        
        NSLog(@"UserGetInfo 函数的回调");
    }
}

- (IBAction)gamePunish:(id)sender {
    //点击真心话大冒险
    [self uMengClick:@"game_zhenxinhua_damaoxian"];
//    [self playChuishsao];
}
- (IBAction)gameUndercover:(id)sender {
    //点击谁是卧底
    [self uMengClick:@"game_undercover"];
}

@end
