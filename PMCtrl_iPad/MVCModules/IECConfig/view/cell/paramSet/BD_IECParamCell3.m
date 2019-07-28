//
//  BD_IECParamCell3.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/29.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_IECParamCell3.h"

@implementation BD_IECParamCell3

- (void)awakeFromNib {
    [super awakeFromNib];
    [_cellBtn1 setImage:[UIImage imageNamed:@"radioSelected"] forState:UIControlStateSelected];
    [_cellBtn1 setImage:[UIImage imageNamed:@"radioUnSelected"] forState:UIControlStateNormal];
    [_cellBtn2 setImage:[UIImage imageNamed:@"radioSelected"] forState:UIControlStateSelected];
    [_cellBtn2 setImage:[UIImage imageNamed:@"radioUnSelected"] forState:UIControlStateNormal];
    self.backgroundColor = ClearColor;
    self.contentView.backgroundColor = FormBgColor;
    [_cellBtn1 setSelected:YES];
    [_cellBtn2 setSelected:NO];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)cellBtn1Click:(id)sender {
    [_cellBtn1 setSelected:YES];
    [_cellBtn2 setSelected:NO];
    self.radioSelectedBlock(0);
}


- (IBAction)cellBtn2Click:(id)sender {
    [_cellBtn2 setSelected:YES];
    [_cellBtn1 setSelected:NO];
    self.radioSelectedBlock(1);
    
}


@end
