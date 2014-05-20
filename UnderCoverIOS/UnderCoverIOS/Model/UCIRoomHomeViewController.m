//
//  UCIRoomHomeViewController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-5-21.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIRoomHomeViewController.h"

@interface UCIRoomHomeViewController ()

@end

@implementation UCIRoomHomeViewController

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
- (IBAction)btnJoinRoom:(id)sender {
    HTTPBase *classBtest = [[HTTPBase alloc] init];
    classBtest.delegate = self;
    [classBtest baseHttp:@"RoomJoin" paramsdata:[NSDictionary dictionaryWithObjectsAndKeys:self.labRoomId.text,@"roomid",nil]];
}

- (IBAction)btnCreateRoom:(id)sender {
    HTTPBase *classBtest = [[HTTPBase alloc] init];
    classBtest.delegate = self;
    [classBtest baseHttp:@"RoomNew" paramsdata:[NSDictionary dictionaryWithObjectsAndKeys:nil]];
}

-(IBAction)textFieldDoneEditing:(id)sender{
    [sender resignFirstResponder];
}


- (IBAction)endClickContent:(id)sender {
    [self textFieldDoneEditing:self.labRoomId];
}
@end
