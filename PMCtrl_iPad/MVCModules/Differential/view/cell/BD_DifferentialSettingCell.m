//
//  BD_DifferentialSettingCell.m
//  PMCtrl_iOS
//
//  Created by wang on 2017/5/30.
//  Copyright © 2017年 wgx. All rights reserved.
//

#import "BD_DifferentialSettingCell.h"


@interface BD_DifferentialSettingCell() <UITextFieldDelegate>

@property (nonatomic , weak) UIView *lineView;

@property (nonatomic, assign) NSInteger row;

@end

@implementation BD_DifferentialSettingCell

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
        [_selectedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_selectedBtn setImage:[UIImage imageNamed:@"director"] forState:UIControlStateNormal];
        _selectedBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _selectedBtn.titleLabel.font = [UIFont systemFontOfSize:15];

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
    
    if (row == 0 || row == 1 || row == 5) {
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


//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    NSLog(@"++++");
//    // Configure the view for the selected state
//}

#pragma mark -- UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //设置输入的数值为float类型 设置输入内容为3位小数
    
    textField.text = [NSString stringWithFormat:@"%0.3f",[textField.text floatValue]];
    if (textField.text.length == 0) {
        textField.text = self.normalValue;
    } else {
        self.normalValue = self.textField.text;
    }
    self.endChangeValueBlock(_cellindex, self.normalValue);
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
