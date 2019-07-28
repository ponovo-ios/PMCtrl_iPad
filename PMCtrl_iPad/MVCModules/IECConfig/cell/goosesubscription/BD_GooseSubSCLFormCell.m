//
//  BD_GooseSubSCLFormCell.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/29.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_GooseSubSCLFormCell.h"
#import "UITextField+Extension.h"
@interface BD_GooseSubSCLFormCell()
@property (weak, nonatomic) IBOutlet UITextField *macAddressTF;
@property (weak, nonatomic) IBOutlet UIView *bgview;


@end
@implementation BD_GooseSubSCLFormCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _bgview.backgroundColor = ClearColor;
    for (int i = 1; i<=10; i++) {
        if ([[[self getViewFromTag:i] class] isEqual:[UIButton class]]) {
            UIButton *btn = (UIButton *)[self getViewFromTag:i];
            [btn setCorenerRadius:6 borderColor:White borderWidth:1];
        } else if ([[[self getViewFromTag:i] class] isEqual:[UITextField class]]){
            UITextField *tf = (UITextField *)[self getViewFromTag:i];
            [tf setIECTFDefaultSetting];
            tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        }
    }
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
