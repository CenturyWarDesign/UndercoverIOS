//
//  ChangeUserName.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-10-13.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "ChangeUserName.h"

@interface ChangeUserName ()

@end

@implementation ChangeUserName
@synthesize username;
@synthesize gameuid;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.labUserName.text=username;
    gameuidWillchange=gameuid;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)changeName:(id)sender {
    NSString * newUsername=self.labUserName.text;
    if(newUsername.length>4){
        [self showAlert:@"" content:@"请输入四位以内的昵称"];
        return;
    }
    if(newUsername.length==0){
        [self showAlert:@"" content:@"请输入不为空昵称"];
        return;
    }

    [self setObjectFromDefault:newUsername key:[NSString stringWithFormat:@"%@_Newname",gameuidWillchange]];
    [self showAlert:@"" content:@"修改昵称成功"];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
