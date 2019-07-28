//
//  BD_GooseTransmitLeftFormCell.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/6.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BD_GooseTransmitLeftFormCell : UITableViewCell
@property(nonatomic,strong)UITextField *describeValue;
@property(nonatomic,strong)UIButton *passageTypeValue;
@property(nonatomic,strong)UIButton *passageMapValue;
@property(nonatomic,strong)UIButton * initialValue;

@property(nonatomic,copy)void((^TransmitLeftFormCellBtnClickBlock)(NSInteger));
@end
