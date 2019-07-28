//
//  BD_HarmDCTableView.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/30.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_HarmDCTableView.h"
#import "BD_HarmDCCell.h"

@interface BD_HarmDCTableView()<UITableViewDelegate, UITableViewDataSource, BD_HarmDCCellDelegate>
{
    NSString *_titleStr;
    NSInteger _cellCount;
    NSString *_typeStr;
}


@end

static NSString * const DCCell = @"HarmDCCell";

@implementation BD_HarmDCTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    _titleStr = @"模拟直流设置";
    _cellCount = 6;
    _typeStr = @"";
    self.backgroundColor = RGB(0, 134, 146);
    self.dataSource = self;
    self.delegate = self;
    self.scrollEnabled = YES;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerClass:[BD_HarmDCCell class] forCellReuseIdentifier:DCCell];
    
    self.tableFooterView = [UIView new];
}

//根据选择状态刷新视图
-(void)reloadDataWithType:(BDDeviceType)type passageway:(BDHarmPassageType)passageway
{
    //赋值
    self.dcSettingModel.type = type;
    
//    //清空数据
//    [self.dcSettingModel clearData];
    
    if (type == BDDeviceType_Imitate) {
        _titleStr = @"模拟直流设置";
        _typeStr = @"";
    }else{
        _titleStr = @"数字直流设置";
        _typeStr = @"`";
    }
    
    if (passageway == BDHarmPassageType_FUTI) {
        _cellCount = 4;
    }else{
        _cellCount = 6;
    }
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
    }];
    [self reloadData];
}

#pragma mark BD_HarmDCCellDelegate
//赋值
-(void)changeCellIndex:(NSInteger)index textField:(UITextField *)textField
{

        if (_cellCount == 4) {//4U3I
            switch (index) {
                case 0:
                    if (textField.tag == 1) {
                        self.dcSettingModel.ua = textField.text;
                    }else{
                        self.dcSettingModel.ia = textField.text;
                    }
                    break;
                case 1:
                    if (textField.tag == 1) {
                        self.dcSettingModel.ub = textField.text;
                    }else{
                        self.dcSettingModel.ib = textField.text;
                    }
                    break;
                case 2:
                    if (textField.tag == 1) {
                        self.dcSettingModel.uc = textField.text;
                    }else{
                        self.dcSettingModel.ic = textField.text;
                    }
                    break;
                case 3:
                    if (textField.tag == 1) {
                        self.dcSettingModel.uz = textField.text;
                    }
                    break;
                    
                default:
                    break;
            }
        }else{//6U6I
            switch (index) {
                case 0:
                    if (textField.tag == 1) {
                        self.dcSettingModel.ua = textField.text;
                    }else{
                        self.dcSettingModel.ia = textField.text;
                    }
                    break;
                case 1:
                    if (textField.tag == 1) {
                        self.dcSettingModel.ub = textField.text;
                    }else{
                        self.dcSettingModel.ib = textField.text;
                    }
                    break;
                case 2:
                    if (textField.tag == 1) {
                        self.dcSettingModel.uc = textField.text;
                    }else{
                        self.dcSettingModel.ic = textField.text;
                    }
                    break;
                case 3:
                    if (textField.tag == 1) {
                        self.dcSettingModel.ua2 = textField.text;
                    }else{
                        self.dcSettingModel.ia2 = textField.text;
                    }
                    break;
                case 4:
                    if (textField.tag == 1) {
                        self.dcSettingModel.ub2 = textField.text;
                    }else{
                        self.dcSettingModel.ib2 = textField.text;
                    }
                    break;
                case 5:
                    if (textField.tag == 1) {
                        self.dcSettingModel.uc2 = textField.text;
                    }else{
                        self.dcSettingModel.ic2 = textField.text;
                    }
                    break;
                    
                default:
                    break;
            }
        }
    
}


#pragma mark UITableViewDelegate, UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cellCount;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = self.backgroundColor;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    
    titleLabel.textColor = [UIColor whiteColor];
    
    titleLabel.text = _titleStr;
    
    [headerView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(20);
    }];
    
    return headerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BD_HarmDCCell *cell = [tableView dequeueReusableCellWithIdentifier:DCCell];
    
    cell.index = indexPath.row;
    cell.delegate = self;
     
    if (_cellCount == 4) {//4U3I
        
        if (indexPath.row == 3) {
            cell.secondTitle.hidden = YES;
            cell.secondTF.hidden = YES;
            cell.lineView.backgroundColor = cell.backgroundColor;
        }else{
            cell.secondTitle.hidden = NO;
            cell.secondTF.hidden = NO;
            cell.lineView.backgroundColor = RGB(193, 213, 230);
        }
        
        cell.firstTitle.text = @[[NSString stringWithFormat:@"Ua%@(V):", _typeStr],
                                 [NSString stringWithFormat:@"Ub%@(V):", _typeStr],
                                 [NSString stringWithFormat:@"Uc%@(V):", _typeStr],
                                 [NSString stringWithFormat:@"Uz%@(V):", _typeStr]][indexPath.row];
        cell.secondTitle.text = @[[NSString stringWithFormat:@"Ia%@(A):", _typeStr],
                                  [NSString stringWithFormat:@"Ib%@(A):", _typeStr],
                                  [NSString stringWithFormat:@"Ic%@(A):", _typeStr],
                                  @""][indexPath.row];
        cell.firstTF.text = @[self.dcSettingModel.ua,
                              self.dcSettingModel.ub,
                              self.dcSettingModel.uc,
                              self.dcSettingModel.uz][indexPath.row];
        cell.secondTF.text = @[self.dcSettingModel.ia,
                              self.dcSettingModel.ib,
                              self.dcSettingModel.ic,
                               @""][indexPath.row];
    }else{//6U6I
        
        cell.secondTitle.hidden = NO;
        cell.secondTF.hidden = NO;
        cell.lineView.backgroundColor = RGB(193, 213, 230);
        
        cell.firstTitle.text = @[[NSString stringWithFormat:@"Ua%@(V):", _typeStr],
                                 [NSString stringWithFormat:@"Ub%@(V):", _typeStr],
                                 [NSString stringWithFormat:@"Uc%@(V):", _typeStr],
                                 [NSString stringWithFormat:@"Ua2%@(V):", _typeStr],
                                 [NSString stringWithFormat:@"Ub2%@(V):", _typeStr],
                                 [NSString stringWithFormat:@"Uc2%@(V):", _typeStr]][indexPath.row];
        cell.secondTitle.text = @[[NSString stringWithFormat:@"Ia%@(A):", _typeStr],
                                  [NSString stringWithFormat:@"Ib%@(A):", _typeStr],
                                  [NSString stringWithFormat:@"Ic%@(A):", _typeStr],
                                  [NSString stringWithFormat:@"Ia2%@(A):", _typeStr],
                                  [NSString stringWithFormat:@"Ib2%@(A):", _typeStr],
                                  [NSString stringWithFormat:@"Ic2%@(A):", _typeStr]][indexPath.row];
        cell.firstTF.text = @[self.dcSettingModel.ua,
                              self.dcSettingModel.ub,
                              self.dcSettingModel.uc,
                              self.dcSettingModel.ua2,
                              self.dcSettingModel.ub2,
                              self.dcSettingModel.uc2][indexPath.row];
        cell.secondTF.text = @[self.dcSettingModel.ia,
                               self.dcSettingModel.ib,
                               self.dcSettingModel.ic,
                               self.dcSettingModel.ia2,
                               self.dcSettingModel.ib2,
                               self.dcSettingModel.ic2][indexPath.row];

    }
    
    return cell;
}

#pragma mark - 懒加载
-(BD_HarmDCSettingModel *)dcSettingModel{
    if (!_dcSettingModel) {
        _dcSettingModel = [[BD_HarmDCSettingModel alloc]init];
    }
    return _dcSettingModel;
}



@end
