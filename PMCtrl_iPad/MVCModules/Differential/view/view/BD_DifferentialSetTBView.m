//
//  BD_DifferentialSetTBView.m
//  PMCtrl_iOS
//
//  Created by ponovo on 2017/8/29.
//  Copyright © 2017年 bodian. All rights reserved.
//

#import "BD_DifferentialSetTBView.h"
#import "BD_DifferentialSettingCell.h"

@interface BD_DifferentialSetTBView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BD_DifferentialSetTBView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        [self configureUI];
   
    }
    return self;
}

-(void)configureUI
{
    self.delegate = self;
    self.dataSource = self;
    self.separatorInset = UIEdgeInsetsZero;
    self.backgroundColor = ClearColor;
    self.tableFooterView = [UIView new];
    self.bounces = NO;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self endEditing:YES];
}

-(void)endEditing{
     [self endEditing:YES];
}

#pragma mark -- UITableViewDataSource, UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArr.count;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = RGB(65, 179,190);
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"名称";
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = White;
    [headerView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5);
        make.centerY.mas_offset(0);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [headerView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(1);
        make.right.mas_equalTo(-Main_Screen_Width / 3);
    }];
    
    UILabel *valueLabel = [[UILabel alloc] init];
    valueLabel.text = @"整定值";
    valueLabel.font = titleLabel.font;
    valueLabel.textColor = White;
    [headerView addSubview:valueLabel];
    [valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lineView.mas_right).offset(5);
        make.centerY.mas_equalTo(0);
    }];
    
    return headerView;
}

#pragma mark - cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    //取出模型
    SettingValueModel *setData = self.modelArr[indexPath.row];
    
    //创建cell
    BD_DifferentialSettingCell *cell = [[BD_DifferentialSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    cell.titleLabel.text = setData.name;
    cell.contentView.backgroundColor = BDThemeColor;
    cell.cellindex = indexPath;
    //设置cell模型状态
    [cell cellTypeWith:indexPath.row];
    
    //显示数值
    if (cell.cellType == SettingCellSelected) {
        
        [cell.selectedBtn setTitle:setData.val forState:UIControlStateNormal];
        cell.selectedBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -cell.selectedBtn.imageView.width, 0, cell.selectedBtn.imageView.width);
        
        [cell.selectedBtn addTarget:self action:@selector(showSelectView:) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        cell.textField.text = setData.val;
        cell.normalValue = setData.val;
        
       
    }
    
    switch (indexPath.row) {
        case 1:
            if ([[self.modelArr[0] val] isEqualToString:@"有名值"]) {
                cell.userInteractionEnabled = NO;
                [cell.selectedBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

            }
            break;
        case 2:
            if (![[self.modelArr[1] val] isEqualToString:@"其它"]) {
                cell.userInteractionEnabled = NO;
                cell.textField.textColor = [UIColor lightGrayColor];
            }
            break;
        case 7:
            if ([[self.modelArr[5] val] isEqualToString:@"一个拐点"]) {
                cell.userInteractionEnabled = NO;
                cell.textField.textColor = [UIColor lightGrayColor];
            }
            break;
        case 8:
            if (![[self.modelArr[5] val] isEqualToString:@"三个拐点"]) {
                cell.userInteractionEnabled = NO;
                cell.textField.textColor = [UIColor lightGrayColor];
            }
            break;
       
        case 11:
            if ([[self.modelArr[5] val] isEqualToString:@"一个拐点"]) {
                cell.userInteractionEnabled = NO;
                cell.textField.textColor = [UIColor lightGrayColor];
            }
            break;
        case 12:
            if (![[self.modelArr[5] val] isEqualToString:@"三个拐点"]) {
                cell.userInteractionEnabled = NO;
                cell.textField.textColor = [UIColor lightGrayColor];
            }
            break;
        default:
            break;
    }
    
    
   
    
    __weak typeof(cell) weakcell = cell;
    cell.endChangeValueBlock = ^(NSIndexPath *cellindex,NSString *value){
        
        ((SettingValueModel *)self.modelArr[indexPath.row]).val = weakcell.normalValue;
        
        [self reloadRowsAtIndexPaths:@[cellindex]withRowAnimation:UITableViewRowAnimationNone];
    };

    self.settingResultBlock(self.modelArr);
    
    return cell;
    
}

- (void)showSelectView:(UIButton *)button{
    
    self.showSettingBlock(button);
}


#pragma mark 懒加载
-(NSMutableArray <SettingValueModel *> *)setResultArr{
    if (!_setResultArr) {
        _setResultArr = [[NSMutableArray alloc]init];
    }
    return _setResultArr;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
