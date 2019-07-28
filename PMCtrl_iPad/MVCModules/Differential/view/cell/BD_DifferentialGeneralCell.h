//
//  BD_DifferentialGeneralCell.h
//  PMCtrl_iOS
//
//  Created by 杨博宇 on 2017/8/14.
//  Copyright © 2017年 bodian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SettingCellType) {
    SettingCellSelected,
    SettingCellFill
};

@interface BD_DifferentialGeneralCell : UITableViewCell

/**标题*/
@property (weak, nonatomic) UILabel *titleLabel;
/**数值*/
@property (nonatomic, strong) NSString *normalValue;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UIButton *selectedBtn;

@property (assign, nonatomic) SettingCellType cellType;
@property (nonatomic,strong)NSIndexPath* cellindex;
@property (nonatomic, copy) void (^endChangeValueBlock)(NSString *value,NSIndexPath *cellindex);

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

- (void)cellTypeWith:(NSInteger)row;

@end
