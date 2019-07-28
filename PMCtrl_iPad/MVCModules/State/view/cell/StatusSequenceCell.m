//
//  StatusSequenceCell.m
//  PMCtrl_iOS
//
//  Created by 杨博宇 on 2017/6/19.
//  Copyright © 2017年 bodian. All rights reserved.
//

#import "StatusSequenceCell.h"

@implementation StatusSequenceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = ClearColor;
    self.contentView.backgroundColor = ClearColor;
    [[BD_Utils shared]setLabelColors:@[_testNum,_testName,_testProject,_testResult] withColor:White];
    [_isSelect addTarget:self action:@selector(selectedTestItem:) forControlEvents:UIControlEventTouchUpInside];
        // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)selectedTestItem:(UIButton *)sender{
    _isSelect.selected = !_isSelect.selected;
    if (self.isSelectedItemBlock) {
        self.isSelectedItemBlock(_cellIndex, _isSelect.selected);
    }
}


@end
