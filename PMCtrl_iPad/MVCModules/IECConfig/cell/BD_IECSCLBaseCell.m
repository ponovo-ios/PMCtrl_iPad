//
//  BD_IECSCLBaseCell.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/11.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_IECSCLBaseCell.h"

@implementation BD_IECSCLBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = ClearColor;
    self.contentView.backgroundColor = FormBgColor;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(UIView *)getViewFromTag:(NSInteger)tag{
    return [self viewWithTag:tag];
}
@end
