//
//  NewPunishViewController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-5-1.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "NewPunishViewController.h"

@interface NewPunishViewController ()

@end

@implementation NewPunishViewController

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
    [self.btnSubmit2 setHidden:true];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endClickContent:)];
    [self.view addGestureRecognizer:singleTap];
    [self.txtPlace setEditable:false];
    [self.txtPlace setText:self.temContent];
    [self.txtField setText:self.temContent];
//    [singleTap release];
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
- (IBAction)updateTextView:(id)sender {
    self.txtPlace.text=self.txtField.text;
}
//点击时候触发
- (IBAction)clickContent:(id)sender {
    [self.btnSubmit2 setHidden:false];
//    [self.txtField setFrame:[self.]];
    
}
- (IBAction)endClickContent:(id)sender {
    [self.btnSubmit2 setHidden:true];
    [self textFieldDoneEditing:self.txtField];
}

- (IBAction)submitPunish:(id)sender {
    if([self.txtField.text isEqualToString:self.temContent]){
         [self showAlert:@"提示" content:@"请稍做修改之后再提交"];
        return;
    }
    HTTPBase *classBtest = [[HTTPBase alloc] init];
    classBtest.delegate = self;
    [classBtest baseHttp:@"PublishNew" paramsdata:[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"type",self.txtField.text,@"content",nil]];
}


-(void)callBack:(NSArray *)data commandName:(NSString*) command{
    if([command isEqualToString:@"PublishNew"]){
        [self showAlert:@"提示" content:@"添加真心话大冒险成功！管理员会尽快审核"];
        [self.txtPlace setText:@""];
        [self.txtField setText:@""];
        [self textFieldDoneEditing:self.txtField];
        [self performSegueWithIdentifier:@"hasAddNew" sender:self];
    }
}


-(IBAction)textFieldDoneEditing:(id)sender{
    [sender resignFirstResponder];
}
@end
