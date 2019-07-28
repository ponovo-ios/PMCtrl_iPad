//
//  BD_StatusSequenceHeaderView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/25.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_StatusSequenceHeaderView.h"

@implementation BD_StatusSequenceHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor lightGrayColor];
    [[BD_Utils shared] setLabelColors:@[_testNum,_testName,_testProject,_isSelect,_testResult] withColor:White];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
