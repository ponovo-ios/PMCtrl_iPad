//
//  BD_HarmOtherSettingCell.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/30.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_HarmOtherSettingCell.h"

@implementation BD_HarmOtherSettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    
}
//全选
- (IBAction)allSelect:(UIButton *)sender {
    [self.delegate didSelectAllCell:YES];
}
//全不选
- (IBAction)allDeselect:(UIButton *)sender {
    [self.delegate didSelectAllCell:NO];
}
//手动添加
- (IBAction)addData:(UIButton *)sender {
    [self.delegate changeValue:sender.tag];
}
//手动减少
- (IBAction)subData:(UIButton *)sender {
    [self.delegate changeValue:sender.tag];
}
//清零
- (IBAction)resetData:(UIButton *)sender {
    [self.delegate changeValue:sender.tag];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
