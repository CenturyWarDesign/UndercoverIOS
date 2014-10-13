//
//  CellPunish.h
//  
//
//  Created by 斌万 on 14-10-9.
//
//

#import <UIKit/UIKit.h>

@interface CellPunish : UITableViewCell{
    IBOutlet UILabel *labName;
    IBOutlet UILabel *labPunish;
    IBOutlet UIImageView *imgPhoto;
    IBOutlet UIButton *btnShare;
}
@property (strong, nonatomic) IBOutlet UIImageView *imgPhoto;
@property (strong, nonatomic) IBOutlet UILabel *labName;
@property (strong, nonatomic) IBOutlet UILabel *labPunish;
@property (strong, nonatomic) IBOutlet UIButton *btnShare;

@end
