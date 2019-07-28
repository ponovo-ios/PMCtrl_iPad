//
//  BD_QuickSequenceComTBView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/21.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_FormTBView.h"
#import "BD_FormTBViewCell.h"
#import "BD_FormTBViewHeaderView.h"
#import "BD_FormTBViewBaseModel.h"

@interface BD_FormTBView()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation BD_FormTBView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style headerTitles:(NSArray *)headerTitles{
    if (self = [super initWithFrame:frame style:style]) {
        self.headerTitles = headerTitles;
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
#pragma mark - 懒加载
-(NSArray *)headerTitles{
    if (!_headerTitles) {
        _headerTitles = [[NSArray alloc]init];
    }
    return _headerTitles;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self endEditing:YES];
}

-(void)endEditing{
    [self endEditing:YES];
}

-(NSArray<NSArray<BD_FormTBViewBaseModel *> *> *)formDatasource{
    if (!_formDatasource) {
        _formDatasource = [[NSArray alloc]init];
    }
    return _formDatasource;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.formDatasource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.formDatasource[section].count;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_headerTitles.count!=0 && _headerTitles) {
        BD_FormTBViewHeaderView *headerView = [[BD_FormTBViewHeaderView alloc]initWithNum:(int)_headerTitles[section].count];
        
        if (_headerTitles.count==1) {
            [headerView.formArr enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                obj.text = _headerTitles[0][idx];
                
            }];
        } else {
            [headerView.formArr enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                obj.text = _headerTitles[section][idx];
                
            }];
        }
        
        headerView.backgroundColor = [UIColor lightGrayColor];
        return headerView;
    }
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BD_FormTBViewCell *cell;
    if (cell) {
        cell = [self dequeueReusableCellWithIdentifier:@"BD_FormTBViewCellID" forIndexPath:indexPath];
    } else {
        if (_headerTitles.count!=0 && _headerTitles) {
            cell = [[BD_FormTBViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BD_FormTBViewCellID" num:(int)_headerTitles[indexPath.section].count];
        }
        
    }
    WeakSelf;
    [cell.formArr enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.text = weakself.formDatasource[indexPath.section][indexPath.row].modelDatas[idx];
    }];
    cell.backgroundColor = ClearColor;
    return cell;
}

-(void)dealloc{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
