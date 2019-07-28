//
//  BD_HarmPickerCell.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/30.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_HarmPickerCell.h"
#import "BD_HarmSwitchSettingModel.h"

@interface BD_HarmPickerCell()

/**开入数组*/
@property (nonatomic, weak) NSMutableArray *switchInArray;

@end

@implementation BD_HarmPickerCell

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
    firstTitle.text = @"开入A:";
    [self.contentView addSubview:firstTitle];
    [firstTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(0);
    }];
    self.firstTitle = firstTitle;
    
    //按钮1
    BD_PickerButton *firstPickerBtn = [BD_PickerButton buttonWithType:UIButtonTypeCustom];
    firstPickerBtn.layer.cornerRadius = 5;
    firstPickerBtn.backgroundColor = [UIColor lightGrayColor];
    firstPickerBtn.tag = 1;
    [firstPickerBtn setTitle:@"未使用" forState:UIControlStateNormal];
    [self.contentView addSubview:firstPickerBtn];
    [firstPickerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(lineView.mas_left).offset(-20);
        make.width.mas_equalTo(100);
    }];
    [firstPickerBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.firstBtn = firstPickerBtn;
    
    //标题2
    UILabel *secondTitle = [[UILabel alloc] init];
    secondTitle.textColor = [UIColor whiteColor];
    secondTitle.text = @"开入B:";
    [self.contentView addSubview:secondTitle];
    [secondTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineView.mas_right).offset(20);
        make.centerY.mas_equalTo(0);
    }];
    self.secondTitle = secondTitle;
    
    //按钮2
    BD_PickerButton *secondPickerBtn = [BD_PickerButton buttonWithType:UIButtonTypeCustom];
    secondPickerBtn.layer.cornerRadius = 5;
    secondPickerBtn.backgroundColor = [UIColor lightGrayColor];
    secondPickerBtn.tag = 2;
    [secondPickerBtn setTitle:@"未使用" forState:UIControlStateNormal];
    [self.contentView addSubview:secondPickerBtn];
    [secondPickerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(100);
    }];
    [secondPickerBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.secondBtn = secondPickerBtn;
}

-(void)setIndex:(NSInteger)index
{
    _index = index;
    
    switch (index) {
        case 0:
            self.firstTitle.text = @"开入A:";
            self.secondTitle.text = @"开入B:";
            break;
        case 1:
            self.firstTitle.text = @"开入C:";
            self.secondTitle.text = @"开入D:";
            break;
        case 2:
            self.firstTitle.text = @"开入E:";
            self.secondTitle.text = @"开入F:";
            break;
        case 3:
            self.firstTitle.text = @"开入G:";
            self.secondTitle.text = @"开入H:";
            break;
        case 4:
            self.firstTitle.text = @"开入I:";
            self.secondTitle.text = @"开入J:";
            break;
        case 5:
            self.firstTitle.text = @"开入逻辑:";
            [self.firstBtn setTitle:@"逻辑与" forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    
}

-(void)setSwitchModel:(BD_HarmSwitchSettingModel *)switchModel
{
    _switchModel = switchModel;
    self.switchInArray = switchModel.switchInArray;
    
    
    NSInteger arrayIndex = _index * 2;
    
    if (_index < 5) {
        [self.firstBtn setTitle:self.switchInArray[arrayIndex] forState:UIControlStateNormal];
        [self.secondBtn setTitle:self.switchInArray[arrayIndex + 1] forState:UIControlStateNormal];
    }
    
    //逻辑开入 赋值
    if (self.index == 5) {
        [self.firstBtn setTitle:switchModel.switchLogic==0?@"逻辑或":@"逻辑与" forState:UIControlStateNormal];
    }
}

-(void)btnClick:(BD_PickerButton *)sender
{
    if (self.index == 5) {//逻辑开入
        [sender showPickerViewWithDataArray:@[@"逻辑与", @"逻辑或"] completion:^(NSString *title){
            DLog(@"%@", sender.titleLabel.text);
            //赋值
            if ([sender.titleLabel.text isEqualToString:@"逻辑与"]) {
                _switchModel.switchLogic = 1;
            } else {
                _switchModel.switchLogic = 0;
            }
            
            //向服务器发送数据改变通知
            [kNotificationCenter postNotificationName:BD_HarmSendData object:nil];
        }];
    }else{
        [sender showPickerViewWithDataArray:@[@"未使用", @"启动"] completion:^(NSString *title){
            DLog(@"%@", sender.titleLabel.text);
            if (sender.tag == 1) {//按钮1
                [_switchInArray replaceObjectAtIndex:_index * 2 withObject:sender.titleLabel.text];
            }else{//按钮2
                [_switchInArray replaceObjectAtIndex:_index * 2 + 1 withObject:sender.titleLabel.text];
            }
            //向服务器发送数据改变通知
            [kNotificationCenter postNotificationName:BD_HarmSendData object:nil];
        }];
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
