//
//  BD_DifferGooseSendView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/11.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_DifferGooseSendView.h"
#import "UIImage+Extension.h"
#import "BD_DifferentialGooseInfoCell.h"
@interface BD_DifferGooseSendView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *gooseInfoTBView;
@property(nonatomic,strong)UITableView *gooseSendTBView;

@end

@implementation BD_DifferGooseSendView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
   
        
    }
    return self;
}

-(void)loadSubViews{

    NSMutableArray *btnArr = [[NSMutableArray alloc]init];
    for (NSInteger i =0; i<_groupNum; i++) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:[NSString stringWithFormat:@"G%ld",i+1] forState:UIControlStateNormal];
        [btn setFrame:CGRectMake(i*50,0,50,35)];
        [btn setTitleColor:Black forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:ClearColor width:50 height:30 title:@""] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(viewTabBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundImage:[UIImage imageWithColor:White width:50 height:30 title:@""] forState:UIControlStateSelected];
        if (i == 0) {
            [btn setSelected:YES];
        } else {
            [btn setSelected: NO];
        }
        btn.tag = i;
        [self addSubview:btn];
        [btnArr addObject:btn];
    }
    self.viewTabArr = [btnArr copy];
    
    _gooseInfoTBView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _gooseInfoTBView.delegate = self;
    _gooseInfoTBView.dataSource = self;
    _gooseInfoTBView.bounces = NO;
    _gooseInfoTBView.scrollEnabled = NO;
    _gooseInfoTBView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_gooseInfoTBView registerNib:[UINib nibWithNibName:@"BD_DifferentialGooseInfoCell" bundle:nil] forCellReuseIdentifier:@"BD_DifferentialGooseInfoCellID"];
    [self addSubview:_gooseInfoTBView];
    
    _gooseSendTBView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _gooseSendTBView.delegate = self;
    _gooseSendTBView.dataSource = self;
    [self addSubview:_gooseSendTBView];
    
    
    
}

-(void)layoutSubviews{
    WeakSelf;
    [_gooseInfoTBView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(35);
        make.height.mas_equalTo(weakself.mas_height).multipliedBy(0.5);
    }];
    
    [_gooseSendTBView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(weakself.gooseInfoTBView.mas_bottom).offset(5);
        make.bottom.mas_equalTo(0);
    }];
}

-(void)viewTabBtnAction:(UIButton *)sender{
    [self.viewTabArr enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqual:sender]) {
            [obj setSelected: YES];
        } else {
            [obj setSelected:NO];
        }
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:_gooseInfoTBView]) {
        return 7;
    } else {
        return 7;
    }
    return 0;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if ([tableView isEqual:_gooseInfoTBView]) {
        NSArray *titles = @[@[  @"IEC名称",
                              @"控制块索引(GcRef)",
                              @"GOOSE标识(GoID)",
                              @"应用标识(APPID)",
                              @"源地址(MAC)",
                              @"目的地址(MAC)",
                              @"配置版本号(ConfReversion)"],
                            @[
                              @"允许生存时间(ms)",
                              @"数据集",
                              @"委托(NdsCom)",
                              @"测试(Test)",
                              @"VLAN",
                              @"VLAN Priority",
                              @""]];
        BD_DifferentialGooseInfoCell *infoCell = [tableView dequeueReusableCellWithIdentifier:@"BD_DifferentialGooseInfoCellID" forIndexPath:indexPath];
        infoCell.title1.text = titles[0][indexPath.row];
        infoCell.title2.text = titles[1][indexPath.row];
        if (indexPath.row == [tableView numberOfRowsInSection:0]-1) {
            infoCell.title2.hidden = YES;
            infoCell.value2.hidden = YES;
            infoCell.getReverseBtn.hidden = NO;
            infoCell.getReverseLabel.hidden = NO;
            infoCell.repairBtn.hidden = NO;
            infoCell.repairLabel.hidden = NO;
        } else {
            infoCell.title2.hidden = NO;
            infoCell.value2.hidden = NO;
            infoCell.getReverseBtn.hidden = YES;
            infoCell.getReverseLabel.hidden = YES;
            infoCell.repairBtn.hidden = YES;
            infoCell.repairLabel.hidden = YES;
        }
        
        cell = infoCell;
    } else {
        cell = [[UITableViewCell alloc]init];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_gooseInfoTBView]) {
        return 30;
    } else {
        return 30;
    }
    return 0;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
