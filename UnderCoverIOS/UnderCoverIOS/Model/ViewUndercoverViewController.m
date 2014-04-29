//
//  ViewUndercoverViewController.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-4-23.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "ViewUndercoverViewController.h"

@interface ViewUndercoverViewController ()

@end

@implementation ViewUndercoverViewController

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
    PeopleCount=4;
    UndercoverCount=1;
    

    
    self.labPeopleCount.text=[NSString stringWithFormat:@"%d",PeopleCount];
    self.labUndercoverCount.text=[NSString stringWithFormat:@"%d",UndercoverCount];
    self.sliPeople.maximumValue=12;
    self.sliPeople.minimumValue=4;
    self.sliUndercover.maximumValue=4;
    self.sliUndercover.minimumValue=1;
    self.sliPeople.value=PeopleCount;
    self.sliUndercover.value=UndercoverCount;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnStart:(id)sender {
//    [self performSegueWithIdentifier:@"fanpaigueid" sender:self];
}

- (IBAction)sliPeoplechange:(UISlider *)sender {
    int progress=lroundf(sender.value);
    PeopleCount=progress;
    UndercoverCount=MIN(lroundf(PeopleCount/3), UndercoverCount);
    //计算平民和卧底的比例
    [self updateCount];
}
- (IBAction)sliUndercoverChange:(UISlider *)sender {
    int progress=lroundf(sender.value);
    UndercoverCount=progress;
    //计算平民和卧底的比例
    PeopleCount=MAX(UndercoverCount*3, PeopleCount);
    [self updateCount];
}

-(void)updateCount{
    self.sliPeople.value=PeopleCount;
    self.labPeopleCount.text=[NSString stringWithFormat:@"%d",PeopleCount];
    self.sliUndercover.value=UndercoverCount;
    self.labUndercoverCount.text=[NSString stringWithFormat:@"%d",UndercoverCount];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"segueFenpei"]) //"goView2"是SEGUE连线的标识
    {
        id theSegue = segue.destinationViewController;
        //界面之间进行传值
        [theSegue setValue:[NSString stringWithFormat:@"%d",PeopleCount] forKey:@"fathercount"];
        [theSegue setValue:[NSString stringWithFormat:@"%d",UndercoverCount] forKey:@"soncount"];
    }
    [self uMengClick:@""];
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
