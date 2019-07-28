//
//  BD_DifferentialSettingCell.h
//  PMCtrl_iOS
//
//  Created by wang on 2017/5/30.
//  Copyright © 2017年 wgx. All rights reserved.
//  设置cell

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, SettingCellType) {
    SettingCellSelected,
    SettingCellFill
};

@interface BD_DifferentialSettingCell : UITableViewCell

/**标题*/
@property (weak, nonatomic) UILabel *titleLabel;
/**数值*/
@property (nonatomic, strong) NSString *normalValue;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UIButton *selectedBtn;

@property (assign, nonatomic) SettingCellType cellType;
@property (assign, nonatomic) NSIndexPath *cellindex;
@property (nonatomic, copy) void (^endChangeValueBlock)(NSIndexPath *cellindex,NSString *value);

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)cellTypeWith:(NSInteger)row;

@end
