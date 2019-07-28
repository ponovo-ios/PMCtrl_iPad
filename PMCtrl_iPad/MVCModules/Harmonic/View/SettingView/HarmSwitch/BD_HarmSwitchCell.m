//
//  BD_HarmSwitchCell.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/30.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_HarmSwitchCell.h"

@interface BD_HarmSwitchCell()

@end

@implementation BD_HarmSwitchCell

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
    
    //标题1
    UILabel *firstTitle = [[UILabel alloc] init];
    firstTitle.textColor = [UIColor whiteColor];
    firstTitle.text = @"开出1状态:";
    [self.contentView addSubview:firstTitle];
    [firstTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(0);
    }];
    self.firstTitle = firstTitle;
    
    //开关1
    UISwitch *firstSwitch = [[UISwitch alloc] init];
    firstSwitch.tag = 1;
    firstSwitch.on = NO;
    [self.contentView addSubview:firstSwitch];
    [firstSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(lineView.mas_left).offset(-20);
    }];
    self.firstSwitch = firstSwitch;
    [firstSwitch addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    
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
    
    //开关2
    UISwitch *secondSwitch = [[UISwitch alloc] init];
    secondSwitch.tag = 2;
    secondSwitch.on = NO;
    [self.contentView addSubview:secondSwitch];
    [secondSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-20);
    }];
    self.secondSwitch = secondSwitch;
    [secondSwitch addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
}


-(void)setIndex:(NSInteger)index
{
    _index = index;
    switch (index) {
        case 6:
            self.firstTitle.text = @"开出1状态:";
            self.secondTitle.text = @"开出2状态:";
            break;
        case 7:
            self.firstTitle.text = @"开出3状态:";
            self.secondTitle.text = @"开出4状态:";
            break;
        case 8:
            self.firstTitle.text = @"开出5状态:";
            self.secondTitle.text = @"开出6状态:";
            break;
        case 9:
            self.firstTitle.text = @"开出7状态:";
            self.secondTitle.text = @"开出8状态:";
            break;
            
        default:
            break;
    }
}

-(void)setSwitchOutArray:(NSMutableArray *)switchOutArray
{
    _switchOutArray = switchOutArray;
    //赋值
    NSInteger i = (_index - 6) * 2;
    self.firstSwitch.on = [switchOutArray[i] isEqualToString:@"打开"] ? YES : NO;
    self.secondSwitch.on = [switchOutArray[i + 1] isEqualToString:@"打开"] ? YES : NO;
}

-(void)switchChange:(UISwitch *)sender
{
    DLog(@"%ld -- %ld -- %@", self.index, sender.tag, sender.isOn ? @"开" : @"关");
    NSInteger i = (_index - 6) * 2;
    if (sender.tag == 1) {//开关1
        [_switchOutArray replaceObjectAtIndex:i withObject:sender.isOn ? @"打开" : @"闭合"];
    }else{//开关2
        [_switchOutArray replaceObjectAtIndex:i + 1 withObject:sender.isOn ? @"打开" : @"闭合"];
    }
    
    //向服务器发送数据改变通知
    [kNotificationCenter postNotificationName:BD_HarmSendData object:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
