//
//  BD_ReportListCell.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/24.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BD_ReportListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *reportNum;
@property (weak, nonatomic) IBOutlet UILabel *reportTime;
@property (weak, nonatomic) IBOutlet UILabel *reportResult;

@end
