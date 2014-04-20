//
//  UCIPublishNet.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-3-13.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIPublishNet.h"
#import "BIDNameAndColorTableViewCell.h"

@interface UCIPublishNet ()

@end

@implementation UCIPublishNet
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
    self.dowarves=@[];
    [self initPunish];

    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dowarves count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CustomCellIdentifier = @"CustomCellIdentifier";
    static BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"ColorAndName" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CustomCellIdentifier];
        nibsRegistered = YES;
    }
    
    BIDNameAndColorTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if(cell==nil){
        cell=[[BIDNameAndColorTableViewCell alloc] init];
    }
    
//    cell.txtName.text=@"wanbin";
//    [cell txtName] setText

    cell.txt3.text=[self.dowarves[indexPath.row] objectForKey:@"content"];
//    cell..text=[self.dowarves[indexPath.row] objectForKey:@"content"];
    NSString * txtLike=[NSString stringWithFormat:@"喜欢 %@",[self.dowarves[indexPath.row] objectForKey:@"like"] ];
    NSString * distxtLike=[NSString stringWithFormat:@"不喜欢 %@",[self.dowarves[indexPath.row] objectForKey:@"dislike"] ];

    [cell.btnLike  setTitle:txtLike forState:UIControlStateNormal];
    [cell.btnLike setEnabled:(BOOL)[self.dowarves[indexPath.row] objectForKey:@"liked"]];
    
    [cell.btnUnlike  setTitle:distxtLike forState:UIControlStateNormal];
    [cell.btnUnlike setEnabled:(BOOL)[self.dowarves[indexPath.row] objectForKey:@"disliked"]];

//    cell.btnImport.titleLabel.text=[self.dowarves[indexPath.row] objectForKey:@"content"];
    
    return cell;
}


-(void)initPunish{
    HTTPBase *classBtest = [[HTTPBase alloc] init];
    classBtest.delegate = self;
    [classBtest baseHttp:@"PublishAll"];
}



-(void)callBack:(NSArray *)data commandName:(NSString*) command{
    if([command isEqualToString:@"PublishAll"]){
        if([data count]>0){
            self.dowarves=data;
            [self.tableview reloadData];
        }
        NSLog(@"PublishAll 函数的回调");
    }
}
- (IBAction)getPunish:(id)sender {
    [self initPunish];
}


@end
