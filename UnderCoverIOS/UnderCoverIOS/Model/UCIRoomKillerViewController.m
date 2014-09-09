//
//  UCIRoomKillerViewController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-5-29.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIRoomKillerViewController.h"

@interface UCIRoomKillerViewController ()

@end

@implementation UCIRoomKillerViewController


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
    KillerCount=[[[[self gameData] objectForKey:@"room_contente"] objectForKey:@"killer" ] intValue];
    PoliceCount=[[[[self gameData] objectForKey:@"room_contente"] objectForKey:@"police" ] intValue];
    
    Pinmin=PeopleCount-KillerCount-PoliceCount-1;
    // Do any additional setup after loading the view.
}

-(void)tapPeople:(UIButton *)sender{
    int tag=(int)sender.tag;
    NSString * txtShenFen= [[datagame objectAtIndex:tag-1] objectForKey:@"user"];
    if([txtShenFen isEqualToString:@"杀手"]){
        KillerCount--;
    }
    else if([txtShenFen isEqualToString:@"警察"]){
        PoliceCount--;
    }
    else{
        Pinmin--;
    }
    [sender setEnabled:false];
    BOOL finish=false;
    if(KillerCount<=0){
        [self.labStatus setText:@"平民和警察胜利"];
        //取得失败都gameuid,发送到服务器去发推送；
        NSString *loserStr= [self getLoserStr:@"杀手"];
        [self sendToSendPunish:loserStr];
        
        [self disabledAllButton];
        finish=true;
    }else if(PoliceCount<=0||Pinmin<=0){
        [self.labStatus setText:@"杀手胜利"];
        NSString *loserStr=[NSString stringWithFormat:@"%@%@", [self getLoserStr:@"平民"], [self getLoserStr:@"警察"]] ;
        [self sendToSendPunish:loserStr];
        //        [self.btnPublish setTitle:@"卧底失败" forState:UIControlStateNormal];
        [self disabledAllButton];
        finish=true;
    }
    if(finish){
        //点投票最后一步
        [self uMengClick:@"click_guess_last"];
        [self playHuanhu];
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
