//
//  ViewGuessViewController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-4-25.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "ViewGuessViewController.h"

@interface ViewGuessViewController ()

@end

@implementation ViewGuessViewController
@synthesize fathercount;
@synthesize soncount;
@synthesize fatherWord;
@synthesize arrContent;


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
    PeopleCount=[fathercount intValue];
    SonCount=[soncount intValue];
    [self initGuess];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initGuess{
    
    int width=self.viewGuess.bounds.size.width;
    int height=self.viewGuess.bounds.size.height;
    int btnWidth=(width-30)/4;
    int btnHeight=40;
    for (int i=0; i<PeopleCount; i++) {
        CGRect frame = CGRectMake((btnWidth+5)*(i%4)+10, (i/4)*(btnHeight+20)+20, btnWidth, btnHeight);
        UIButton *someAddButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        someAddButton.backgroundColor = [UIColor clearColor];
        [someAddButton setTitle:[NSString stringWithFormat:@"%d号",i+1] forState:UIControlStateNormal];
        someAddButton.frame = frame;
        [someAddButton setTag:i+1];
        [someAddButton addTarget:self action:@selector(tapPeople:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:someAddButton];
    }
}
-(void)tapPeople:(UIButton *)sender{
    int tag=sender.tag;
    NSString * txtShenFen=[arrContent objectForKey:[NSString stringWithFormat:@"%d",tag]];
    if([txtShenFen isEqualToString:fatherWord])
    {
        PeopleCount--;
    }
    else{
        SonCount--;
    }
    if(PeopleCount<=SonCount){
        [self.btnPublish setTitle:@"卧底胜利" forState:UIControlStateNormal];
    }else if(SonCount<=0){
        [self.btnPublish setTitle:@"卧底失败" forState:UIControlStateNormal];
    }
    txtShenFen=@"出局";
    [sender setTitle:txtShenFen forState:UIControlStateDisabled];
    [sender setEnabled:false];
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
