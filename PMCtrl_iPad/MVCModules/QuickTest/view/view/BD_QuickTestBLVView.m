//
//  BD_QuickTestBLVView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/17.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_QuickTestBLVView.h"

@implementation BD_QuickTestBLVView


-(void)awakeFromNib{
    [super awakeFromNib];
    [self.blvBtn setImage:[UIImage imageNamed:@"select_blue"] forState:UIControlStateSelected];
    [self.blvBtn setImage:[UIImage imageNamed:@"select_gray"] forState:UIControlStateNormal];
    self.backgroundColor = ClearColor;
    self.blvLabel.textColor = White;
}

- (IBAction)changeBlvState:(id)sender {
    self.blvBtn.selected = !self.blvBtn.selected;
    self.blvSelectedBlock(_viewtag, self.blvBtn.selected);
    
    
}

-(void)setData:(BOOL)state title:(NSString *)title lineColor:(UIColor *)lineColor{
    self.blvBtn.selected = state;
    self.blvLabel.text = title;
    self.blvColorView.backgroundColor = lineColor;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
