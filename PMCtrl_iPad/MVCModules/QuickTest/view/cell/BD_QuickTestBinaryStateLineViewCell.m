//
//  BD_QuickTestBinaryStateLineViewCell.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/30.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_QuickTestBinaryStateLineViewCell.h"
#import "StringValueFormatter.h"
@interface BD_QuickTestBinaryStateLineViewCell()<ChartViewDelegate>
{
   
}
@property(nonatomic,weak)LineChartView *binaryChartView;
@property( nonatomic,strong)LineChartData *data;
@property (nonatomic,strong) CADisplayLink *link;
@end
@implementation BD_QuickTestBinaryStateLineViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
   
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = ClearColor;
        self.contentView.backgroundColor = ClearColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self createCellViews];
        
        _xvalue_max = 600;
    }
    return self;
}

-(void)createCellViews{
    
    UIView *bgView = [[UIView alloc]init];
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.left.and.right.mas_equalTo(10.0);
    }];
    
    [bgView setCorenerRadius:2 borderColor:Black borderWidth:2.0];
    bgView.backgroundColor = [UIColor colorWithRed:42.0/255.0 green:41.0/255.0 blue:42.0/255.0 alpha:1.0];

//    if (!_binaryView) {
//        _binaryView = [[BD_BinaryStateLineView alloc]init];
//        _binaryView.backgroundColor = ClearColor;
//        
//        [bgView addSubview:_binaryView];
//    }
//    
//    [_binaryView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.and.and.left.and.right.mas_equalTo(0.0);
//        make.bottom.mas_equalTo(-20);
//    }];
//    
//    _binaryView.statelineColor = [UIColor redColor];
//    _binaryView.coordinateColor = White;
//    _binaryView.xValuesColor = [UIColor greenColor];
//    _binaryView.xValues = [_xvalues copy];
//    _binaryView.binaryStateDataSource = [_binaryLineModels copy];
    
    WeakSelf;
    UILabel *label = [[UILabel alloc]init];
    label.text = @"时间(s)";
    label.font = [UIFont systemFontOfSize:11.0];
    label.textColor = White;
    label.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-20);
    }];
    
    
    if (!_binaryChartView) {
      LineChartView  *binaryChartView = [[LineChartView alloc]init];
        [bgView addSubview:binaryChartView];
        self.binaryChartView = binaryChartView;
        [_binaryChartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.and.and.left.mas_equalTo(10.0);
            make.right.mas_equalTo(-10.0);
            make.bottom.mas_equalTo(label.mas_top).offset(-10);
        }];
    }
    
    [self configLineChart];
    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateBinaryView)];
    [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(NSArray<NSMutableArray *> *)binaryStateValues{
    if (!_binaryStateValues) {
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        for (int i = 0; i<18; i++) {
            [arr addObject:[[NSMutableArray alloc]init]];
        }
        _binaryStateValues = [arr copy];
    }
    return _binaryStateValues;
}

-(void)configLineChart{

    _data = [[LineChartData alloc]init];
    _binaryChartView.delegate = self;
    
    _binaryChartView.chartDescription.enabled = NO;
    _binaryChartView.dragEnabled = NO;
    [_binaryChartView setScaleEnabled:NO];
    _binaryChartView.pinchZoomEnabled = NO;
    _binaryChartView.drawGridBackgroundEnabled = NO;
    _binaryChartView.doubleTapToZoomEnabled = NO;
    _binaryChartView.noDataFont = [UIFont systemFontOfSize:15.0];
    _binaryChartView.noDataText = @"暂无试验数据";
    _binaryChartView.noDataTextColor = White;
                                    
    //    _binaryChartView.xAxis.valueFormatter = [[DateValueFormatter alloc] init];
    
    _binaryChartView.xAxis.gridLineDashLengths = @[@5.f,@5.f];
    _binaryChartView.xAxis.gridLineDashPhase = 0.5f;
    _binaryChartView.xAxis.labelTextColor = White;
    _binaryChartView.xAxis.gridColor = White;
    _binaryChartView.xAxis.axisMaxValue = _xvalue_max;
    _binaryChartView.xAxis.axisMinValue = _xvalue_max-600;
    _binaryChartView.xAxis.labelPosition = XAxisLabelPositionBottom;
    _binaryChartView.xAxis.drawAxisLineEnabled = NO;
    _binaryChartView.xAxis.drawGridLinesEnabled = NO;
    _binaryChartView.xAxis.centerAxisLabelsEnabled = NO;
    _binaryChartView.xAxis.labelCount = 10;
    //    [_binaryChartView.xAxis setGranularity:GranularityTime];
    [_binaryChartView.xAxis setLabelCount:5 force:NO];
    _binaryChartView.xAxis.xOffset = 1.0;
    _binaryChartView.xAxis.spaceMax = 1.0;
    
    ChartYAxis *leftAxis = _binaryChartView.leftAxis;
    [leftAxis removeAllLimitLines];
    leftAxis.gridLineDashLengths = @[@5.f, @5.f];
    leftAxis.drawZeroLineEnabled = YES;
    leftAxis.drawLimitLinesBehindDataEnabled = NO;
    leftAxis.labelTextColor = White;
    leftAxis.axisLineColor = White;
    leftAxis.gridColor = White;
    leftAxis.axisMinValue = 0;
    leftAxis.axisMaxValue = 20;
    leftAxis.centerAxisLabelsEnabled = YES;
    leftAxis.valueFormatter = [[StringValueFormatter alloc]initWithArr:@[@"8",@"7",@"6",@"5",@"4",@"3",@"2",@"1",@"J",@"I",@"H",@"G",@"F",@"E",@"D",@"C",@"B",@"A"]];
    leftAxis.labelCount = 18;
    leftAxis.drawGridLinesEnabled = YES;
    _binaryChartView.rightAxis.enabled =NO;;
    _binaryChartView.legend.form = ChartLegendFormLine;
    [_binaryChartView.legend setEnabled:NO];

    [_data setDrawValues:NO];
    [self setlineChartDataCount:@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"] xrr:_binaryStateValues];
    //    [_binaryChartView animateWithXAxisDuration:0.5];
}


- (void)setlineChartDataCount:(NSArray *)yArr xrr:(NSArray *)xArr
{
    @autoreleasepool{
        if (_binaryChartView.data.dataSets.count!=0) {
            for (int i = 1; i<yArr.count+1; i++) {
                
                NSMutableArray *values = [[NSMutableArray alloc] init];
                NSMutableArray *xvalues = xArr[i-1];
                for (int x = (int)_xvalue_max-600; x < xvalues.count+_xvalue_max-600; x ++ )
                {
                    if (x>=600) {
                        if ([xvalues[x-_xvalue_max+600] intValue]==1) {
                            [values addObject:[[ChartDataEntry alloc] initWithX:x y:i+0.5 icon: nil]];
                        } else {
                            [values addObject:[[ChartDataEntry alloc] initWithX:x y:i icon: nil]];
                        }
                    } else {
                        if ([xvalues[x] intValue]==1) {
                            [values addObject:[[ChartDataEntry alloc] initWithX:x y:i+0.5 icon: nil]];
                        } else {
                            [values addObject:[[ChartDataEntry alloc] initWithX:x y:i icon: nil]];
                        }
                    }
                    
                }
          LineChartDataSet *set1 = (LineChartDataSet *)_binaryChartView.data.dataSets[i-1];
        set1.values = values;
            }
        } else {
            NSMutableArray *setArr = [[NSMutableArray alloc]init];
            for (int i = 1; i<yArr.count+1; i++) {
                
                NSMutableArray *values = [[NSMutableArray alloc] init];
                NSMutableArray *xvalues = xArr[i-1];
                for (int x = (int)_xvalue_max-600; x < xvalues.count+_xvalue_max-600; x ++ )
                {
                    if (x>=600) {
                        if ([xvalues[x-_xvalue_max+600] intValue]==1) {
                            [values addObject:[[ChartDataEntry alloc] initWithX:x y:i+0.5 icon: nil]];
                        } else {
                            [values addObject:[[ChartDataEntry alloc] initWithX:x y:i icon: nil]];
                        }
                    } else {
                        if ([xvalues[x] intValue]==1) {
                            [values addObject:[[ChartDataEntry alloc] initWithX:x y:i+0.5 icon: nil]];
                        } else {
                            [values addObject:[[ChartDataEntry alloc] initWithX:x y:i icon: nil]];
                        }
                    }
                    
                }
                
                LineChartDataSet *set1 = [[LineChartDataSet alloc] initWithValues:values label:@"111"];
                    set1.drawIconsEnabled = NO;
                    set1.lineDashLengths = @[@1.0f, @0.0f];
                    set1.highlightLineDashLengths = @[@1.0f, @0.0f];//至少有一个为非0
                    [set1 setColor:Green];
                    set1.lineWidth = 1.0;
                    set1.axisDependency = AxisDependencyLeft;
                    set1.circleRadius = 0.0;
                    set1.drawCircleHoleEnabled = NO;
                    set1.drawValuesEnabled = NO;
                    set1.drawSteppedEnabled = YES;
                    [set1 setDrawVerticalHighlightIndicatorEnabled:NO];
                    [set1 setDrawHorizontalHighlightIndicatorEnabled:NO];
                    [setArr addObject:set1];
 
                _data.dataSets = [setArr copy];
            }
        }
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
        numberFormatter.multiplier   = @0.05;
        _binaryChartView.xAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc]initWithFormatter:numberFormatter];
        
        _binaryChartView.data = _data;
        }

}
-(void)updateBinaryView{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setlineChartDataCount:@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"] xrr:_binaryStateValues];
        _binaryChartView.xAxis.axisMaxValue = _xvalue_max;
        _binaryChartView.xAxis.axisMinValue = _xvalue_max-600;
    });
    

}

-(void)cancelTimer{
    [_link invalidate];
    
    _link = nil;
}

//-(void)setLineData:(NSMutableArray<BD_BinaryStateViewModel *> *) data{
//   _binaryView.binaryStateDataSource = data;
//}
//
//-(void)setXvalues:(NSArray *)xvalues{
//    _xvalues = xvalues;
//    _binaryView.xValues = [_xvalues copy];
//
//}
@end
