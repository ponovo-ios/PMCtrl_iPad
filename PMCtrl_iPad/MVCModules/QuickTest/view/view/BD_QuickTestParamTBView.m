//
//  BD_QuickTestParamTBView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/10.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_QuickTestParamTBView.h"
#import "BD_TestDataParamModel.h"

#import "BD_QuickTestParamHeaderView.h"
#import "IQKeyboardManager.h"
@interface BD_QuickTestParamTBView()<UITableViewDelegate,UITableViewDataSource>
{
    BD_HardwarkConfigModel *hardwarkModel;
    
}
@end
@implementation BD_QuickTestParamTBView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = MainBgColor;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableFooterView = [UIView new];
        self.scrollEnabled = YES;
        self.bounces = NO;
        [self registerNib:[UINib nibWithNibName:@"BD_QuickTestParamCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BD_QuickTestParamCellID"];
         [self registerNib:[UINib nibWithNibName:@"BD_QuickTestParamHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"BD_QuickTestParamHeaderViewID"];
        [kNotificationCenter addObserver:self selector:@selector(reloadTBView:) name:BD_IsCocurrentNoti object:nil];
        [kNotificationCenter addObserver:self selector:@selector(changeValueLimit:) name:BD_OutPutLimitNotifi object:nil];
        
        hardwarkModel = [[BD_HardwarkConfigModel alloc]init];
        //设置键盘出现后移动页面
        [IQKeyboardManager sharedManager].enable = YES;
        [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
        [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
        [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 60;
        
    }
    return  self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self endEditing:YES];
}

-(void)endEditing{
    [self endEditing:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    BD_QuickTestParamHeaderView *headerview = [[NSBundle mainBundle]loadNibNamed:@"BD_QuickTestParamHeaderView" owner:nil options:nil].lastObject;
    headerview.amplitudeLabel.text = _headerTitleArr[0];
    headerview.phaseLabel.text = _headerTitleArr[1];
    headerview.frequencyLabel.text = _headerTitleArr[2];
    return headerview;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BD_QuickTestParamCell *cell = [self dequeueReusableCellWithIdentifier:@"BD_QuickTestParamCellID" forIndexPath:indexPath];
    cell.isDirectCurr = self.isDirectCurrent;
    if (_datasource) {
        cell.cellTitle.text = _datasource[indexPath.row].titleName;
        cell.phase.text =  _datasource[indexPath.row].phase;
        cell.amplitude.text = _datasource[indexPath.row].amplitude;
        cell.frequency.text = _datasource[indexPath.row].frequency;
    }
    cell.quickParamBlock = ^(BD_TestDataParamModel *cellmodel) {
        [_datasource replaceObjectAtIndex:indexPath.row withObject:cellmodel];
        self.quickTBParaBlack(cellmodel,indexPath.row);
    };
    if (indexPath.row == _datasource.count-1) {
        cell.lineView.hidden = YES;
    } else {
        cell.lineView.hidden = NO;
    }
    cell.cellType = _type;
    cell.isLock = self.isLock;
    cell.isBegin = self.isBegin;
   
    if (_isDirectCurrent) {
        [[BD_Utils shared]setViewState:NO view:cell.phase];
        [[BD_Utils shared]setViewState:NO view:cell.frequency];
     
    } else {
        [[BD_Utils shared]setViewState:YES view:cell.phase];
        [[BD_Utils shared]setViewState:YES view:cell.frequency];
       
        
    }
    cell.phase.text =  _datasource[indexPath.row].phase;
    cell.frequency.text = _datasource[indexPath.row].frequency;
    return cell;
}


-(void)reloadTBView:(NSNotification *)noti{
    BOOL isCocurrent = [(NSNumber *)noti.object boolValue];
    if (!isCocurrent) {
        //交流限制
        [_datasource enumerateObjectsUsingBlock:^(BD_TestDataParamModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (_type == BD_CellTypeVoltage) {
                if ([obj.amplitude floatValue]>[hardwarkModel.exchangeVoltage floatValue]) {
                    obj.amplitude = hardwarkModel.exchangeVoltage;
                } else if ([obj.amplitude floatValue]<0){
                    obj.amplitude = @"0.000";
                }
                
            } else if (_type == BD_CellTypeCurrent){
                if ([obj.amplitude floatValue]>[hardwarkModel.exchangeCurrent floatValue]) {
                    obj.amplitude = hardwarkModel.exchangeCurrent;
                }  else if ([obj.amplitude floatValue]<0){
                    obj.amplitude = @"0.000";
                }
            }
            if ([obj.titleName containsString:@"a"]) {
                obj.phase = @"0.000";
                obj.frequency = @"50.000";
            } else  if ([obj.titleName containsString:@"b"]) {
                obj.phase = @"-120.000";
                obj.frequency = @"50.000";
            }else if ([obj.titleName containsString:@"c"]) {
                obj.phase = @"120.000";
                obj.frequency = @"50.000";
            }
        }];
    } else {
        //直流限制
        [_datasource enumerateObjectsUsingBlock:^(BD_TestDataParamModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (_type == BD_CellTypeVoltage) {
                if ([obj.amplitude floatValue]>[hardwarkModel.directVoltage floatValue]) {
                    obj.amplitude = hardwarkModel.directVoltage;
                }
                
            } else if (_type == BD_CellTypeCurrent){
                if ([obj.amplitude floatValue]>[hardwarkModel.directCurrent floatValue]) {
                    obj.amplitude = hardwarkModel.directCurrent;
                }
            }
            obj.phase = @"0.000";
            obj.frequency = @"0.000";
        }];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
       [self reloadData];
    });
    
}
-(void)changeValueLimit:(NSNotification *)noti{
    BD_HardwarkConfigModel *limit = (BD_HardwarkConfigModel *)noti.object;
    hardwarkModel = limit;
    [self reloadData];
}

-(NSArray<NSString *> *)headerTitleArr{
    if (_headerTitleArr) {
        _headerTitleArr = @[@"幅值(V)",@"相位(°)",@"频率(Hz)"];
    }
    return _headerTitleArr;
}

-(void)dealloc{
    [kNotificationCenter removeObserver:self name:BD_IsCocurrentNoti object:nil];
    [kNotificationCenter removeObserver:self name:BD_OutPutLimitNotifi object:nil];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
