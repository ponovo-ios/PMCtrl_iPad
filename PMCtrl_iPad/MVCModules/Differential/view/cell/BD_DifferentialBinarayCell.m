//
//  BD_DifferentialBinarayCell.m
//  PMCtrl_iOS
//
//  Created by wang on 2017/5/30.
//  Copyright © 2017年 wgx. All rights reserved.
//

#import "BD_DifferentialBinarayCell.h"
//#import "MMComboBox.h"

@implementation BD_DifferentialBinarayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//-(UIButton *)valueBtn{
//    
//    if (_valueBtn == nil) {
//        _valueBtn = [UIButton buttonWithType:<#(UIButtonType)#>];
//    }
//}

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
    titleLabel.font = [UIFont systemFontOfSize:12];
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

    //数值
    UIButton *valueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    valueBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    
    [valueBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [valueBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];

    [valueBtn setBackgroundColor:RGB(144, 255, 255)];

    valueBtn.titleLabel.font = _titleLabel.font;
//    valueBtn.titleLabel.textAlignment = NSTextAlignmentLeft;

    [valueBtn setTitle:@"开放" forState:UIControlStateNormal];
    [valueBtn setImage:[UIImage imageNamed:@"down_dark"] forState:UIControlStateNormal];
    
    valueBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);

//    valueBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    [valueBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0.0,0.0, -ScaleFont(120))];
//    [valueBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -ScaleFont(90), 0, 0)];
    
    [self addSubview:valueBtn];
    
    [valueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineView.mas_right).offset(0);
        make.right.bottom.top.mas_equalTo(self).offset(0);
    }];
    self.valueBtn = valueBtn;
}


//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//    
//    NSLog(@"++++++++++");
//    // Configure the view for the selected state
//}


@end
