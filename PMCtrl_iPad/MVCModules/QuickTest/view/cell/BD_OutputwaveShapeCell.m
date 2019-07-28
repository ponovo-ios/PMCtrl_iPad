//
//  BD_OutputwaveShapeCell.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/28.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_OutputwaveShapeCell.h"
#import "BD_OutputWaveShapeDataCell.h"
#import "DateValueFormatter.h"
#import "BD_TestDataParamModel.h"
#define GranularityTime 1.0
#define LineWidth 1.0
@interface BD_OutputwaveShapeCell()<UITableViewDelegate,UITableViewDataSource,ChartViewDelegate>{
    double _lineChartMaxValue_V;
    double _lineChartMaxValue_C;
    
}
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property( nonatomic,strong) NSMutableArray *VdataSets;
@property( nonatomic,strong) NSMutableArray *CdataSets;
@property( nonatomic,strong)LineChartData *data;
@end

@implementation BD_OutputwaveShapeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = ClearColor;
    self.contentView.backgroundColor = ClearColor;
    [self.bgView setCorenerRadius:2 borderColor:Black borderWidth:2.0];
    self.bgView.backgroundColor = [UIColor colorWithRed:42.0/255.0 green:41.0/255.0 blue:42.0/255.0 alpha:1.0];
    self.tableView.backgroundColor = ClearColor;
    [self.tableView setCorenerRadius:10.0 borderColor:BtnViewBorderColor borderWidth:2.0];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    [_tableView registerNib:[UINib nibWithNibName:@"BD_OutputWaveShapeDataCell" bundle:nil] forCellReuseIdentifier:@"BD_OutputWaveShapeDataCellID"];
    //配置实时输出波形图
    [self configLineChart];
    _lineChartMaxValue_C = 30;
    _lineChartMaxValue_V = 150;
    
    [kNotificationCenter addObserver:self selector:@selector(clearDataSet:) name:BD_ManualTestBegin object:nil];
//    _UVLabel.transform =  CGAffineTransformMakeRotation(-M_PI_2);
//    _IALabel.transform =  CGAffineTransformMakeRotation(-M_PI_2);
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 懒加载
-(BD_OutputwaveShapeDataModel *)waveDataModel{
    if (!_waveDataModel) {
        _waveDataModel = [[BD_OutputwaveShapeDataModel alloc]initWithVoltageArr:[[NSMutableArray alloc]init] currentArr:[[NSMutableArray alloc]init]];
    }
    return _waveDataModel;
}
-(NSMutableArray *)voltageSelectedArr{
    if (!_voltageSelectedArr) {
        _voltageSelectedArr = [[NSMutableArray alloc]initWithObjects:@(YES),@(YES),@(YES), nil];
    }
    return _voltageSelectedArr;
}
-(NSMutableArray *)currentSelectedArr{
    if (!_currentSelectedArr) {
        _currentSelectedArr = [[NSMutableArray alloc]initWithObjects:@(YES),@(YES),@(YES), nil];
    }
    return _currentSelectedArr;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _waveDataModel.voltageArr.count+_waveDataModel.currentArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BD_OutputWaveShapeDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BD_OutputWaveShapeDataCellID" forIndexPath:indexPath];
    cell.cellIndex = (int)indexPath.row;
    NSArray<UIColor *> *colorArr;
    if (_waveDataModel.voltageArr.count==4) {
        colorArr = @[Yellow,Green,Red,[UIColor blueColor],Yellow,Green,Red];
    } else {
        colorArr = @[Yellow,Green,Red,Yellow,Green,Red];
    }
//    cell.lineMarkColorView.backgroundColor = colorArr[indexPath.row];
  
    
    if ([tableView numberOfRowsInSection:0] == 7) {
        if (indexPath.row<4) {
            BD_TestDataParamModel *testmodel = (BD_TestDataParamModel *)_waveDataModel.voltageArr[indexPath.row];
            cell.waveTitle.text = testmodel.titleName;
            cell.amplitudeValue.text = testmodel.amplitude;
             cell.phaseValue.text = testmodel.phase;
        } else {
            BD_TestDataParamModel *testmodel = (BD_TestDataParamModel *)_waveDataModel.currentArr[indexPath.row-4];
            cell.waveTitle.text = testmodel.titleName;
            cell.amplitudeValue.text = testmodel.amplitude;
            cell.phaseValue.text = testmodel.phase;
            
        }
    } else{
        if (_waveDataModel.voltageArr.count>=_waveDataModel.currentArr.count) {
            if (indexPath.row<3) {
                BD_TestDataParamModel *testmodel = (BD_TestDataParamModel *)_waveDataModel.voltageArr[indexPath.row];
                cell.waveTitle.text = testmodel.titleName;
                cell.amplitudeValue.text = testmodel.amplitude;
                cell.phaseValue.text = testmodel.phase;
                
                
            } else {
                BD_TestDataParamModel *testmodel = (BD_TestDataParamModel *)_waveDataModel.currentArr[indexPath.row-3];
                cell.waveTitle.text = testmodel.titleName;
                cell.amplitudeValue.text = testmodel.amplitude;
                cell.phaseValue.text = testmodel.phase;
                
            }
        } else {
                BD_TestDataParamModel *testmodel = (BD_TestDataParamModel *)_waveDataModel.currentArr[indexPath.row];
                cell.waveTitle.text = testmodel.titleName;
                cell.amplitudeValue.text = testmodel.amplitude;
                cell.phaseValue.text = testmodel.phase;
            
            
        }
        
    }
    
    //波形图标签，为了显示虚线
    [cell addLayerToMarkViewWithColor:colorArr[indexPath.row] title:cell.waveTitle.text];
    
    
    if (_waveDataModel.voltageArr.count != 0 && _waveDataModel.currentArr.count != 0) {
        if (indexPath.row>[tableView numberOfRowsInSection:indexPath.section]-3-1) {
            BOOL state = [_currentSelectedArr[indexPath.row-_voltageSelectedArr.count] boolValue];
            [cell.selectedBtn setSelected:state];
        } else {
            [cell.selectedBtn setSelected:[_voltageSelectedArr[indexPath.row] boolValue]];
        }
    }
    
    
    if (_waveDataModel.voltageArr.count == 0) {
         [cell.selectedBtn setSelected:[_currentSelectedArr[indexPath.row] boolValue]];
    } else if (_waveDataModel.currentArr.count == 0){
         [cell.selectedBtn setSelected:[_voltageSelectedArr[indexPath.row] boolValue]];
    }
    //选择是否显示波形图的线
    WeakSelf;
    cell.selectedBlock = ^(BOOL state, int cellIndex) {
       
        if (weakself.waveDataModel.voltageArr.count != 0 && weakself.waveDataModel.currentArr.count != 0) {
            if (cellIndex<[tableView numberOfRowsInSection:indexPath.section]-3) {
                [weakself.voltageSelectedArr replaceObjectAtIndex:cellIndex withObject:@(state)];
            } else {
                [weakself.currentSelectedArr replaceObjectAtIndex:cellIndex-_voltageSelectedArr.count withObject:@(state)];
            }
        }
        
        if (_waveDataModel.voltageArr.count == 0) {
            [weakself.currentSelectedArr replaceObjectAtIndex:cellIndex withObject:@(state)];
        } else if (_waveDataModel.currentArr.count == 0){
            [weakself.voltageSelectedArr replaceObjectAtIndex:cellIndex withObject:@(state)];
        }
        
        self.selectedWaveShapeViewBlock(_voltageSelectedArr, _currentSelectedArr);
        [weakself refreshLineChartView];
        
        
    };
    if ( [cell.waveTitle.text hasPrefix:@"U"]) {
        cell.amplitudeLabel.text = @"幅值(V):";
    } else if ([cell.waveTitle.text hasPrefix:@"I"]){
        cell.amplitudeLabel.text = @"幅值(A):";
    }
    if (_isShowLinewave) {
        [self refreshLineChartView];
      
    } else {
        self.waveShapeView.rightAxis.axisMaximum = _lineChartMaxValue_C;
        self.waveShapeView.rightAxis.axisMinimum = 0;
        self.waveShapeView.leftAxis.axisMaximum = _lineChartMaxValue_V;
        self.waveShapeView.leftAxis.axisMinimum = 0;
        self.waveShapeView.xAxis.axisMaximum = 50;
        self.waveShapeView.xAxis.axisMinimum = 0;
        self.waveShapeView.data = [LineChartData new];
        
    }
    
    return cell;
}


#pragma mark - lineChartView
-(void)configLineChart{
    
    
    _VdataSets = [[NSMutableArray alloc]init];
    _CdataSets = [[NSMutableArray alloc]init];
    _data = [[LineChartData alloc]init];
    _waveShapeView.delegate = self;
    _waveShapeView.chartDescription.enabled = NO;
    
    _waveShapeView.dragEnabled = NO;
    [_waveShapeView setScaleEnabled:NO];
    _waveShapeView.pinchZoomEnabled = NO;
    _waveShapeView.drawGridBackgroundEnabled = NO;
    _waveShapeView.doubleTapToZoomEnabled = NO;
    _waveShapeView.noDataTextColor = White;
    
//    _waveShapeView.xAxis.valueFormatter = [[DateValueFormatter alloc] init];
    
    _waveShapeView.xAxis.gridLineDashLengths = @[@5.f,@5.f];
    _waveShapeView.xAxis.gridLineDashPhase = 0.5f;
    _waveShapeView.xAxis.labelTextColor = White;
    _waveShapeView.xAxis.gridColor = White;
    _waveShapeView.xAxis.labelPosition = XAxisLabelPositionBottom;
//    [_waveShapeView.xAxis setLabelCount:6];
    
    _waveShapeView.xAxis.drawAxisLineEnabled = YES;
    _waveShapeView.xAxis.drawGridLinesEnabled = YES;
    _waveShapeView.xAxis.centerAxisLabelsEnabled = NO;
    _waveShapeView.xAxis.drawLabelsEnabled = YES;
    [_waveShapeView.xAxis setLabelCount:6 force:NO];
    
    _waveShapeView.noDataText = @"暂无数据";
    _waveShapeView.noDataTextColor = White;
//    [_waveShapeView.xAxis setGranularity:GranularityTime];
    
    
    ChartYAxis *leftAxis = _waveShapeView.leftAxis;
    [leftAxis removeAllLimitLines];
    leftAxis.axisMaximum = _lineChartMaxValue_V;
    leftAxis.axisMinimum = -_lineChartMaxValue_V;
    leftAxis.gridLineDashLengths = @[@5.f, @5.f];
    leftAxis.drawZeroLineEnabled = YES;
    leftAxis.drawLimitLinesBehindDataEnabled = NO;
    leftAxis.labelTextColor = White;
    leftAxis.axisLineColor = White;
    leftAxis.gridColor = White;
    [_waveShapeView.leftAxis setLabelCount:10 force:NO];
    _waveShapeView.rightAxis.enabled = YES;
    
    
    ChartYAxis *rightAxis = _waveShapeView.rightAxis;
    [rightAxis removeAllLimitLines];
    rightAxis.axisMaximum = _lineChartMaxValue_C;
    rightAxis.axisMinimum = -_lineChartMaxValue_C;
    rightAxis.gridLineDashLengths = @[@5.f, @5.f];
    rightAxis.drawZeroLineEnabled = YES;
    rightAxis.drawLimitLinesBehindDataEnabled = NO;
    rightAxis.labelTextColor = White;
    rightAxis.axisLineColor = White;
    rightAxis.gridColor = White;
    [rightAxis setLabelCount:10 force:NO];
    _waveShapeView.legend.form = ChartLegendFormLine;
    [_waveShapeView.legend setEnabled:NO];
    [_data setDrawValues:NO];
    
    
    //    [_waveShapeView animateWithXAxisDuration:0.5];
}


-(void)setDataCount:(NSArray *)voltageyvalues currentyvalues:(NSArray *)currentyvalues
{
    
    NSArray<UIColor *> *lineColor;
    _lineChartMaxValue_C = 0.0;
    _lineChartMaxValue_V = 0.0;
    
    if (_waveDataModel.voltageArr.count == 4) {
        lineColor= @[Yellow,Green,Red,[UIColor blueColor]];
    } else {
        lineColor= @[Yellow,Green,Red];
    }
    @autoreleasepool{
        for (int i = 0; i<_waveDataModel.voltageArr.count; i++) {
            
            NSMutableArray *values = [[NSMutableArray alloc] init];
            
            for (int x = 0; x < 500; x ++ )
            {
                
                double amplitude  = [((BD_TestDataParamModel *)_waveDataModel.voltageArr[i]).amplitude floatValue];
                double phase = [((BD_TestDataParamModel *)_waveDataModel.voltageArr[i]).phase floatValue];
                double frequency = [((BD_TestDataParamModel *)_waveDataModel.voltageArr[i]).frequency floatValue];
                //计算y的时候，y的值是根据x的值计算得来的，i只是获取数据模型中对应的幅值／相位和电压
                double y;//
                if (frequency!=0) {//当频率为0的时候，计算y值会报错，添加默认值
                    y = sqrt(2) * amplitude * sin(2*M_PI*frequency/1000*x + DEGREES_TO_RADIANS(phase));
                } else {
                    y = amplitude;
                    
                }
                if (y>_lineChartMaxValue_V) {
                    _lineChartMaxValue_V = y;
                }
                
                [values addObject:[[ChartDataEntry alloc] initWithX:x y:y icon: nil]];
            }
            
            
            
            LineChartDataSet *set1 = nil;
            if (_VdataSets.count >= voltageyvalues.count)
            {
                
                if ([voltageyvalues[i]  isEqual: @(YES)]) {
                    set1 = (LineChartDataSet *)_waveShapeView.data.dataSets[i];
                    set1.values = values;
                    set1.lineWidth = LineWidth;
                    set1.circleRadius = 2.0;
                    [set1 setDrawValuesEnabled:YES];
                    
                } else {
                    set1 = (LineChartDataSet *)_waveShapeView.data.dataSets[i];
                    set1.values = values;
                    set1.lineWidth = 0.0;
                    set1.circleRadius = 0.0;
                    [set1 setDrawValuesEnabled:NO];
                }
                [_waveShapeView.data notifyDataChanged];
                [_waveShapeView notifyDataSetChanged];
            } else {
                
                set1 = [[LineChartDataSet alloc] initWithValues:values label:@"111"];
                set1.drawIconsEnabled = NO;
                set1.lineDashLengths = @[@1.0f, @0.0f];
                set1.highlightLineDashLengths = @[@1.0f, @0.0f];//至少有一个为非0
                
                [set1 setColor:_VdataSets.count!=3?lineColor[i]:[lineColor lastObject]];
                [set1 setCircleColor:_VdataSets.count!=3?lineColor[i]:[lineColor lastObject]];
                set1.lineWidth = LineWidth;
                set1.axisDependency = AxisDependencyLeft;
                set1.circleRadius = 2.0;
                set1.drawCirclesEnabled = NO;
                set1.drawCircleHoleEnabled = NO;
                set1.mode = LineChartModeCubicBezier;
                [set1 setDrawVerticalHighlightIndicatorEnabled:NO];
                [set1 setDrawHorizontalHighlightIndicatorEnabled:NO];
                [_VdataSets addObject:set1];
            }
            
            
        }
    }

    _data.dataSets = [_VdataSets arrayByAddingObjectsFromArray:_CdataSets];
    _waveShapeView.data = _data;
    
    for (int i = 0; i<_waveDataModel.currentArr.count; i++) {
        
        NSMutableArray *value = [[NSMutableArray alloc] init];
        for (int x = 0; x < 500; x ++ )
        {
            double amplitude  = [((BD_TestDataParamModel *)_waveDataModel.currentArr[i]).amplitude doubleValue];
            double phase = [((BD_TestDataParamModel *)_waveDataModel.currentArr[i]).phase doubleValue];
            double frequency = [((BD_TestDataParamModel *)_waveDataModel.currentArr[i]).frequency doubleValue];
            double y;
            if (frequency !=0) {
                  y = sqrt(2)*amplitude * sin(2*M_PI*frequency/1000*x + DEGREES_TO_RADIANS(phase));
            } else {
                y = amplitude;
            }
            [value addObject:[[ChartDataEntry alloc] initWithX:x y:y icon: nil]];
            
            if (y>_lineChartMaxValue_C) {
                _lineChartMaxValue_C = y;
            }
        }
        LineChartDataSet *set = nil;
        if (_CdataSets.count >= currentyvalues.count)
        {
            
            if ([currentyvalues[i]  isEqual: @(YES)]) {
                if (_waveDataModel.voltageArr.count!=0) {
                    set = (LineChartDataSet *)_waveShapeView.data.dataSets[voltageyvalues.count+i];
                } else {
                    set = (LineChartDataSet *)_waveShapeView.data.dataSets[i];
                }
                
                set.values = value;
                set.lineWidth = LineWidth;
                set.circleRadius = 2.0;
                [set setDrawValuesEnabled:YES];
            } else {
                if (_waveDataModel.voltageArr.count!=0) {
                    set = (LineChartDataSet *)_waveShapeView.data.dataSets[voltageyvalues.count+i];
                } else {
                    set = (LineChartDataSet *)_waveShapeView.data.dataSets[i];
                }
                set.values = value;
                set.lineWidth = 0.0;
                set.circleRadius = 0.0;
                [set setDrawValuesEnabled:NO];
                
            }
            [_waveShapeView.data notifyDataChanged];
            [_waveShapeView notifyDataSetChanged];
        } else {
            
            set = [[LineChartDataSet alloc] initWithValues:value label:[NSString stringWithFormat:@"DataSet %d", i + 1]];
            set.lineDashLengths = @[@5.0f, @2.5f];
            set.highlightLineDashLengths = @[@5.0f, @2.5f];
            [set setColor:lineColor[i]];
            [set setCircleColor:lineColor[i]];
            set.axisDependency = AxisDependencyRight;
            set.lineWidth = LineWidth;
            set.circleRadius = 2.0;
            set.drawCirclesEnabled = NO;
            set.mode = LineChartModeCubicBezier;
            [set setDrawVerticalHighlightIndicatorEnabled:NO];
            [set setDrawHorizontalHighlightIndicatorEnabled:NO];
            [_CdataSets addObject:set];
        }
    }
    
//    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
//    numberFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
//    numberFormatter.multiplier   = @0.1;
//    _waveShapeView.xAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc]initWithFormatter:numberFormatter];
    
   
    _data.dataSets = [_VdataSets arrayByAddingObjectsFromArray:_CdataSets];
      _waveShapeView.data = _data;
    
   
}

-(void)refreshLineChartView{
  
    //通过setdataCount方法，才能计算出最新的y轴最大值，所以修改y轴最大值的方法必须在setDataCount方法之后
    [self setDataCount:self.voltageSelectedArr currentyvalues:self.currentSelectedArr];
 
    
    
    if (_lineChartMaxValue_C<=20) {
        _lineChartMaxValue_C = 30;
    } else {
        _lineChartMaxValue_C = floor(_lineChartMaxValue_C)*1.5;
    }
    
    if (_lineChartMaxValue_V<=170) {
        _lineChartMaxValue_V = 200;
    } else {
        _lineChartMaxValue_V = floor(_lineChartMaxValue_V)*1.5;
    }
    self.waveShapeView.leftAxis.axisMaximum = _lineChartMaxValue_V;
    self.waveShapeView.leftAxis.axisMinimum = -_lineChartMaxValue_V;
    self.waveShapeView.rightAxis.axisMaximum = _lineChartMaxValue_C;
    self.waveShapeView.rightAxis.axisMinimum = -_lineChartMaxValue_C;
  
    [self.waveShapeView.data notifyDataChanged];
    [self.waveShapeView notifyDataSetChanged];
    [self.waveShapeView setNeedsDisplay];
    
    
    
}

//如果试验开始后，将波形图中的set清空，重新绘制
-(void)clearDataSet:(NSNotification *)noti{
    [_VdataSets removeAllObjects];
    [_CdataSets removeAllObjects];
    _data.dataSets = [_VdataSets arrayByAddingObjectsFromArray:_CdataSets];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
}
-(void)dealloc{
    [kNotificationCenter removeObserver:self name:BD_ManualTestBegin object:nil];
}

@end
