//
//  BD_SMVScalefactorSetCell.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/13.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_SMVScalefactorSetCell.h"
#import "UITextField+Extension.h"
@implementation BD_SMVScalefactorSetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = ClearColor;
    self.backgroundColor = ClearColor;
    [_currentScalefactorTF setDefaultSetting];
    [_voltageScalefactorTF setDefaultSetting];
    _title.textColor = White;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
