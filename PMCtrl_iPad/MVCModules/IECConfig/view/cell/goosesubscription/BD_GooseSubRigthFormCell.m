//
//  BD_GooseSubRigthFormCell.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/5.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_GooseSubRigthFormCell.h"

@implementation BD_GooseSubRigthFormCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = ClearColor;
    self.contentView.backgroundColor = FormBgColor;
    [_binary setTitleColor:White forState:UIControlStateNormal];
    [_mac setTitleColor:White forState:UIControlStateNormal];
    [_appid setTitleColor:White forState:UIControlStateNormal];
    [_passage setTitleColor:White forState:UIControlStateNormal];
    
    [_binary addTarget:self action:@selector(doubleTap:) forControlEvents:UIControlEventTouchDownRepeat];
    [_mac addTarget:self action:@selector(doubleTap:) forControlEvents:UIControlEventTouchDownRepeat];
    [_appid addTarget:self action:@selector(doubleTap:) forControlEvents:UIControlEventTouchDownRepeat];
    [_passage addTarget:self action:@selector(doubleTap:) forControlEvents:UIControlEventTouchDownRepeat];
    
    [_binary addTarget:self action:@selector(singleTap:) forControlEvents:UIControlEventTouchUpInside];
    [_mac addTarget:self action:@selector(singleTap:) forControlEvents:UIControlEventTouchUpInside];
    [_appid addTarget:self action:@selector(singleTap:) forControlEvents:UIControlEventTouchUpInside];
    [_passage addTarget:self action:@selector(singleTap:) forControlEvents:UIControlEventTouchUpInside];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)singleTap:(UIButton *)sender{
     self.BindingPassageMapBlock(IECGooseSubscriptionBindingType_Selected);
}
-(void)doubleTap:(UIButton *)sender{
    if (_currentPassageIsBinding) {
        self.BindingPassageMapBlock(IECGooseSubscriptionBindingType_Unbinding);
    } else {
        self.BindingPassageMapBlock(IECGooseSubscriptionBindingType_Binding);
    }
}
-(void)setCellData:(BD_IECGooseSubscriptionPassageMapModel *)cellData{
    [_binary setTitle:cellData.binary forState:UIControlStateNormal];
    [_mac setTitle:cellData.bindingMACAddress forState:UIControlStateNormal];
    [_appid setTitle:cellData.bindingAppID forState:UIControlStateNormal];
    [_passage setTitle:cellData.bindingPassage forState:UIControlStateNormal];
}

@end
