//
//  BD_QuickTestParamHeaderView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/10.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_QuickTestParamHeaderView.h"

@implementation BD_QuickTestParamHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = ClearColor;
    [[BD_Utils shared] setLabelColors:@[self.frequencyLabel,self.phaseLabel,self.amplitudeLabel] withColor:White];
    // Initialization code
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
