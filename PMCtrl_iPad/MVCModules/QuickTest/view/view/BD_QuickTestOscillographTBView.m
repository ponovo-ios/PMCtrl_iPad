//
//  BD_QuickTestOscillographTBView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/18.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_QuickTestOscillographTBView.h"
#import "BD_QuickTestOscillographCell.h"
#import "UIImage+Extension.h"
#import "BD_QuickTestBinaryStateLineViewCell.h"

@interface BD_QuickTestOscillographTBView()<UITableViewDelegate,UITableViewDataSource,BD_OscillographViewRefreshDelegate>{
    BD_QuickTestBinaryStateLineViewCell *binaryCell;
    BD_QuickTestOscillographCell *oscillographCell;
}


@end

@implementation BD_QuickTestOscillographTBView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = MainBgColor;
        [self createTBView];
        _xvalueMax = 600;
        [kNotificationCenter addObserver:self selector:@selector(reloadTBView:) name:BD_BinaryStateLineRefresh object:nil];
    }
    return self;
}


-(void)createTBView{
    self.tableView = [[UITableView alloc]init];
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.left.and.right.mas_equalTo(0.0);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = ClearColor;
    self.tableView.bounces = NO;

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.estimatedRowHeight = 0;
   [self.tableView registerNib:[UINib nibWithNibName:@"BD_QuickTestOscillographCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BD_QuickTestOscillographCellID"];
    [self.tableView registerClass:[BD_QuickTestBinaryStateLineViewCell class] forCellReuseIdentifier:@"BD_QuickTestBinaryStateLineViewCellID"];
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self endEditing:YES];
}

-(void)endEditing{
    [self endEditing:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return (self.frame.size.height-20)/2;
            break;
        case 1:
            return (self.frame.size.height*2)/3;
        default:
            break;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
         return _lineDataSourceArr.count;
    } else {
        return 1;//开入和开出状态图
    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *commoncell;
    if (indexPath.section==0) {
       
        
        BD_QuickTestOscillographCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"BD_QuickTestOscillographCellID" forIndexPath:indexPath];
        cell.chartViewXMax = (int)_xvalueMax;
        cell.isBegin = self.isBegin;
        cell.titleArr = [_titleArr[indexPath.row] copy];
        cell.delegate = self;
        cell.voltageDataArr =_lineDataSourceArr[indexPath.row].VAmplitudeArr;
        cell.currentDataArr =_lineDataSourceArr[indexPath.row].CAmplitudeArr;
        if (_lineDataSourceArr.count!=0 && self.selectedDataArr.count!=0) {
            if (_lineDataSourceArr[0].VAmplitudeArr.count == 4 && self.selectedDataArr[0].voltageArr.count==3) {
                [self.selectedDataArr[0].voltageArr addObject:@(YES)];
            }
            if (_lineDataSourceArr[0].VAmplitudeArr.count == 3 && self.selectedDataArr[0].voltageArr.count==4) {
                [self.selectedDataArr[0].voltageArr removeLastObject];
            }
        }
       
        cell.voltageSelectedArr = self.selectedDataArr[indexPath.row].voltageArr;
        cell.currentSelectedArr = self.selectedDataArr[indexPath.row].currentArr;
        
       [cell setCellData];
        oscillographCell = cell;
            WeakSelf;
            cell.cellLineStateBlock = ^(NSMutableArray *voltageSelectedArr, NSMutableArray *currentSelectedArr) {
//                weakself.selectedDataArr[indexPath.row].voltageArr = voltageSelectedArr;
//                weakself.selectedDataArr[indexPath.row].currentArr = currentSelectedArr;
            };
//            __weak typeof(cell) weakcell = cell;
//            cell.getDataFromVCBlock = ^{
//                if ([self.dataDelegate respondsToSelector:@selector(refreshData)]) {
//                    [self.dataDelegate refreshData];
//                }
//                weakcell.voltageDataArr = [@[_lineDataSourceArr[indexPath.row].UaAmplitude,_lineDataSourceArr[indexPath.row].UbAmplitude,_lineDataSourceArr[indexPath.row].UcAmplitude] mutableCopy];
//                weakcell.currentDataArr = [@[_lineDataSourceArr[indexPath.row].IaAmplitude,_lineDataSourceArr[indexPath.row].IbAmplitude,_lineDataSourceArr[indexPath.row].IcAmplitude] mutableCopy];
//
//            };
        commoncell = cell;
    } else {
        BD_QuickTestBinaryStateLineViewCell *stateCell = [[BD_QuickTestBinaryStateLineViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BD_QuickTestBinaryStateLineViewCellID"];
        stateCell.binaryStateValues = self.binaryStates;
        binaryCell = stateCell;
//        stateCell.binaryLineModels = _binaryStates[indexPath.row];
//        stateCell.xvalues = _xValues[indexPath.row];
//        [stateCell setLineData:_binaryStates[indexPath.row]];
//        [stateCell.binaryView setNeedsDisplay];
        commoncell = stateCell;
    }
    return commoncell;
  
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
}

#pragma mark - 定时获取数据代理
-(void)getRealData:(void (^)())complete{
    [self updateLoadLineData];
    if (self.isBegin==1) {
        complete();
    }
}
-(void)updateLoadLineData{
        if (self.isBegin == 1) {
            if ([self.dataDelegate respondsToSelector:@selector(refreshData)]) {
                [self.dataDelegate refreshData];
            }
            binaryCell.binaryStateValues = self.binaryStates;
            binaryCell.xvalue_max = _xvalueMax;
            oscillographCell.chartViewXMax = (int)_xvalueMax;
        }
}



-(void)setLineDataSourceArr:(NSMutableArray<BD_QuickTestOscillographModel *> *)lineDataSourceArr{
    _lineDataSourceArr = lineDataSourceArr;
}

-(NSArray<NSMutableArray<NSNumber*> *> *)binaryStates{
    if (!_binaryStates) {
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        for (int i = 0; i<18; i++) {
            [arr addObject:[[NSMutableArray alloc]init]];
        }
        _binaryStates = [arr copy];
    }
    return _binaryStates;
}
-(NSMutableArray<NSMutableArray<NSString *> *> *)titleArr{
    if (!_titleArr) {
        _titleArr = [[NSMutableArray alloc]init];
    }
    return _titleArr;
}
//-(NSMutableArray *)voltageSelectedArr{
//    if (!_voltageSelectedArr) {
//        _voltageSelectedArr = [[NSMutableArray alloc]initWithArray:@[@(YES),@(YES),@(YES)]];
//    }
//    return _voltageSelectedArr;
//}
//-(NSMutableArray *)currentSelectedArr{
//    if (!_currentSelectedArr) {
//        _currentSelectedArr = [[NSMutableArray alloc]initWithArray:@[@(YES),@(YES),@(YES)]];
//    }
//    return _currentSelectedArr;
//}

-(NSMutableArray<BD_OutputwaveShapeDataModel *> *)selectedDataArr{
    if (!_selectedDataArr) {
        _selectedDataArr = [[NSMutableArray alloc]init];
    }
    return _selectedDataArr;
}
-(NSArray<NSArray *> *)xValues{
    if (_xValues) {
        _xValues = [[NSArray alloc]init];
    }
    return _xValues;
}

////根据状态图数据源配置titleArr
//-(NSArray *)changeTotitleArr{
//    NSMutableArray *resultArr = [[NSMutableArray alloc]init];//返回最终的结果
//
//    for (int i = 0; i<_lineDataSourceArr.count; i++) {
//        NSMutableArray *titleArr = [[NSMutableArray alloc]init];
//        for (BD_QuickTestOscillographModel_Base *base in _lineDataSourceArr[i].VAmplitudeArr) {
//            [titleArr addObject:base.title];
//        }
//        for (BD_QuickTestOscillographModel_Base *base in _lineDataSourceArr[i].CAmplitudeArr) {
//            [titleArr addObject:base.title];
//        }
//        [resultArr addObject:titleArr];
//    }
//    return  [resultArr copy];
//}


-(void)reloadTBView:(NSNotification *)noti{
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:1];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
}

-(void)dealloc{
    [kNotificationCenter removeObserver:self name:BD_BinaryStateLineRefresh object:nil];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
