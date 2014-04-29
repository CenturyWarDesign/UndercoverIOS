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
    nibsRegistered = NO;
    
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
    
    [cell.btnLike setTag:[[self.dowarves[indexPath.row] objectForKey:@"id"] intValue]];
    [cell.btnUnlike setTag:[[self.dowarves[indexPath.row] objectForKey:@"id"] intValue]];
    
    [cell.btnLike setTag:indexPath.row];
    [cell.btnUnlike setTag:indexPath.row];


    [cell.btnLike addTarget:self  action:@selector(likeit:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnUnlike addTarget:self  action:@selector(unlikeit:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.btnUnlike  setTitle:distxtLike forState:UIControlStateNormal];
    [cell.btnUnlike setEnabled:(BOOL)[self.dowarves[indexPath.row] objectForKey:@"disliked"]];
    
    

//    cell.btnImport.titleLabel.text=[self.dowarves[indexPath.row] objectForKey:@"content"];
    
    return cell;
}

-(IBAction)likeit:(id)sender{
    UIButton *btn =(UIButton *)sender;
    int index=[[self.dowarves[btn.tag] objectForKey:@"id"] intValue];
    HTTPBase *classBtest = [[HTTPBase alloc] init];
    int temcount=[[self.dowarves[btn.tag] objectForKey:@"like"] intValue]+1;

    [btn setTitle:[NSString stringWithFormat:@"喜欢 %d",temcount] forState:UIControlStateNormal];
        [btn setEnabled:false];
    classBtest.delegate = self;
    [classBtest baseHttp:@"PublishCollect" paramsdata:[NSDictionary dictionaryWithObjectsAndKeys: [NSString stringWithFormat:@"%d",index],@"id",@"1",@"type",nil]];

    //把喜欢的词汇加入到词组里面
    [self addliketoDefault:[self.dowarves[btn.tag] objectForKey:@"content"]];
   
}

-(IBAction)unlikeit:(id)sender{
    UIButton *btn =(UIButton *)sender;
    int index=[[self.dowarves[btn.tag] objectForKey:@"id"] intValue];
    
    int temcount=[[self.dowarves[btn.tag] objectForKey:@"dislike"] intValue]+1;
//    [self.dowarves[btn.tag] setObject:[NSString stringWithFormat:@"%d",temcount] forKey:@"dislike"];
//    [self.tableview reloadData];
    [btn setTitle:[NSString stringWithFormat:@"不喜欢 %d",temcount] forState:UIControlStateNormal];
    [btn setEnabled:false];
    
    HTTPBase *classBtest = [[HTTPBase alloc] init];
    classBtest.delegate = self;
        [classBtest baseHttp:@"PublishCollect" paramsdata:[NSDictionary dictionaryWithObjectsAndKeys: [NSString stringWithFormat:@"%d",index],@"id",@"2",@"type",nil]];

    
    //从喜欢的列表里面移除
    [self removeliketoDefault:[self.dowarves[btn.tag] objectForKey:@"content"]];

}

-(void)addliketoDefault:(NSString *)word{
    NSMutableArray * punisharr=[[NSMutableArray alloc]init];
    [punisharr addObjectsFromArray: (NSMutableArray *)[self getObjectFromDefault:@"punisharray"]];
    if(![punisharr containsObject:word]){
        [punisharr addObject:word];
    }
    [self setObjectFromDefault:punisharr key:@"punisharray"];
}
-(void)removeliketoDefault:(NSString *)word{
    NSMutableArray * punisharr=[[NSMutableArray alloc]init];
    [punisharr addObjectsFromArray: (NSMutableArray *)[self getObjectFromDefault:@"punisharray"]];
    if([punisharr containsObject:word]){
        [punisharr removeObject:word];
        [self setObjectFromDefault:punisharr key:@"punisharray"];
    }
}

-(void)PublishCollect:(int)index{
    HTTPBase *classBtest = [[HTTPBase alloc] init];
    classBtest.delegate = self;
    [classBtest baseHttp:@"PublishCollect"];
}


-(void)initPunish{
    HTTPBase *classBtest = [[HTTPBase alloc] init];
    classBtest.delegate = self;
    [classBtest baseHttp:@"PublishAll" ];
}



-(void)callBack:(NSArray *)data commandName:(NSString*) command{
    if([command isEqualToString:@"PublishAll"]){
        if([data count]>0){
            self.dowarves=data;
            [self.tableview reloadData];
        }
        NSLog(@"PublishAll 函数的回调");
    }else if([command isEqualToString:@"PublishCollect"]){
        if([data count]>0){
            self.dowarves=data;
//            [self.tableview reloadData];
        }
        NSLog(@"PublishCollect 函数的回调");
    }
}
- (IBAction)getPunish:(id)sender {
    [self initPunish];
}




@end
