//
//  BD_VectorDataFormCell.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/12.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_VectorDataFormCell.h"

@implementation BD_VectorDataFormCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = ClearColor;
    self.contentView.backgroundColor = ClearColor;
    self.value1.textColor = White;
    self.value2.textColor = White;
    self.value3.textColor = White;
    self.value4.textColor = White;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
