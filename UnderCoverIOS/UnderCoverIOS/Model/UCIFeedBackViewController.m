//
//  UCIFeedBackViewController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-5-30.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "UCIFeedBackViewController.h"

@interface UCIFeedBackViewController ()

@end

@implementation UCIFeedBackViewController

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
    [self.textFeedBack.layer setBorderWidth:1];
    [self.textFeedBack.layer setBorderColor:[UIColor grayColor].CGColor];
    NSRange range;
    range.location = 0;
    range.length = 0;
    self.textFeedBack.selectedRange=range;
    
//    [self.textFeedBack.layer setb:1];
    
//    someAddButton.layer.borderWidth=1;
//    someAddButton.layer.borderColor=[UIColor greenColor].CGColor;
//    someAddButton.layer.cornerRadius=width/2;
//    someAddButton.layer.masksToBounds=YES;
    [self getCircleBtn:23];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)callBack:(NSDictionary *)data commandName:(NSString*) command{
    if([command isEqualToString:@"MailSend"]){
        [self showAlert:@"" content:@"感谢您的反馈，我们会尽快答复"];
        [self.navigationController popViewControllerAnimated:YES];
    }
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
- (IBAction)mailSend:(id)sender {
    NSString * feedBack =self.textFeedBack.text;
    if(feedBack.length==0){
        [self showAlert:@"" content:@"您还未输入任何内容"];
        return;
    }
    HTTPBase *classBtest = [[HTTPBase alloc] init];
    classBtest.delegate = self;
    [classBtest baseHttp:@"MailSend" paramsdata:[NSDictionary dictionaryWithObjectsAndKeys:feedBack,@"content",@"-2",@"sendto",nil]];

}

@end
