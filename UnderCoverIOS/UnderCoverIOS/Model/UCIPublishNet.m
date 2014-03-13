//
//  UCIPublishNet.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-3-13.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIPublishNet.h"

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
    static NSString * SimpleTableI=@"simpleTableI";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:SimpleTableI];
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableI];

    }
    cell.textLabel.text=[self.dowarves[indexPath.row] objectForKey:@"content"];
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
