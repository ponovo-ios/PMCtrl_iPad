//
//  BD_SMV618502QualityCell.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/14.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BD_SMV618502QualityCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *valueBtn;

@property (nonatomic,strong)NSIndexPath *cellIndexpath;
@property(nonatomic,copy)void((^qualityValueChangeBlock)(NSIndexPath *,UIButton *));
@end
