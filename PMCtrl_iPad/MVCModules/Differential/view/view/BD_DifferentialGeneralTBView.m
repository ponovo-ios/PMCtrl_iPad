//
//  BD_DifferentialGeneralTBView.m
//  PMCtrl_iOS
//
//  Created by ponovo on 2017/8/29.
//  Copyright © 2017年 bodian. All rights reserved.
//

#import "BD_DifferentialGeneralTBView.h"
#import "BD_DifferentialGeneralCell.h"

@interface BD_DifferentialGeneralTBView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BD_DifferentialGeneralTBView

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
    self.tableFooterView = [UIView new];
    self.bounces = NO;
    self.backgroundColor = ClearColor;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self endEditing:YES];
}

-(void)endEditing{
    [self endEditing:YES];
}

#pragma mark -- UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.modelArr.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.modelArr[section];
    return arr.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
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
    valueLabel.text = @"参数";
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
    NSMutableArray *arrM = self.modelArr[indexPath.section];
    GeneralParaModel *generData = arrM[indexPath.row];
    
    //创建cell
    BD_DifferentialGeneralCell *cell = [[BD_DifferentialGeneralCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.contentView.backgroundColor = BDThemeColor;
    cell.titleLabel.text = generData.name;
    cell.cellindex = indexPath;
    //设置cell模型状态
    [cell cellTypeWith:(indexPath.section+1)*100+indexPath.row];
   
    //显示数值
    if (cell.cellType == SettingCellSelected) {
        
        [cell.selectedBtn setTitle:generData.param forState:UIControlStateNormal];
        cell.selectedBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -cell.selectedBtn.imageView.width, 0, cell.selectedBtn.imageView.width);
        
        [cell.selectedBtn addTarget:self action:@selector(showSelectView:) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        cell.textField.text = generData.param;
        cell.normalValue = generData.param;
  
        
    }
    
    if (indexPath.section == 1 && [((GeneralParaModel *)arrM[3]).param isEqualToString:@"手动计算并输入"]) {
        int index = (int)cell.cellindex.row;
        if ( index== 5 || index== 6 || index== 7 || index== 8 || index== 9 || index== 10 || index== 11 || index== 12 || index== 13) {
            cell.userInteractionEnabled = NO;
            cell.textField.textColor = [UIColor lightGrayColor];
        }
    }
    if (indexPath.section == 1 && [((GeneralParaModel *)arrM[3]).param isEqualToString:@"自动计算"]) {
        int index = (int)cell.cellindex.row;
        if (index== 4) {
            cell.userInteractionEnabled = NO;
            cell.textField.textColor = [UIColor lightGrayColor];
        }
    }
    
    __weak typeof(cell) weakcell = cell;
    cell.endChangeValueBlock = ^(NSString *value,NSIndexPath *cellindex){
        ((GeneralParaModel *)self.modelArr[cellindex.section][cellindex.row]).param = weakcell.normalValue;
        [self reloadRowsAtIndexPaths:@[cellindex]withRowAnimation:UITableViewRowAnimationNone];
    };
   
    
    self.generalResultBlock(self.modelArr);
    
    return cell;
}


#pragma mark 懒加载
-(NSMutableArray *)generalBaseArr{
    if (!_generalBaseArr) {
        _generalBaseArr = [[NSMutableArray alloc]init];
    }
    return _generalBaseArr;
}

-(NSMutableArray *)modelArr{
    if (!_modelArr) {
        _modelArr = [[NSMutableArray alloc]init];
    }
    return _modelArr;
}




- (void)showSelectView:(UIButton *)button{
    
    self.showGeneralBlock(button);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
