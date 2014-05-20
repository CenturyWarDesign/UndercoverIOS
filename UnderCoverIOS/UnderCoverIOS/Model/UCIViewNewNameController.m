//
//  UCIViewNewNameController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-5-21.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIViewNewNameController.h"

@interface UCIViewNewNameController ()

@end

@implementation UCIViewNewNameController

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//提交用户昵称
- (IBAction)updateName:(id)sender {
    HTTPBase *classBtest = [[HTTPBase alloc] init];
    classBtest.delegate = self;
    [classBtest baseHttp:@"NameChange" paramsdata:[NSDictionary dictionaryWithObjectsAndKeys:self.labName.text,@"username",nil]];
}

-(void)callBack:(NSDictionary *)data commandName:(NSString*) command{
    if([command isEqualToString:@"NameChange"]){
        NSLog(@"NameChange 函数的回调");
        [self performSegueWithIdentifier:@"roompage" sender:self];
    }
}
-(IBAction)textFieldDoneEditing:(id)sender{
    [sender resignFirstResponder];
}

- (IBAction)endClickContent:(id)sender {
    [self textFieldDoneEditing:self.labName];
}
@end
