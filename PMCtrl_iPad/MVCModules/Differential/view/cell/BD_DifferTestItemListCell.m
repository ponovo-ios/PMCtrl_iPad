//
//  BD_DifferTestItemListCell.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/11.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_DifferTestItemListCell.h"
#import "BD_DifferIrCaculateManager.h"
#import "BD_DifferSetDataModel.h"
@implementation BD_DifferTestItemListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = ClearColor;
    self.contentView.backgroundColor= ClearColor;
    _testItemNum.textColor = White;
    _testItemName.textColor = White;
    _testItemResult.textColor = White;
    [_testItemIsSelect addTarget:self action:@selector(selectedTestItem:) forControlEvents:UIControlEventTouchUpInside];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setSeleState{
    if ([_testItemName.text isEqualToString: @"比率制动系数一"]) {
        if ([BD_DifferIrCaculateManager shared].setData.Kid1 == 0) {
            [self.testItemIsSelect setSelected:NO];
            self.testItemIsSelect.userInteractionEnabled = NO;
        }else {
            self.testItemIsSelect.userInteractionEnabled = YES;
        }
    } else {
        self.testItemIsSelect.userInteractionEnabled = YES;
    }
}
-(void)selectedTestItem:(UIButton *)sender{
    _testItemIsSelect.selected = !_testItemIsSelect.selected;
    if (self.isSelectedItemBlock) {
        self.isSelectedItemBlock(_cellIndex, _testItemIsSelect.selected);
    }
}
@end
