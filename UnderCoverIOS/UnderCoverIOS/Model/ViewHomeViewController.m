//
//  ViewHomeViewController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-4-27.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "ViewHomeViewController.h"
#import "MobClick.h"
@interface ViewHomeViewController ()

@end

@implementation ViewHomeViewController

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
    [self getMessage];

    
//
    // Do any additional setup after loading the view.
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
-(void) getMessage{
    HTTPBase *classBtest = [[HTTPBase alloc] init];
    classBtest.delegate = self;
    [classBtest baseHttp:@"UserGetInfo"];
}

-(void)callBack:(NSDictionary *)data commandName:(NSString*) command{
    if([command isEqualToString:@"UserGetInfo"]){
        if([data count]>0){
            if([[data allKeys] containsObject:@"mail"]){
                NSArray * mailarr=[data objectForKey:@"mail"];
                NSDictionary * mailfirst=[mailarr objectAtIndex:0];
                [self.labMessage setText:[mailfirst objectForKey:@"content"]];
            }
//            NSDictionary * contentone=[data objectAtIndex:3];
//            [self reflashWords:[contentone objectForKey:@"content"]];
          
        }
        else{
//            [self reflashWords:@"可以免除惩罚"];
        }
        
        NSLog(@"PublishRandomOne 函数的回调");
    }
}

@end
