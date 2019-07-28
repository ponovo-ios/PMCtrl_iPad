//
//  BD_QuickTestPowerFormTBView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/21.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_QuickTestPowerFormTBView.h"
#import "BD_FormTBViewCell.h"
#import "BD_FormTBViewHeaderView.h"
#import "BD_FormTBViewBaseModel.h"
static NSString  * const HeaderTitle[5] = {@"名称",@"A相",@"B相",
    @"C相",@"总功率",};
@interface BD_QuickTestPowerFormTBView()<UITableViewDelegate,UITableViewDataSource>
@end

@implementation BD_QuickTestPowerFormTBView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = MainBgColor;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableFooterView = [UIView new];
        self.scrollEnabled = YES;
        self.bounces = NO;
        [self registerClass:[BD_FormTBViewCell class] forCellReuseIdentifier:@"BD_FormTBViewCellID"];
        
       
    }
    return  self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self endEditing:YES];
}

-(void)endEditing{
    [self endEditing:YES];
}

-(NSArray<NSArray<BD_FormTBViewBaseModel *> *> *)powerDatasource{
    if (!_powerDatasource) {
        _powerDatasource = [[NSArray alloc]init];
    }
    return _powerDatasource;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.powerDatasource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.powerDatasource[section].count;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    BD_FormTBViewHeaderView *headerView = [[BD_FormTBViewHeaderView alloc]initWithNum:5];
    
    [headerView.formArr enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == 0) {
            obj.text = [NSString stringWithFormat:@"%@G%ld",HeaderTitle[idx],(long)section+1];
        } else {
            obj.text = HeaderTitle[idx];
        }
    }];
    headerView.backgroundColor = [UIColor lightGrayColor];
    return headerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BD_FormTBViewCell *cell;
    if (cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"BD_FormTBViewCellID" forIndexPath:indexPath];
    } else {
        cell = [[BD_FormTBViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BD_FormTBViewCellID" num:5];
    }
    WeakSelf;
    [cell.formArr enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.text = weakself.powerDatasource[indexPath.section][indexPath.row].modelDatas[idx];
    }];
    cell.backgroundColor = ClearColor;
    return cell;
}

-(void)dealloc{
   
}
@end
