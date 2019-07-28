//
//  BD_QuickTestComParamVarCell.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/17.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BD_QuickTestComParamVarCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
@property (weak, nonatomic) IBOutlet UIButton *valueBtn1;
@property (weak, nonatomic) IBOutlet UIButton *valueBtn2;

@property (nonatomic,strong)void(^passagewayGroupBlock)(UIButton *);
@property (nonatomic,strong)void(^passagewayVarValueBlock)(UIButton *);
@end
