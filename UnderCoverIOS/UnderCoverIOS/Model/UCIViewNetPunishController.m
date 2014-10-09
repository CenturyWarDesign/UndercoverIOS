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
    NSString * punish=[self.punishinfo[indexPath.row] objectForKey:@"content"];
    NSString * photo=[self.punishinfo[indexPath.row] objectForKey:@"photo"];

    [[cell labName] setText: username];
    [[cell labPunish] setText:punish];
        [[cell imgPhoto] sd_setImageWithURL:[NSURL URLWithString: photo] placeholderImage:[UIImage imageNamed:@"default_photo.png"]];
    
//    [[cell imgPhoto] setImage:[UIImage imageNamed:@"default_photo.png"]];
    return cell;
}



@end
