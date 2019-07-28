//
//  BD_ReportListCell.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/24.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_ReportListCell.h"

@implementation BD_ReportListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = ClearColor;
    self.contentView.backgroundColor = ClearColor;
    _reportNum.textColor = White;
    _reportTime.textColor = White;
    _reportResult.textColor = White;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
