//
//  ViewHomeViewController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-4-27.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "ViewHomeViewController.h"
#import "MobClick.h"
//#import
#import "UIButton+WebCache.h"
@interface ViewHomeViewController ()

@end

@implementation ViewHomeViewController

@synthesize imageScrollView;
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
//    return ;
    
//    Class cls = NSClassFromString(@"UMANUtil");
//    SEL deviceIDSelector = @selector(openUDIDString);
//    NSString *deviceID = nil;
//    if(cls && [cls respondsToSelector:deviceIDSelector]){
//        deviceID = [cls performSelector:deviceIDSelector];
//    }
//    NSLog(@"{\"oid\": \"%@\"}", deviceID);

//
    // Do any additional setup after loading the view.
    

    array = [[NSArray alloc] initWithObjects:@"谁是卧底", @"杀人游戏",
                      @"真心话大冒险", @"有胆量就点", @"有胆量就转",@"每周推荐", nil];
    PAGENUM=[array count];
    
    imageScrollView.contentSize= CGSizeMake(PAGENUM * 320.0f, imageScrollView.frame.size.height);
    imageScrollView.pagingEnabled= YES;
    imageScrollView.showsHorizontalScrollIndicator= NO;
    imageScrollView.delegate=self;
    
    //这里为滚动视图添加了子视图，为了能添加后续操作，我这里定义的子视图是按键UIButton
    for(int i = 0; i < PAGENUM; i++) {
            NSString  * fileName =[NSString stringWithFormat:@"logo_1%d.png",i+1];
            if ([[array objectAtIndex:i] isEqualToString:@"每周推荐"]) {
                fileName =@"week_recom.png";
            }
        
            UIButton *imageButton = [[UIButton alloc] initWithFrame:CGRectMake(i * 320.0f+50,  0.0f, 220.0f, 300.0f)];
            [imageButton setBackgroundImage:[UIImage imageNamed:fileName] forState:UIControlStateNormal];
            [imageButton setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
            [imageScrollView addSubview:imageButton];
            imageButton.titleLabel.font= [UIFont systemFontOfSize: 24.0];
             UIEdgeInsets insets = {270, 0 , 0, 0};
            imageButton.titleEdgeInsets=insets;
            [imageButton setTag:i];
            [imageButton addTarget:self action:@selector(jumpTuGame:) forControlEvents:UIControlEventTouchUpInside];

        }
    
    //定义PageController 设定总页数，当前页，定义当控件被用户操作时,要触发的动作。
   self.page.numberOfPages= PAGENUM;
    self.page.currentPage= 0;
}


-(void)jumpTuGame:(UIButton *)sender{
    int tag=(int)sender.tag;
    
    if ([[array objectAtIndex:tag] isEqualToString:@"每周推荐"]) {
        [self.tabBarController setSelectedIndex:2];
        [self setObjectFromDefault:@"gamenow" key:@"HELP_OPEN"];
        return;
    }
    switch (tag) {
        case 0:
            [self setObjectFromDefault:@"1" key:@"localGameType"];
            [self performSegueWithIdentifier:@"game_undercover" sender:self];
            break;
        case 1:
            [self setObjectFromDefault:@"2" key:@"localGameType"];
            [self performSegueWithIdentifier:@"game_undercover" sender:self];
            break;
        case 2:
            [self performSegueWithIdentifier:@"game_tures" sender:self];
            break;
        case 3:
            [self performSegueWithIdentifier:@"game_click" sender:self];
            break;
        case 4:
            [self performSegueWithIdentifier:@"game_circle" sender:self];
            break;
  default:
    break;
}
}

//这里变动下面圆点
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int page=floor(self.imageScrollView.contentOffset.x/320);
    self.page.currentPage=page;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

            newGameName=[data objectForKey:@"newgamename"];
            newGameImage=[data objectForKey:@"newgameimage"];
            
            if(newGameImage.length>0&&newGameImage.length>0){
                [self updateRecomImage:newGameName gameImg:newGameImage];
            }

//         UITabBarItem * tem=   (UITabBarItem *)[self.tabBarController.toolbarItems objectAtIndex:[@"2" intValue]];
//            tem.badgeValue=@"3";

//            [self setBadgeValue:[data objectForKey:@"newgame"] atTabIndex:3 tap:(UITabBar *)self.tabBarItem];
        }
        
        NSLog(@"UserGetInfo 函数的回调");
    }
}
-(void)updateRecomImage:(NSString *)gamename gameImg:(NSString *)gameImg{
    for (int i=0; i< [array count]; i++) {
        if([[array objectAtIndex:i] isEqualToString:@"每周推荐"]){
            UIButton * tem= (UIButton *)[imageScrollView viewWithTag:i];
            [tem setTitle:gamename forState:UIControlStateNormal];
            [tem sd_setBackgroundImageWithURL:[NSURL URLWithString:gameImg] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"week_recom.png"]];
//            [tem setBackgroundImage:[UIImage imageNamed:fileName] forState:UIControlStateNormal];
        }
    }
}






@end
