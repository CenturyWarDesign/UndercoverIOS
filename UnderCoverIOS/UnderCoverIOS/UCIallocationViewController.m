//
//  UCIallocationViewController.m
//  UnderCoverIOS
//
//  Created by jlcao on 14-8-26.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIallocationViewController.h"

@interface UCIallocationViewController ()

@end

@implementation UCIallocationViewController

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
    totalCount=[[self getObjectFromDefault:@"totalcount"]intValue];
    //SonCount=[[self getObjectFromDefault:@"soncount"]intValue];
    arrContent=[[NSMutableDictionary alloc] init];
    showContent=true;
    nowIndex=1;
    [self initWords];
    [self.labContent setText:@""];
    [self.nextButton setTitle:[NSString stringWithFormat:@"第%d号",nowIndex] forState:UIControlStateNormal];
    
    
    //给imageview添加点击事件
    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nextButton:)];
    [self.imageView removeGestureRecognizer:singleTap];
    [self.imageView addGestureRecognizer:singleTap];
    [self.imageView setHidden:false];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initWords{
    /* fatherWrod=@"父亲";
     sonWord=@"孩子";
     
     //    NSString * wordstring=[MobClick getConfigParams:@"under_string_version"];
     //    NSString* str = @"here be dragons";
     NSArray * wordArray=[self getAllWords];
     if([wordArray count]>0){
     srand((unsigned)time(0));
     NSString *randWord= [wordArray objectAtIndex:rand()%[wordArray count]];
     [self hasPlayed:randWord];
     //数组包括3项 类别  词汇一、二
     NSArray * wordDetailArray= [randWord componentsSeparatedByString:@"_"];
     srand((unsigned)time(0));
     int randWitchfather=rand()%2;
     if(randWitchfather==0){
     fatherWrod=[wordDetailArray objectAtIndex:1];
     sonWord=[wordDetailArray objectAtIndex:2];
     }else{
     sonWord=[wordDetailArray objectAtIndex:1];
     fatherWrod=[wordDetailArray objectAtIndex:2];
     }
     }*/
    
    if (6<=totalCount<=7) {
        //
        [self allocateWord:(int)2:(int)0];
    }else if (8<=totalCount<=10){
        //
        [self allocateWord:(int)2:(int)2];    }else if (11<=totalCount<=14){
            //
            [self allocateWord:(int)3:(int)3];
        }else if (15<=totalCount<=17){
            //
            [self allocateWord:(int)4:(int)4];
        }else{
            //空值
        }
}
-(void)allocateWord:(int)killercount :(int)policecount{
    for (int i=1;i<=totalCount; i++) {
        [arrContent setValue:@"平民" forKey:[NSString stringWithFormat:@"%d",i]];
    }
   int killer=killercount;
    while (killer>0) {
        int tem=(int)lroundf(rand()%totalCount)+1;
        NSString * temword=[arrContent objectForKey:[NSString stringWithFormat:@"%d",tem]];
        if(![temword isEqualToString:@"杀手"]){
            [arrContent setValue:@"杀手" forKey:[NSString stringWithFormat:@"%d",tem]];
            killer--;
        }
        int police=policecount;
        while (police>0) {
            int tem=(int)lroundf(rand()%totalCount)+1;
            NSString * temword=[arrContent objectForKey:[NSString stringWithFormat:@"%d",tem]];
            if(![temword isEqualToString:@"杀手"]){
                [arrContent setValue:@"警察" forKey:[NSString stringWithFormat:@"%d",tem]];
                police--;
            }
            
            int judge=1;
            while (judge>0) {
                int tem=(int)lroundf(rand()%totalCount)+1;
                NSString * temword=[arrContent objectForKey:[NSString stringWithFormat:@"%d",tem]];
                if(![temword isEqualToString:@"杀手"]&&![temword isEqualToString:@"警察"]){
                    [arrContent setValue:@"法官" forKey:[NSString stringWithFormat:@"%d",tem]];
                    judge--;
                }
            }
        }
    }
    
}
- (IBAction)nextButton:(id)sender {
    
    if(nowIndex>totalCount)
    {
        [self performSegueWithIdentifier:@"segueToKiller" sender:self];
        return;
    }
    if(showContent){
        NSString * showtem=[arrContent objectForKey:[NSString stringWithFormat:@"%d",nowIndex]];
        [self.labContent setText:showtem];
        [self.nextButton setTitle:@"请交给下一位" forState:UIControlStateNormal];
        if(nowIndex==totalCount){
            [self.nextButton setTitle:@"开始竞猜" forState:UIControlStateNormal];
            nowIndex++;
        }
    }
    else{
        nowIndex++;
        [self.labContent setText:@""];
        [self.nextButton setTitle:[NSString stringWithFormat:@"第%d号",nowIndex] forState:UIControlStateNormal];
        if(nowIndex==1){
            //点击翻牌第一步
            //[self uMengClick:@"click_undercover_pai_first"];
        }
    }
    showContent=!showContent;
    [self.imageView setHidden:!showContent];
    [self.labContent setHidden:showContent];
}
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if([segue.identifier isEqualToString:@"segueToKiller"]) //"goView2"是SEGUE连线的标识
//    {
//        //id theSegue = segue.destinationViewController;
//        //界面之间进行传值
//        //[theSegue setValue:[NSString stringWithFormat:@"%d",totalCount] forKey:@"totalcount"];
//        //[theSegue setValue:[NSString stringWithFormat:@"%d",killer] forKey:@"killer"];
//       // [theSegue setValue:[NSString stringWithFormat:@"%d",police] forKey:@"police"];
//       // [theSegue setValue:arrContent forKey:@"arrContent"];
//        //[theSegue setValue:fatherWrod forKey:@"fatherWord"];
//        //点击翻牌最后一步
//       // [self uMengClick:@"click_undercover_pai_last"];
//    }
//}


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
