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
    
    
    
    if (_refreshHeaderView == nil) {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - _tableview.bounds.size.height, self.view.frame.size.width, _tableview.bounds.size.height)];
        view.delegate = self;
        [self.tableview addSubview:view];
        _refreshHeaderView = view;
    }
    
    //  update the last update date
    [_refreshHeaderView refreshLastUpdatedDate];
	// Do any additional setup after loading the view.
}


/////以下为下拉刷新机制
- (void)reloadTableViewDataSource{
    
    //  should be calling your tableviews data source model to reload
    //  put here just for demo
    _reloading = YES;
    [self initPunish];
    
}

- (void)doneLoadingTableViewData{
    
    //  model should call this when its done loading
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_tableview];
    
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    [self reloadTableViewDataSource];
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
    
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    return _reloading; // should return if data source model is reloading
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    return [NSDate date]; // should return date data source was last changed
    
}



/////以上为下拉刷新机制



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
    
    
//    [cell.btnEdit setTag:indexPath.row];
//    [cell.btnEdit addTarget:self  action:@selector(editPunish:) forControlEvents:UIControlEventTouchUpInside];


    [cell.btnLike addTarget:self  action:@selector(likeit:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnUnlike addTarget:self  action:@selector(unlikeit:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.btnUnlike  setTitle:distxtLike forState:UIControlStateNormal];
    [cell.btnUnlike setEnabled:(BOOL)[self.dowarves[indexPath.row] objectForKey:@"disliked"]];
    
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

-(IBAction)editPunish:(id)sender{
    UIButton *btn =(UIButton *)sender;
    temContentToSend=[self.dowarves[btn.tag] objectForKey:@"content"];
    [self performSegueWithIdentifier:@"sendPunishNew" sender:self];
}

//向猜卧底里面传值
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"sendPunishNew"]) 
    {
        id theSegue = segue.destinationViewController;
        //界面之间进行传值
        [theSegue setValue:temContentToSend forKey:@"temContent"];
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

//-(void)callb


-(void)callBack:(NSArray *)data commandName:(NSString*) command{
    if([command isEqualToString:@"PublishAll"]){
        if([data count]>0){
            self.dowarves=data;
            [self.tableview reloadData];
            [self doneLoadingTableViewData];
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


//点击添加新的词汇
- (IBAction)btnAdddPunish:(id)sender {
}

//点击回调
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //选择列进行编辑
    temContentToSend=[self.dowarves[indexPath.row] objectForKey:@"content"];
    [self performSegueWithIdentifier:@"sendPunishNew" sender:self];

}


@end
