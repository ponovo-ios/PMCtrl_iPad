//
//  BD_VactorgraphViewDataCell.m
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2018/6/5.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_VactorgraphViewDataCell.h"

@implementation BD_VactorgraphViewDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = ClearColor;
    self.contentView.backgroundColor = ClearColor;
    self.amplitudeValue.adjustsFontSizeToFitWidth = YES;
    self.phaseValue.adjustsFontSizeToFitWidth = YES;
    self.lineMarkColorView.backgroundColor = ClearColor;
    [_selectedBtn addTarget:self action:@selector(selctedChanged:) forControlEvents:UIControlEventTouchUpInside];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)selctedChanged:(UIButton *)sender{
    [_selectedBtn setSelected:!_selectedBtn.selected];
    self.selectedBlock(_selectedBtn.selected, _cellIndex);
}
@end
