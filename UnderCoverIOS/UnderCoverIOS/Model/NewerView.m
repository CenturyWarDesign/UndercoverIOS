//
//  NewerView.m
//  UnderCoverIOS
//
//  Created by 斌万 on 14-10-15.
//  Copyright (c) 2014年 CenturyGame. All rights reserved.
//

#import "NewerView.h"

@interface NewerView ()

@end

@implementation NewerView
@synthesize viewImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    int  pageNum=5;

    NSArray * array1 = [[NSArray alloc] initWithObjects:@"快速！", @"简洁！",
                       @"丰富！", @"妥协！", nil];
    
    NSArray * array2 = [[NSArray alloc] initWithObjects:@"感受到了吗？", @"删除复杂的功能与设计",
                        @"总有适合你们的游戏", @"不幸的是，我们妥协了", nil];
    
    NSArray * array3 = [[NSArray alloc] initWithObjects:@"我们和您一样，是急性子，不想在聚会的时候耽搁时间。", @"一目了然的设计，让所有人都能快速使用。",
                        @"每个人都有理由参与其中。", @"因为这只是个工具，不必太华丽。", nil];
    
    viewImage.contentSize= CGSizeMake(pageNum * 320.0f, self.viewImage.frame.size.height);
//    [self.navigationController setHidesBarsOnTap:true];
    viewImage.pagingEnabled= YES;
    viewImage.showsHorizontalScrollIndicator= NO;
    viewImage.delegate=self;
    for(int i = 0; i < pageNum; i++) {
        if(i==4){
            UILabel * lable1=[[UILabel alloc] initWithFrame:CGRectMake(i * 320.0f+20.0f,  80, 280.0f,55.0f)];
            lable1.font=[UIFont fontWithName:@"Helvetica-Bold" size:50];
            lable1.text=@"爱上聚会";
            lable1.textColor=[self getPinkColor];
            [viewImage addSubview:lable1];
        
            UILabel * lable2=[[UILabel alloc] initWithFrame:CGRectMake(i * 320.0f+20.0f,  160, 280.0f,50.0f)];
            lable2.font=[UIFont fontWithName:@"Helvetica-Bold" size:40];
            lable2.text=@"你们才是主角！";
            lable2.textColor=[self getBlueColor];
            [viewImage addSubview:lable2];
            
            
            
            
            UIButton *imageButton = [[UIButton alloc] initWithFrame:CGRectMake(i * 320.0f+20,  240, 150.0f, 50.0f)];
            [imageButton setBackgroundImage:[UIImage imageNamed:@"btn_line_purple.png"] forState:UIControlStateNormal];
            [imageButton setTitle:@"马上开始" forState:UIControlStateNormal];
            [viewImage addSubview:imageButton];
            imageButton.titleLabel.font= [UIFont systemFontOfSize: 24.0];
            imageButton.titleLabel.textColor=[self getPurPleColor];
            [imageButton addTarget:self action:@selector(startGame) forControlEvents:UIControlEventTouchUpInside];

        }
        else{
            //快速
            UILabel * lable1=[[UILabel alloc] initWithFrame:CGRectMake(i * 320.0f+20.0f,  10.0f, 280.0f,50.0f)];
            lable1.font=[UIFont fontWithName:@"Helvetica-Bold" size:50];
            lable1.text=[array1 objectAtIndex:i];
            lable1.textColor=[self getPinkColor];
            [viewImage addSubview:lable1];
            
            
            
            UILabel * lable2=[[UILabel alloc] initWithFrame:CGRectMake(i * 320.0f+20.0f,  55.0f, 280.0f,50.0f)];
            lable2.font=[UIFont fontWithName:@"Helvetica-Bold" size:20];
            lable2.text=[array2 objectAtIndex:i];
            lable2.textColor=[self getBlueColor];
            [viewImage addSubview:lable2];
            
            
            
            
            UILabel * lable3=[[UILabel alloc] initWithFrame:CGRectMake(i * 320.0f+20.0f,  320.0f, 280.0f,50.0f)];
            lable3.font=[UIFont fontWithName:@"Helvetica-Bold" size:16];
            lable3.text=[array3 objectAtIndex:i];
            lable3.textColor=[self getPinkColor];
            lable3.numberOfLines=2;
            [viewImage addSubview:lable3];
        }
        
    }
    self.page.numberOfPages= pageNum;
    self.page.currentPage= 0;
}
-(void)startGame{
    [self.navigationController popViewControllerAnimated:YES];
}

//这里变动下面圆点
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int page=floor(viewImage.contentOffset.x/320);
    self.page.currentPage=page;
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

@end
