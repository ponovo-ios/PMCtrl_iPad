//
//  BD_GooseSubLeftFormCell.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/5.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_GooseSubLeftFormCell.h"
#import "UITextField+Extension.h"
@implementation BD_GooseSubLeftFormCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = ClearColor;
    self.contentView.backgroundColor = FormBgColor;
    [_describeValue setIECTFDefaultSetting];
    _describeValue.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_cellSelectedBtn setImage:BD_SelectedImage forState:UIControlStateSelected];
    [_cellSelectedBtn setImage:BD_UnSelectedImage forState:UIControlStateNormal];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)selectedCellAction:(id)sender {
    [_cellSelectedBtn setSelected:!_cellSelectedBtn.selected];
    
}

- (IBAction)changePassageType:(id)sender {
}

- (IBAction)changePassageMap:(id)sender {
}

@end
