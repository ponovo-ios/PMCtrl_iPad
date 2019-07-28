//
//  BD_DifferentialGeneralCell.m
//  PMCtrl_iOS
//
//  Created by 杨博宇 on 2017/8/14.
//  Copyright © 2017年 bodian. All rights reserved.
//

#import "BD_DifferentialGeneralCell.h"

@interface BD_DifferentialGeneralCell () <UITextFieldDelegate>

@property (nonatomic , weak) UIView *lineView;

@property (nonatomic, assign) NSInteger row;


@end

@implementation BD_DifferentialGeneralCell


//懒加载
-(UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        //        _textField.textColor = [UIColor redColor];
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.clearButtonMode = UITextFieldViewModeAlways;
        _textField.keyboardType = UIKeyboardTypeDecimalPad;
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.textColor = White;
        _textField.delegate = self;
    }
    return _textField;
}

-(UIButton *)selectedBtn
{
    if (!_selectedBtn) {
        _selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectedBtn setTitleColor:White forState:UIControlStateNormal];
        _selectedBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_selectedBtn setImage:[UIImage imageNamed:@"director"] forState:UIControlStateNormal];
        _selectedBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
    }
    return _selectedBtn;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self configureUI];
    }
    return self;
}

-(void)configureUI
{
    //标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:15];
    //    titleLabel.font = [UIFont systemFontOfSize:ScaleFont(12)];
    //    titleLabel.backgroundColor = [UIColor redColor];
    titleLabel.textColor = White;
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.centerY.mas_equalTo(0);
    }];
    self.titleLabel = titleLabel;
    
    //分割线
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(1);
        make.right.mas_equalTo(-Main_Screen_Width / 3);
    }];
    self.lineView = lineView;
    
}

- (void)cellTypeWith:(NSInteger)row{
    
    _row = row;
    
    if (row == 203 || row == 300 || row == 301 || row == 302 || row == 303 || row == 304 || row == 305 || row == 306 || row == 307 || row == 308 || row == 309 || row == 312) {
        self.cellType = SettingCellSelected;
    }else{
        self.cellType = SettingCellFill;
    }
}

-(void)setCellType:(SettingCellType)cellType
{
    _cellType = cellType;
    
    //添加button
    if (self.cellType == SettingCellSelected) {
        
        //移除cell中右侧textfield
        [self.textField removeFromSuperview];
        
        self.selectedBtn.titleLabel.font = _titleLabel.font;
        
        _selectedBtn.tag = _row;
        
        [self addSubview:self.selectedBtn];
        
        [self.selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_lineView.mas_right).offset(5);
            make.top.bottom.right.mas_equalTo(0);
        }];
        
    }
    
    //添加textfield
    else{
        
        [self.selectedBtn removeFromSuperview];
        
        //数值填写
        self.textField.text = self.normalValue;
        
        self.textField.font = _titleLabel.font;
        
        [self addSubview:self.textField];
        
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_lineView.mas_right).offset(5);
            make.top.bottom.right.mas_equalTo(0);
        }];
    }
}

#pragma mark -- UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.text = [NSString stringWithFormat:@"%0.3f",[textField.text floatValue]];
    
    if (textField.text.length == 0) {
        textField.text = self.normalValue;
    } else {
        self.normalValue = textField.text;
    }
    self.endChangeValueBlock(self.normalValue, _cellindex);
}

//修改textfield的时候，设置只允许输入数字

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([[BD_Utils shared] validateNumber:string] == NO) {
        [MBProgressHUDUtil showMessage:@"请输入有效字符" toView:self];
        return NO;
    } else {
        return [[BD_Utils shared]validateNumber:string];
    }

    
}

@end
