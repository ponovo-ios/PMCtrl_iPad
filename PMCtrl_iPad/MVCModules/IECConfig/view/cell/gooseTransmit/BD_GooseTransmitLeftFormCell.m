//
//  BD_GooseTransmitLeftFormCell.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/6.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_GooseTransmitLeftFormCell.h"
#import "UIButton+Extension.h"
#import "UITextField+Extension.h"
@implementation BD_GooseTransmitLeftFormCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = ClearColor;
        self.contentView.backgroundColor = FormBgColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews{
    
    UIView *bottomline = [[UIView alloc]init];
    [self.contentView addSubview:bottomline];
    bottomline.backgroundColor = [UIColor lightGrayColor];
    [bottomline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    
    UIView *bgview = [[UIView alloc]init];
    [self.contentView addSubview:bgview];
    bgview.backgroundColor = ClearColor;
    [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(bottomline.mas_top);
    }];
    
    _describeValue = [[UITextField alloc]init];
    _describeValue.borderStyle = UITextBorderStyleRoundedRect;
    [_describeValue setIECTFDefaultSetting];
    [bgview addSubview:_describeValue];
    [_describeValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bgview).offset(10);
        make.centerY.mas_equalTo(bgview);
//        make.width.mas_equalTo(bgview).multipliedBy(0.22);
        make.height.mas_equalTo(30);
    }];
    
    UIView *line1 = [[UIView alloc]init];
    line1.backgroundColor = [UIColor lightGrayColor];
    [bgview addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.mas_equalTo(bgview);
        make.left.mas_equalTo(_describeValue.mas_right).offset(5);
        make.width.mas_equalTo(1);
    }];
    
    _passageTypeValue = [[UIButton alloc]initWithTitle:@"" target:self radius:6 borderColor:[UIColor lightGrayColor] titleColor:[UIColor lightGrayColor] action:@selector(showSelectListView:)];
    _passageTypeValue.tag = 2;
    [bgview addSubview:_passageTypeValue];
    [_passageTypeValue setTitleColor:White forState:UIControlStateNormal];
    [_passageTypeValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_describeValue.mas_right).offset(10);
        make.centerY.mas_equalTo(_describeValue);
        make.width.and.height.mas_equalTo(_describeValue);
    
    }];
    
    UIView *line2 = [[UIView alloc]init];
    line2.backgroundColor = [UIColor lightGrayColor];
    [bgview addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.mas_equalTo(bgview);
        make.left.mas_equalTo(_passageTypeValue.mas_right).offset(5);
        make.width.mas_equalTo(1);
    }];
    
    
   
    
    _passageMapValue = [[UIButton alloc]initWithTitle:@"" target:self radius:6 borderColor:[UIColor lightGrayColor] titleColor:[UIColor lightGrayColor] action:@selector(showSelectListView:)];
    [bgview addSubview:_passageMapValue];
    _passageMapValue.tag = 3;
    [_passageTypeValue setTitleColor: White forState:UIControlStateNormal];
    [_passageMapValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_passageTypeValue.mas_right).offset(10);
        make.centerY.mas_equalTo(_passageTypeValue);
        make.width.and.height.mas_equalTo(_passageTypeValue);
    }];
    
    UIView *line3 = [[UIView alloc]init];
    line3.backgroundColor = [UIColor lightGrayColor];
    [bgview addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.mas_equalTo(bgview);
        make.left.mas_equalTo(_passageMapValue.mas_right).offset(5);
        make.width.mas_equalTo(1);
    }];
    
    
    _initialValue = [[UIButton alloc]initWithTitle:@"" target:self radius:6 borderColor:[UIColor lightGrayColor] titleColor:[UIColor lightGrayColor] action:@selector(showSelectListView:)];
    [_initialValue setTitleColor:White forState:UIControlStateNormal];
    [bgview addSubview:_initialValue];
    _initialValue.tag = 4;
    [_initialValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_passageMapValue.mas_right).offset(10);
        make.centerY.mas_equalTo(_passageMapValue);
        make.right.mas_equalTo(bgview.mas_right).offset(-10);
        make.width.and.height.mas_equalTo(_passageMapValue);
    }];
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)showSelectListView:(UIButton *)btn{
    //点击方法，将button的tag值返回，代表当前列的index
    self.TransmitLeftFormCellBtnClickBlock(btn.tag);
}

@end
