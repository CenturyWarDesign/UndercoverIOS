//
//  UCIViewNetPunishController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-10-9.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIViewNetPunishController.h"
#import "CellPunish.h"
//#import "BIDNameAndColorTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface UCIViewNetPunishController ()

@end

@implementation UCIViewNetPunishController
@synthesize punishinfo;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.tableView.delegate=self;
    self.tableView.dataSource=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.punishinfo count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CustomCellIdentifier";
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"CellPunish" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        nibsRegistered = YES;
    }
    CellPunish *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[CellPunish alloc] init];
//
//        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"cellpunish" owner:self options:nil];
//        cell = [array objectAtIndex:0];
//        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }

    NSString * username=[self.punishinfo[indexPath.row] objectForKey:@"username"];
    int gameuid=[[self.punishinfo[indexPath.row] objectForKey:@"gameuid"] intValue];
    username=[self getUserNewName:gameuid oldName:username];
    
    
    
    
    
    NSString * punish=[self.punishinfo[indexPath.row] objectForKey:@"content"];
    NSString * photo=[self.punishinfo[indexPath.row] objectForKey:@"photo"];

    [[cell labName] setText: username];
    [[cell labPunish] setText:punish];
    [[cell imgPhoto] sd_setImageWithURL:[NSURL URLWithString: photo] placeholderImage:[UIImage imageNamed:@"default_photo.png"]];
    [cell.btnShare setTag:indexPath.row];
     [cell.btnShare addTarget:self  action:@selector(sharPunish:) forControlEvents:UIControlEventTouchUpInside];
    
//    [[cell imgPhoto] setImage:[UIImage imageNamed:@"default_photo.png"]];
    return cell;
}

-(void)sharPunish:(UIButton *)sender{
    int tag=(int)sender.tag;
    int gameuid=[[self.punishinfo[tag] objectForKey:@"gameuid"] intValue];
    NSString * username=[self.punishinfo[tag] objectForKey:@"username"];
    username=[self getUserNewName:gameuid oldName:username];
    NSString * punish=[self.punishinfo[tag] objectForKey:@"content"];
//    NSString* content=[self.dowarves[btn.tag] objectForKey:@"content"];
    NSString* content=[NSString stringWithFormat:@"@%@ 受到了惩罚  [%@]  ,我们玩的这么嗨，你也快来参加吧！--爱上聚会",username,punish];
    [self shareSomeThing:content imageName:@""];
    
}



@end
