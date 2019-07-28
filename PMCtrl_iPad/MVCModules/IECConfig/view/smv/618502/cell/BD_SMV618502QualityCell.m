//
//  BD_SMV618502QualityCell.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/14.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_SMV618502QualityCell.h"

@implementation BD_SMV618502QualityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_valueBtn setCorenerRadius:6 borderColor:White borderWidth:1.0];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)valueChangedAction:(id)sender {
    
    self.qualityValueChangeBlock(_cellIndexpath,_valueBtn);
}

@end
