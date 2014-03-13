//
//  UCIPunishViewController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-3-12.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIPunishViewController.h"

@interface UCIPunishViewController ()

@end

@implementation UCIPunishViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//一个新词汇
- (IBAction)clickNew:(id)sender {
    [self initnewword];
}

-(void) reflashWords:(NSString *)words{
    self.publishWords.text=words;
}


-(void)initnewword{
    HTTPBase *classBtest = [[HTTPBase alloc] init];
    classBtest.delegate = self;
    [classBtest baseHttp:@"PublishRandomOne"];
}



////以下为摇啊摇代码

-(BOOL)canBecomeFirstResponder {
    return YES;
}

//-(void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    [self becomeFirstResponder];
//}

- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        [self initnewword];
        NSLog(@"摇啊摇");
    }
    [self uMengClick:@"shack"];
}
////以上为摇啊摇代码



-(void)callBack:(NSArray *)data commandName:(NSString*) command{
    if([command isEqualToString:@"PublishRandomOne"]){
        if([data count]>0){
            NSDictionary * contentone=[data objectAtIndex:0];
            [self reflashWords:[contentone objectForKey:@"content"]];
        }
        else{
            [self reflashWords:@"可以免除惩罚"];
        }
        
        NSLog(@"PublishRandomOne 函数的回调");
    }
}


@end
