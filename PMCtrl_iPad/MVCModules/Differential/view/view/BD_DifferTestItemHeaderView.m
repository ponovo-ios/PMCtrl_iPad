//
//  BD_DifferTestItemHeaderView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/11.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_DifferTestItemHeaderView.h"

@implementation BD_DifferTestItemHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor lightGrayColor];
    _testItemNum.textColor  = White;
    _testItemName.textColor = White;
    _testItemSelect.textColor = White;
    _testItemResult.textColor = White;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
