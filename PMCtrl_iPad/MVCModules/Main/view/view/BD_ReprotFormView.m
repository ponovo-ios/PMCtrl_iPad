//
//  BD_ReprotFormView.m
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2018/5/18.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_ReprotFormView.h"
#import "BD_FormTBViewCell.h"
#import "BD_FormTBViewHeaderView.h"
#import "BD_FormTBViewBaseModel.h"
@interface BD_ReprotFormView()<UITableViewDelegate,UITableViewDataSource>
//@property(nonatomic,strong)NSArray<UIView *> *lineViews;
//@property(nonatomic,assign)UIView  *centerLineview;

@end
@implementation BD_ReprotFormView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//- (instancetype)initWithNum:(int)num
//{
//    self = [super init];
//    if (self) {
//        [self loadSubViewsWithNum:num];
//    }
//    return self;
//}
//- (void)awakeFromNib {
//    [super awakeFromNib];
//
//    self.backgroundColor = ClearColor;
//    // Initialization code
//}
//
//
//-(void)layoutSubviews{
//    WeakSelf;
//    CGFloat labelW = (self.width-self.formArr1.count)/self.formArr1.count;
//    [_formArr1 enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        obj.frame = CGRectMake(idx*labelW,0,labelW,weakself.height/2-1);
//        if (idx != weakself.formArr1.count-1) {
//            weakself.lineViews[idx].frame = CGRectMake(obj.right,0,1,weakself.height);
//        }
//
//    }];
//
//    [_formArr2 enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        obj.frame = CGRectMake(idx*labelW,weakself.height/2,labelW,weakself.height/2-1);
//
//    }];
//
//
//    _centerLineview.frame= CGRectMake(0,self.height/2-1,self.width, 1);
//}
//-(void)loadSubViewsWithNum:(int)formNum{
//
//    NSMutableArray *formLabels1 = [[NSMutableArray alloc]init];
//    NSMutableArray *formLabels2 = [[NSMutableArray alloc]init];
//    NSMutableArray *lineViews = [[NSMutableArray alloc]init];
//    for (int i = 0; i<formNum; i++) {
//        UILabel *lab = [UILabel labelWithText:@"" textColor:Black fontSize:15 alignment:NSTextAlignmentCenter sizeToFit:YES];
//        lab.backgroundColor = ClearColor;
//        [self addSubview:lab];
//        if (i!=formNum-1) {
//            UIView *lineView = [[UIView alloc]init];
//            lineView.backgroundColor = [UIColor lightGrayColor];
//            [self addSubview:lineView];
//            [lineViews addObject:lineView];
//        }
//        [formLabels1 addObject:lab];
//
//        UILabel *lab2 = [UILabel labelWithText:@"" textColor:Black fontSize:15 alignment:NSTextAlignmentCenter sizeToFit:YES];
//        lab2.backgroundColor = ClearColor;
//        [self addSubview:lab2];
//        [formLabels2 addObject:lab2];
//    }
//    UIView *lineView = [[UIView alloc]init];
//    lineView.backgroundColor = [UIColor lightGrayColor];
//    [self addSubview:lineView];
//    _centerLineview = lineView;
//    self.lineViews = [lineViews copy];
//    self.formArr1 = [formLabels1 copy];
//    self.formArr2 = [formLabels2 copy];
//}
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style headerTitles:(NSArray *)headerTitles{
    if (self = [super initWithFrame:frame style:style]) {
        self.headerTitles = headerTitles;
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = White;
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
                obj.textColor = Black;
                obj.text = _headerTitles[0][idx];
                
            }];
        } else {
            [headerView.formArr enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                obj.text = _headerTitles[section][idx];
                
            }];
        }
        
        headerView.backgroundColor = White;
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
        obj.textColor = Black;
        obj.text = weakself.formDatasource[indexPath.section][indexPath.row].modelDatas[idx];
    }];
    cell.backgroundColor = ClearColor;
    return cell;
}

-(void)dealloc{
    
}
@end
