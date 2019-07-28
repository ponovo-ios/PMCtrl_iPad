//
//  BD_SMVWeaksignalOutputCell1.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/7.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_SMVWeaksignalOutputCell1.h"

@implementation BD_SMVWeaksignalOutputCell1

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = ClearColor;
    self.contentView.backgroundColor = FormBgColor;
    [_passagewayMap1 setCorenerRadius:6.0 borderColor:[UIColor lightGrayColor] borderWidth:1.0];
    [_passagewayMap2 setCorenerRadius:6.0 borderColor:[UIColor lightGrayColor] borderWidth:1.0];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)passageMapping1:(id)sender {
    if (self.cell1delegate && [_cell1delegate respondsToSelector:@selector(changepassageWayMap1:sourceView:)]) {
        [self.cell1delegate changepassageWayMap1:_cellIndex sourceView:_passagewayMap1];
    }
    
    
}
- (IBAction)passageMapping2:(id)sender {
    
    if (self.cell1delegate && [_cell1delegate respondsToSelector:@selector(changepassageWayMap1:sourceView:)]) {
        [self.cell1delegate changepassageWayMap1:_cellIndex sourceView:_passagewayMap2];
    }
    
}

@end
