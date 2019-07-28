//
//  BD_BinarySettingCell.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/2/9.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_BinarySettingCell.h"
#import "UITextField+Extension.h"
@interface BD_BinarySettingCell()<UITextFieldDelegate>

@end
@implementation BD_BinarySettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = MainBgColor;
    self.contentView.backgroundColor = ClearColor;
    
//    self.contentView.layer.borderColor = Black.CGColor;
//    self.contentView.layer.borderWidth = 1.0;
    
    [[self.contentView viewWithTag:100] setCorenerRadius:10.0 borderColor:White borderWidth:2.0];
    [[self.contentView viewWithTag:100] setBackgroundColor:[UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1.0]];
    
    [[self.contentView viewWithTagToBtn:14] setImage:BD_UnSelectedImage forState:UIControlStateNormal];
    [[self.contentView viewWithTagToBtn:14] setImage:BD_SelectedImage forState:UIControlStateSelected];
    [[self.contentView viewWithTagToBtn:14] addTarget:self action:@selector(isSelectedBlankNode:) forControlEvents:UIControlEventTouchUpInside];
//    [[self.contentView viewWithTagToBtn:14] setSelected:YES];
    
    [[self.contentView viewWithTagToTF:15] setDefaultSetting];
    [self.contentView viewWithTagToTF:15].delegate = self;
    [[BD_Utils shared]setViewState:NO view:[self.contentView viewWithTagToTF:15]];
    // Initialization code
}

-(void)layoutSubviews{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)isSelectedBlankNode:(UIButton *)sender{
    [sender setSelected:!sender.isSelected];
    if ([self.contentView viewWithTagToBtn:14].selected) {
        [[BD_Utils shared]setViewState:NO view:[self.contentView viewWithTagToTF:15]];
    } else {
        [[BD_Utils shared]setViewState:YES view:[self.contentView viewWithTagToTF:15]];
    }
    self.selectedBlankNodeBlock(_cellIndex,sender.isSelected);
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    textField.text = [NSString stringWithFormat:@"%0.3f",[textField.text floatValue]];
    if (self.rolloverValueBlock) {
        self.rolloverValueBlock(_cellIndex,textField.text);
    }
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    //获取变化后的字符串
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([[self.contentView viewWithTagToLabel:13].text isEqualToString:@"开入防抖时间"]) {
        if ([newText floatValue]>999999) {
            textField.text = @"999999";
            return NO;
        } else if ([newText floatValue]<0)  {
            textField.text = @"0";
            return NO;
        }
    } else {
        if ([newText floatValue]>600) {
            textField.text = @"600.000";
            return NO;
        } else if ([newText floatValue]<0)  {
            textField.text = @"0";
            return NO;
        }
    }
    //添加只能数字的约束
    if ([[BD_Utils shared] validateNumber:string] == NO) {
        [MBProgressHUDUtil showMessage:@"请输入有效字符" toView:self];
        return NO;
    } else {
        //        return [[BD_Utils shared]validateNumber:string];
        return YES;
    }
}

@end
