//
//  BD_QuickTestOscillographCell.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/18.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_QuickTestOscillographCell.h"
#import "BD_QuickTestBLVView.h"
#import "DateValueFormatter.h"
#define BottomBtnH ScaleSizeH(50)
#define LineWidth  1.0
#define GranularityTime 1.0

@interface BD_QuickTestOscillographCell()<ChartViewDelegate>{
   
//    NSTimeInterval lineChartFrom;
//    NSTimeInterval lineChartTo;
    int xminValue;
    BOOL isFirst;
    double _lineChartMaxValue_V;
    double _lineChartMinValue_V;
    double _lineChartMaxValue_X;
    int pageNum;
}
@property( nonatomic,strong) NSMutableArray *VdataSets;
@property( nonatomic,strong) NSMutableArray *CdataSets;
@property( nonatomic,strong)LineChartData *data;
@property( nonatomic,strong)NSMutableArray<BD_QuickTestBLVView *>*BLVViewArr;
@property(nonatomic,strong)CADisplayLink *linkManager;
@end

@implementation BD_QuickTestOscillographCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self configLineChart];
    self.backgroundColor = ClearColor;
//    self.contentView.backgroundColor = [UIColor colorWithRed:42.0/255.0 green:41.0/255.0 blue:42.0/255.0 alpha:1.0];
    self.contentView.backgroundColor = ClearColor;
  
    [self.bgView setCorenerRadius:2 borderColor:Black borderWidth:2.0];
    self.bgView.backgroundColor = [UIColor colorWithRed:42.0/255.0 green:41.0/255.0 blue:42.0/255.0 alpha:1.0];

    _voltageSelectedArr = [[NSMutableArray alloc]init];
    _currentSelectedArr = [[NSMutableArray alloc]init];
    _BLVViewArr = [[NSMutableArray alloc]init];
    pageNum = 1;
    
    
    [kNotificationCenter addObserver:self selector:@selector(clearDataSet:) name:BD_ManualTestBegin object:nil];
    
    self.linkManager = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateLineView)];
    [self.linkManager addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    // Initialization code
}

-(void)layoutSubviews{
    [super layoutSubviews];
  
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)configLineChart{

    
    _VdataSets = [[NSMutableArray alloc]init];
    _CdataSets = [[NSMutableArray alloc]init];
    _data = [[LineChartData alloc]init];
    _lineChartView.delegate = self;
    
    _lineChartView.chartDescription.enabled = NO;
    
    _lineChartView.dragEnabled = NO;
    [_lineChartView setScaleEnabled:NO];
    _lineChartView.pinchZoomEnabled = NO;
    _lineChartView.drawGridBackgroundEnabled = NO;
    _lineChartView.doubleTapToZoomEnabled = NO;
    _lineChartView.noDataFont = [UIFont systemFontOfSize:15.0];
    _lineChartView.noDataText = @"暂无试验数据";
    _lineChartView.noDataTextColor = White;

    
    
//    _lineChartView.xAxis.valueFormatter = [[DateValueFormatter alloc] init];
    
    _lineChartView.xAxis.gridLineDashLengths = @[@5.f,@5.f];
    _lineChartView.xAxis.gridLineDashPhase = 0.5f;
    _lineChartView.xAxis.labelTextColor = White;
    _lineChartView.xAxis.gridColor = White;
    _lineChartView.xAxis.labelPosition = XAxisLabelPositionBottom;
     _lineChartView.xAxis.drawAxisLineEnabled = YES;
     _lineChartView.xAxis.drawGridLinesEnabled = YES;
     _lineChartView.xAxis.centerAxisLabelsEnabled = NO;
//    [_lineChartView.xAxis setGranularity:GranularityTime];
    [_lineChartView.xAxis setLabelCount:5 force:NO];
    _lineChartView.xAxis.xOffset = 1.0;
    _lineChartView.xAxis.spaceMax = 1.0;
    
    ChartYAxis *leftAxis = _lineChartView.leftAxis;
    [leftAxis removeAllLimitLines];
    leftAxis.axisMaximum = _lineChartMaxValue_V;
    leftAxis.axisMinimum = _lineChartMinValue_V;
    leftAxis.gridLineDashLengths = @[@5.f, @5.f];
    leftAxis.drawZeroLineEnabled = YES;
    leftAxis.drawLimitLinesBehindDataEnabled = NO;
    leftAxis.labelTextColor = White;
    leftAxis.axisLineColor = White;
    leftAxis.gridColor = White;
    _lineChartView.rightAxis.enabled =NO;;
    _lineChartView.legend.form = ChartLegendFormLine;
    [_lineChartView.legend setEnabled:NO];

    
    
    [_data setDrawValues:NO];
   
    
    
   [self updateLoadLineData];
//    [_lineChartView animateWithXAxisDuration:0.5];
}

-(void)addBtnStateView{
    
}

#pragma mark - 定时刷新
-(void)updateLineView{
    WeakSelf;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(getRealData:)]) {
        [self.delegate getRealData:^{
            [weakself updateLoadLineData];
        }];
    }
    
}
#pragma mark - 刷新波形图数据
-(void)updateLoadLineData{
   
    //    self.getDataFromVCBlock();
    
    //
    //    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    //    NSTimeInterval hourSeconds = GranularityTime;
    //
    //    lineChartFrom = now - (10.0 / 2.0) * hourSeconds;
    //    lineChartTo = now + (10.0 / 2.0) * hourSeconds;
    _lineChartMaxValue_V = floor(_lineChartMaxValue_V)+30;
    if (_lineChartMinValue_V<0) {
        _lineChartMinValue_V = floor(_lineChartMinValue_V)-30;
    }
    _lineChartMaxValue_X = _lineChartMaxValue_X+10;
    self.lineChartView.leftAxis.axisMaximum = _lineChartMaxValue_V;
    self.lineChartView.xAxis.axisMaximum = _lineChartMaxValue_X;
    self.lineChartView.leftAxis.axisMinimum = _lineChartMinValue_V;
    [self setDataCount:[self.voltageSelectedArr copy] currentyvalues:[self.currentSelectedArr copy]];
   
    
    
    //    _lineChartView.xAxis.axisMinValue = lineChartFrom;
    //    _lineChartView.xAxis.axisMaxValue = lineChartTo;
    
    
    [_data setValueTextColor:White];
    //  [_data setValueFont:[UIFont systemFontOfSize:13.0]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.lineChartView.data notifyDataChanged];
        [self.lineChartView notifyDataSetChanged];
        [self.lineChartView setNeedsDisplay];
    });
    
}

- (void)setDataCount:(NSArray *)voltageyvalues currentyvalues:(NSArray *)currentyvalues
{
    _lineChartMaxValue_V = 0.0;
    _lineChartMinValue_V = 0.0;
    if (voltageyvalues.count == 0) {
        [_VdataSets removeAllObjects];
    } else if (currentyvalues.count == 0){
        [_CdataSets removeAllObjects];
    }
    NSArray<UIColor *> *lineColor;
    if (_voltageDataArr.count == 4) {
        lineColor= @[Yellow,Green,Red,[UIColor blueColor]];
    } else {
        lineColor= @[Yellow,Green,Red];
    }
    
    @autoreleasepool{
        for (int i = 0; i<_voltageDataArr.count; i++) {
            
            NSMutableArray *values = [[NSMutableArray alloc] init];
            
            NSArray *yArr = _voltageDataArr[i].model ;
            
            for (int x = 0+(int)_chartViewXMax-600; x < yArr.count+_chartViewXMax-600; x ++ )
            {
                double y;
                if (x>=600) {
                    
                    y = [yArr[x-_chartViewXMax+600] doubleValue];
                } else {
                    y = [yArr[x] doubleValue];
                }
                
                if (y>_lineChartMaxValue_V) {
                    _lineChartMaxValue_V = y;
                }
                if (y<_lineChartMinValue_V) {
                    _lineChartMinValue_V = y;
                }
                
                _lineChartMaxValue_X = _chartViewXMax;
                [values addObject:[[ChartDataEntry alloc] initWithX:x y:y icon: nil]];
          
            }
            
            LineChartDataSet *set1 = nil;
            if (_VdataSets.count>=voltageyvalues.count)
            {
                
                if ([voltageyvalues[i]  isEqual: @(YES)]) {
                    set1 = (LineChartDataSet *)_lineChartView.data.dataSets[i];
                    
                    set1.values = values;
                    set1.lineWidth = LineWidth;
                    set1.circleRadius = 0.0;
                    [set1 setDrawValuesEnabled:NO];
                    
                } else {
                    set1 = (LineChartDataSet *)_lineChartView.data.dataSets[i];
                    set1.values = values;
                    set1.lineWidth = 0.0;
                    set1.circleRadius = 0.0;
                    [set1 setDrawValuesEnabled:NO];
                }
                [_lineChartView.data notifyDataChanged];
                [_lineChartView notifyDataSetChanged];
            } else {
                
                set1 = [[LineChartDataSet alloc] initWithValues:values label:@"111"];
                
                set1.drawIconsEnabled = NO;
                set1.lineDashLengths = @[@1.0f, @0.0f];
                set1.highlightLineDashLengths = @[@1.0f, @0.0f];//至少有一个为非0
                
                [set1 setColor:_VdataSets.count!=3?lineColor[i]:[lineColor lastObject]];
                [set1 setCircleColor:_VdataSets.count!=3?lineColor[i]:[lineColor lastObject]];
                set1.lineWidth = LineWidth;
                set1.axisDependency = AxisDependencyLeft;
                set1.circleRadius = 0.0;
                set1.drawCircleHoleEnabled = NO;
                set1.drawValuesEnabled = NO;
                set1.drawSteppedEnabled = YES;
                [set1 setDrawVerticalHighlightIndicatorEnabled:NO];
                [set1 setDrawHorizontalHighlightIndicatorEnabled:NO];
                
                [_VdataSets addObject:set1];
            }
            
        }
    }
    
    _data.dataSets = [_VdataSets arrayByAddingObjectsFromArray:_CdataSets];
    _lineChartView.data = _data;
    
    @autoreleasepool{
        for (int i = 0; i<_currentDataArr.count; i++) {
            
            
            
            NSMutableArray *value = [[NSMutableArray alloc] init];
            
            {
                NSArray *yArr = _currentDataArr[i].model ;
                
                
                
                for (int x = 0+(int)_chartViewXMax-600; x < yArr.count+_chartViewXMax-600; x ++ )
                {
                    double y;
                    if (x>=600) {
                        
                        y = [yArr[x-_chartViewXMax+600] doubleValue];
                    } else {
                        y = [yArr[x] doubleValue];
                    }
                    
                    if (_voltageDataArr.count==0) {
                        if (y>_lineChartMaxValue_V) {
                            _lineChartMaxValue_V = y;
                        }
                        if (y<_lineChartMinValue_V) {
                            _lineChartMinValue_V = y;
                        }
                        
                        _lineChartMaxValue_X = _chartViewXMax;
                    }
                    [value addObject:[[ChartDataEntry alloc] initWithX:x y:y icon: nil]];
                    
                }
                
            }
            LineChartDataSet *set = nil;
            if (_CdataSets.count >= currentyvalues.count)
            {
                
                if ([currentyvalues[i]  isEqual: @(YES)]) {
                    
                    if (_voltageDataArr.count!=0) {
                        set = (LineChartDataSet *)_lineChartView.data.dataSets[voltageyvalues.count+i];
                    } else {
                        set = (LineChartDataSet *)_lineChartView.data.dataSets[i];
                    }
                    
                    set.values = value;
                    set.lineWidth = LineWidth;
                    set.circleRadius = 0.0;
                    [set setDrawValuesEnabled:NO];
                } else {
                    set = (LineChartDataSet *)_lineChartView.data.dataSets[_voltageDataArr.count+i];
                    set.values = value;
                    set.lineWidth = 0.0;
                    set.circleRadius = 0.0;
                    [set setDrawValuesEnabled:NO];
                    
                }
                [_lineChartView.data notifyDataChanged];
                [_lineChartView notifyDataSetChanged];
            } else {
                
                set = [[LineChartDataSet alloc] initWithValues:value label:[NSString stringWithFormat:@"DataSet %d", i + 1]];
                set.lineDashLengths = @[@5.0f, @2.5f];
                set.highlightLineDashLengths = @[@5.0f, @2.5f];
                [set setColor:lineColor[i]];
                [set setCircleColor:lineColor[i]];
                set.axisDependency = AxisDependencyLeft;
                set.lineWidth = LineWidth;
                set.circleRadius = 0.0;
                set.drawValuesEnabled = NO;
                [set setDrawVerticalHighlightIndicatorEnabled:NO];
                [set setDrawHorizontalHighlightIndicatorEnabled:NO];
                set.drawSteppedEnabled = YES;//是否梯度显示折线图
                [_CdataSets addObject:set];
            }
        }
    }
    
    
    _data.dataSets = [_VdataSets arrayByAddingObjectsFromArray:_CdataSets];
    _lineChartView.data = _data;
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
    numberFormatter.multiplier   = @0.05;
    _lineChartView.xAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc]initWithFormatter:numberFormatter];
    
}


//如果试验开始后，将波形图中的set清空，重新绘制
-(void)clearDataSet:(NSNotification *)noti{
    [_VdataSets removeAllObjects];
    [_CdataSets removeAllObjects];
    _data.dataSets = [_VdataSets arrayByAddingObjectsFromArray:_CdataSets];
}

#pragma mark - 懒加载
-(NSArray<NSString *> *)titleArr{
    if (!_titleArr) {
        _titleArr  = [[NSArray alloc]init];
    }
    return _titleArr;
}

-(void)setCellData{
    //默认全部绘制，用户取消某项，只绘制选择的项 每次点击完成后，刷新矢量图绘制，修改参数
    NSArray *colorarr;
    if ((_voltageDataArr.count+_currentDataArr.count)==7) {
        colorarr = @[Yellow,Green,Red,[UIColor blueColor],Yellow,Green,Red];
    } else {
        colorarr = @[Yellow,Green,Red,Yellow,Green,Red];
    }
    [self createSelectedView];
    for (int i = 0; i<_BLVViewArr.count; i++) {
        [_BLVViewArr[i] setData:[[_voltageSelectedArr arrayByAddingObjectsFromArray:_currentSelectedArr][i] boolValue] title:_titleArr[i] lineColor:colorarr[i]];
    }
    
    [self updateLoadLineData];
}

-(void)createSelectedView{
    
    for (UIView *view in self.contentView.subviews) {
        if ([view isKindOfClass:[BD_QuickTestBLVView class]]) {
            [view removeFromSuperview];
        }
    }
    [_BLVViewArr removeAllObjects];
    WeakSelf;
    NSInteger viewCount = _voltageDataArr.count+_currentDataArr.count;
    for (int i =0; i<_voltageDataArr.count+_currentDataArr.count;i++) {
        
        BD_QuickTestBLVView *blvBase = [[NSBundle mainBundle] loadNibNamed:@"BD_QuickTestBLVView" owner:nil options:nil].lastObject;
        blvBase.viewtag = i;
        blvBase.frame = CGRectMake(10+(self.width-20)/viewCount*i,self.height-60,(self.width-20)/viewCount, 50);
      
        
        [blvBase.blvBtn setSelected:[[_voltageSelectedArr arrayByAddingObjectsFromArray:_currentSelectedArr][i] boolValue]];
        
        blvBase.blvSelectedBlock = ^(int viewtag, BOOL btnState) {
            if (_voltageDataArr.count!=0&&_currentDataArr.count!=0) {
                if (i<viewCount-3) {
                    [weakself.voltageSelectedArr replaceObjectAtIndex:viewtag withObject:@(btnState)];
                } else {
                    [weakself.currentSelectedArr replaceObjectAtIndex:viewtag-(viewCount-3) withObject:@(btnState)];
                }
            } else if (_currentDataArr.count == 0){
                [weakself.voltageSelectedArr replaceObjectAtIndex:viewtag withObject:@(btnState)];
            } else if (_voltageDataArr.count == 0){
                [weakself.currentSelectedArr replaceObjectAtIndex:viewtag withObject:@(btnState)];
            }
            
            
            [weakself updateLoadLineData];
            weakself.cellLineStateBlock(weakself.voltageSelectedArr, weakself.currentSelectedArr);
        };
        
        [_BLVViewArr addObject:blvBase];
        [self.contentView addSubview:blvBase];
    }
}
-(void)cancelTimer{
    [_linkManager invalidate];
    _linkManager = nil;
}

-(void)dealloc{
    [kNotificationCenter removeObserver:self name:BD_ManualTestBegin object:nil];
}

@end
