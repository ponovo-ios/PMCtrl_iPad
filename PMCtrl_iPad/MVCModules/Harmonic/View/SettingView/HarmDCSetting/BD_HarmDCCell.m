//
//  BD_HarmDCCell.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/30.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_HarmDCCell.h"

@interface BD_HarmDCCell()<UITextFieldDelegate>

@end

@implementation BD_HarmDCCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = RGB(0, 134, 146);
        [self configureUI];
    }
    return self;
}

-(void)configureUI
{
    //分割线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = RGB(193, 213, 230);
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
        make.width.mas_equalTo(1);
        make.centerX.mas_equalTo(0);
    }];
    self.lineView = lineView;
    
    //标题1
    UILabel *firstTitle = [[UILabel alloc] init];
    firstTitle.textColor = [UIColor whiteColor];
    firstTitle.text = @"Ua(V):";
    [self.contentView addSubview:firstTitle];
    [firstTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(0);
    }];
    self.firstTitle = firstTitle;
    
    //输入框1
    UITextField *firstTF = [[UITextField alloc] init];
    firstTF.tag = 1;
    firstTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    firstTF.borderStyle = UITextBorderStyleRoundedRect;
    firstTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    firstTF.delegate = self;
    [self.contentView addSubview:firstTF];
    [firstTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(lineView.mas_left).offset(-20);
        make.width.mas_equalTo(150);
    }];
    self.firstTF = firstTF;

    
    //标题2
    UILabel *secondTitle = [[UILabel alloc] init];
    secondTitle.textColor = [UIColor whiteColor];
    secondTitle.text = @"开出5状态:";
    [self.contentView addSubview:secondTitle];
    [secondTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineView.mas_right).offset(20);
        make.centerY.mas_equalTo(0);
    }];
    self.secondTitle = secondTitle;
    
    //输入框2
    UITextField *secondTF = [[UITextField alloc] init];
    secondTF.tag = 2;
    secondTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    secondTF.borderStyle = UITextBorderStyleRoundedRect;
    secondTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    secondTF.delegate = self;
    [self.contentView addSubview:secondTF];
    [secondTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(150);
    }];
    self.secondTF = secondTF;
    
}


#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    //获取变化后的字符串
    NSString * newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    
    //添加只能数字的约束
    if ([[BD_Utils shared] validateNumber:string] == NO) {
        [MBProgressHUDUtil showMessage:@"请输入有效字符" toView:self];
        return NO;
    } else {
        return [[BD_Utils shared]validateNumber:string];
    }
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.text = [NSString stringWithFormat:@"%.3f",textField.text.floatValue];
    [self.delegate changeCellIndex:_index textField:textField];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
