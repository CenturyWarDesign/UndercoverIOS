//
//  UCIkillSettingViewController.m
//  UnderCoverIOS
//
//  Created by jlcao on 14-8-24.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIkillSettingViewController.h"

@interface UCIkillSettingViewController ()

@end

@implementation UCIkillSettingViewController

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
    totalCount=6;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)slidTotalCount:(UISlider *)sender {
    int progress=(int)lroundf(sender.value);
    totalCount=progress;
    self.totalLable.text=[NSString stringWithFormat:@"%d",totalCount];

}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"segueFenpei"]) //"goView2"是SEGUE连线的标识
    {
        //        id theSegue = segue.destinationViewController;
        //界面之间进行传值
        //        [theSegue setValue:[NSString stringWithFormat:@"%d",PeopleCount] forKey:@"fathercount"];
        //[self setObjectFromDefault:[NSString stringWithFormat:@"%d",totalCount] key:@"totalcount"];
        //        [theSegue setValue:[NSString stringWithFormat:@"%d",UndercoverCount] forKey:@"soncount"];
        //[self setObjectFromDefault:[NSString stringWithFormat:@"%d",UndercoverCount] key:@"soncount"];
        //点击之后开始游戏
       // [self uMengClick:@"game_undercover_start"];
    }
    [self setObjectFromDefault:[NSString stringWithFormat:@"%d",totalCount] key:@"totalcount"];
    
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
