//
//  BD_CharacteristicVC.m
//  PMCtrl_iOS
//
//  Created by 杨博宇 on 2017/7/10.
//  Copyright © 2017年 bodian. All rights reserved.
//

#import "BD_CharacteristicVC.h"
#import "BD_DifferentialTestResultModel.h"
#import "PMCtrl_iPad-Swift.h"
#import "PMCtrl_iPad-Bridging-Header.h"
#import "BD_DifferSetDataModel.h"
#import "BD_DifferentialTestItemModel.h"
#import "BD_DifferIrCaculateManager.h"
#define BottomBtnH ScaleSizeH(50)
#define LineWidth  1.0
#define LineSelectedWidth 3.0
@interface BD_CharacteristicVC ()<ChartViewDelegate>{
    float markViewPoint_Y;
    float markViewPoint_X;
    LineChartDataSet *currentLineChart;
    bool Selected_X;
    float lineChartY_Max;
    float lineChartX_Max;
    
    float errorDownRate;
    float errorUpRate;
    float harmStartX;
}

//特性曲线图
@property(nonatomic,weak)LineChartView *chartView;
@property(nonatomic,weak)UILabel *remark_XL;
@property(nonatomic,weak)UILabel *remark_YL;
@property( nonatomic,strong) NSMutableArray *dataSets;
@property( nonatomic,strong)LineChartData *data;
@property( nonatomic,strong)LineChartDataSet *markset;
@property( nonatomic,strong)NSArray *yvalueArr;
@property( nonatomic,strong)NSArray *xvalueArr;
@property( nonatomic,strong)NSArray *remarksy ;
@property( nonatomic,strong)NSArray *remarksx ;

@end

@implementation BD_CharacteristicVC

#pragma mark - view生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = MainBgColor;
    [self addLineChartView];
    
    
    [kNotificationCenter addObserver:self selector:@selector(refreshView:) name:BD_DifferTestResultNoti object:nil];
    
    errorDownRate = 0.95;
    errorUpRate = 1.05;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillLayoutSubviews{
    
}
-(void)viewDidLayoutSubviews{
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


#pragma mark - 懒加载
-(BD_DifferSetDataModel *)setData{
    if (!_setData) {
        _setData = [[BD_DifferSetDataModel alloc]init];
    }
    return _setData;
}

-(NSArray<BD_DifferentialTestItemParaModel *> *)testItemArr{
    if (!_testItemArr) {
        _testItemArr = [[NSArray alloc]init];
    }
    return _testItemArr;
}
-(NSMutableArray<UIImage *> *)characterImages{
    if (!_characterImages) {
        _characterImages = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"wifi"], nil];
    }
    return _characterImages;
}
#pragma mark - 添加特性曲线
-(void)addLineChartView{
    WeakSelf;
    LineChartView *chartView = [[LineChartView alloc]init];
    [self.view addSubview:chartView];
    [chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-30);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-10);
    }];
    self.chartView = chartView;
    
    UILabel *xlabel = [[UILabel alloc]init];
    xlabel.text = @"Ir(In)";
    xlabel.textColor = White;
    xlabel.font = [UIFont systemFontOfSize:18];
    xlabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:xlabel];
    [xlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakself.view.mas_centerX);
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(30);
    }];
    self.remark_XL = xlabel;
    
    UILabel *ylabel = [[UILabel alloc]init];
    ylabel.text = @"Id(In)";
    ylabel.textColor = White;
    ylabel.font = [UIFont systemFontOfSize:18];
    ylabel.transform = CGAffineTransformMakeRotation(-M_PI_2);
    ylabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:ylabel];
    [ylabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(-30);
        make.centerY.mas_equalTo(weakself.view.mas_centerY);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    self.remark_YL = ylabel;
    
}

#pragma mark - 配置特性曲线
-(void)configLineChart{
    _dataSets = [[NSMutableArray alloc]init];
    _data= [[LineChartData alloc] init];
    _markset = [[LineChartDataSet alloc]init];
    
    _chartView.delegate = self;
    _chartView.chartDescription.enabled = NO;
    _chartView.dragEnabled = YES;
    [_chartView setScaleEnabled:YES];
    _chartView.pinchZoomEnabled = YES;
    _chartView.drawGridBackgroundEnabled = NO;
    
    _chartView.xAxis.gridLineDashLengths = @[@10.0, @10.0];
    _chartView.xAxis.gridLineDashPhase = 0.5f;
    _chartView.xAxis.gridColor = White;
    _chartView.xAxis.labelTextColor = White;
    _chartView.xAxis.labelFont = [UIFont systemFontOfSize:13.0];
    _chartView.xAxis.labelPosition = XAxisLabelPositionBottom;//设置x轴数字的位置，是顶部还是底部
    _chartView.xAxis.axisMaximum = lineChartX_Max;
    //设置x轴样式，最少显示要1位整数
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
    numberFormatter.minimumIntegerDigits = 1;
    _chartView.xAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc]initWithFormatter:numberFormatter];
    
    
    
    ChartYAxis *leftAxis = _chartView.leftAxis;
    [leftAxis removeAllLimitLines];
    leftAxis.axisMaximum = lineChartY_Max;
    leftAxis.axisMinimum = 0.0;
    leftAxis.gridLineDashLengths = @[@5.f, @5.f];
    leftAxis.drawZeroLineEnabled = YES;
    leftAxis.drawLimitLinesBehindDataEnabled = NO;
    leftAxis.labelTextColor = White;
    leftAxis.axisLineColor = White;
    leftAxis.gridColor = White;
    leftAxis.labelFont = [UIFont systemFontOfSize:13.0];
    NSNumberFormatter *numberFormatter_y = [[NSNumberFormatter alloc] init];
    numberFormatter_y.numberStyle = kCFNumberFormatterDecimalStyle;
    numberFormatter_y.minimumIntegerDigits = 1;
    numberFormatter.maximumFractionDigits = 1;
    leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc]initWithFormatter:numberFormatter_y];
    
    _chartView.rightAxis.enabled = NO;
    
    _chartView.legend.form = ChartLegendFormLine;
    [_chartView.legend setEnabled:NO];
    
    
    
    if ([BD_DifferIrCaculateManager shared].currentTestItemType == DifferTestItemType_ActionTime) {
        [self updateActionTimeChartData];
    } else if ([BD_DifferIrCaculateManager shared].currentTestItemType == DifferTestItemType_HarmonicRation){
        [self updateHarmChartData];
    } else {
        if (self.testItemArr.count!=0 && self.testItemArr) {
            markViewPoint_X = [self.testItemArr[0].Ir floatValue];
            markViewPoint_Y = 0.0;
        }
        
        [self updateQDChartData];
    }
    
    [_chartView animateWithXAxisDuration:0.5];
}


#pragma mark notification方法
- (void)refreshView:(NSNotification *)info{
    //刷新页面特性曲线图
    
    BD_DifferentialTestResult *result = (BD_DifferentialTestResult *)info.object;
    
    
    switch (result.itemType) {
        case DifferTestItemType_QDCurrent:
        {
            bool isEnd = result.oQdcurrent.bEnd;
            NSLog(@"%d",result.oQdcurrent.iIndex);
            NSLog(@"%d",result.oQdcurrent.nibinstate);
            if (isEnd) {
                
                [self markViewOnStanderLineWithyValue:result.oQdcurrent.Id xvalue:[self.testItemArr[result.oQdcurrent.iIndex-1].Ir floatValue]];
            } else {
                [self moveViewOnStanderLine:[self.testItemArr[result.oQdcurrent.iIndex-1].Ir floatValue] yvalue:result.oQdcurrent.Id];
                NSLog(@"正确");
            }
        }
            
            break;
        case DifferTestItemType_ZDRatio:
        {
            
            
            bool isEnd = result.oZDRatio.bEnd;
            NSLog(@"%d",result.oZDRatio.iIndex);
            NSLog(@"%d",result.oZDRatio.nibinstate);
            if (isEnd) {
                
                
                [self markViewOnStanderLineWithyValue:result.oZDRatio.Id xvalue:[self.testItemArr[result.oZDRatio.iIndex-1].Ir floatValue]];
                
            } else {
                [self moveViewOnStanderLine:[self.testItemArr[result.oZDRatio.iIndex-1].Ir floatValue] yvalue:result.oZDRatio.Id];
            }
            
        }
            
            break;
        case DifferTestItemType_SDCurrent:
        {
            bool isend = result.oQdcurrent.bEnd;
            NSLog(@"%d",result.oQdcurrent.iIndex);
            if (isend) {
                
                [self markViewOnStanderLineWithyValue:result.oQdcurrent.Id xvalue:[self.testItemArr[result.oQdcurrent.iIndex-1].Ir floatValue]];
                dispatch_async(dispatch_get_main_queue(), ^{
                  [self.characterImages addObject:[self.view saveToImage]];
                });
                
            } else {
                [self moveViewOnStanderLine:[self.testItemArr[result.oQdcurrent.iIndex-1].Ir floatValue] yvalue:result.oQdcurrent.Id];
            }
        }
            break;
        case DifferTestItemType_HarmonicRation:
        {
            //显示谐波制动特性曲线图
            _currentTestItem = result.oHarmnonicRatio.iIndex-1;
            [self  updateHarmChartData];
            
            bool isend = result.oHarmnonicRatio.bEnd;
            NSLog(@"%d",result.oHarmnonicRatio.iIndex);
            if (isend) {
                
                [self markViewOnStanderLineWithyValue:[self.testItemArr[result.oHarmnonicRatio.iIndex-1].Id floatValue] xvalue:result.oHarmnonicRatio.K];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.characterImages addObject:[self.view saveToImage]];
                });
            } else {
                [self moveViewOnStanderLine:result.oHarmnonicRatio.K yvalue:[self.testItemArr[result.oHarmnonicRatio.iIndex-1].Id floatValue]];
            }
            
        }
            break;
            
        case DifferTestItemType_ActionTime:
        {
            //显示动作时间特性曲线图
            [self  updateActionTimeChartData];
            bool isend = result.oActionTime.bEnd;
            NSLog(@"%d",result.oActionTime.iIndex);
            if (isend) {
                
                [self markViewOnStanderLineWithyValue:result.oActionTime.fId xvalue:[self.testItemArr[result.oActionTime.iIndex-1].Ir floatValue]];\
                
                dispatch_async(dispatch_get_main_queue(), ^{
                   [self.characterImages addObject:[self.view saveToImage]];
                });
            } else {
                [self moveViewOnStanderLine:[self.testItemArr[result.oActionTime.iIndex-1].Ir floatValue] yvalue:result.oActionTime.fId];
            }
        }
            break;
        case DifferTestItemType_Other:
        {
            
        }
            break;
        default:
            break;
    }
    
}

//恢复初始设置
#pragma Mark - 需要可以恢复初始设置
-(void)markViewDefaults{
    //    if (_dataSets.count == 13) {
    //        for (int  i = 1; i<5; i++) {
    //            [_dataSets removeObjectAtIndex:_dataSets.count-i];
    //        }
    //        _data.dataSets = _dataSets;
    //        [_chartView setNeedsDisplay];
    //    } else if(_dataSets.count == 15) {
    //        for (int  i = 1; i<7; i++) {
    //            [_dataSets removeObjectAtIndex:_dataSets.count-i];
    //        }
    //        _data.dataSets = _dataSets;
    //        [_chartView setNeedsDisplay];
    //    }
    
}

#pragma mark - 设置chartView数据
//启动电流 比率制动系数特性曲线图数据
- (void)updateQDChartData
{
    
    if (self.setData.KneePoint == 1) {
        float x1 = self.setData.Ip1;//拐点1电流
        float b1 = self.setData.Icdqd;//电流门槛值
        float k1 = self.setData.Kid1;//启动电流斜率
        float x1_y = k1*x1+b1;//拐点1y值
        float k2 = self.setData.Kid2;//基波比率制动特性斜率1
        float y2 = self.setData.Isd;//速断电流定值
        float x2 = (y2-x1_y)/k2+x1;
        lineChartX_Max = x2*2;
        lineChartY_Max = y2*2;
        _xvalueArr = @[@(0.0),@(x1),@(x2),@(lineChartX_Max)];//x和y必须对应上，个数必须相同，否则闪退
        NSMutableArray *yarr = [[NSMutableArray alloc]init];
        NSMutableArray *xarr = [[NSMutableArray alloc]init];
        for (BD_DifferentialTestItemParaModel *para in self.testItemArr) {
            if (para.itemType != DifferTestItemType_ActionTime && para.itemType != DifferTestItemType_HarmonicRation ) {
                [yarr addObject:@[@([para.fDown floatValue]),@([para.fUp floatValue])]];
                [xarr addObject:@[@([para.Ir floatValue]),@([para.Ir floatValue])]];
            }
        }
        _remarksy = [yarr copy];
        _remarksx = [xarr copy];
        
        NSArray *defaults = @[@(b1),@(x1_y),@(y2),@(y2)];
        NSArray *defaults_up = [self valueWithArr:defaults rate:errorUpRate];
        NSArray *defaults_down = [self valueWithArr:defaults rate:errorDownRate];
        _yvalueArr = @[defaults,defaults_up,defaults_down];
        
    } else if (self.setData.KneePoint == 2)  {
        float x1 = (float)self.setData.Ip1;//拐点1电流
        float b1 = (float)self.setData.Icdqd;//电流门槛值
        float k1 = (float)self.setData.Kid1;//启动电流斜率
        float k2 = (float)self.setData.Kid2;//基波比率制动特性斜率1
        float k3 = (float)self.setData.Kid3;//基波比率制动特性斜率2
        float x2 = (float)self.setData.Ip2;//拐点2电流
        float y4 = (float)self.setData.Isd;//速断电流
        
        float x1_y = k1*x1+b1;
        
        float x2_y = k2*(x2-x1)+x1_y;
        float x3 = (y4-x2_y)/k3 + x2;
        lineChartX_Max = x3*2;
        lineChartY_Max = y4*2;
        _xvalueArr = @[@(0.0),@(x1),@(x2),@(x3),@(lineChartX_Max)];
        
        NSMutableArray *yarr = [[NSMutableArray alloc]init];
        NSMutableArray *xarr = [[NSMutableArray alloc]init];
        for (BD_DifferentialTestItemParaModel *para in self.testItemArr) {
            if (para.itemType != DifferTestItemType_ActionTime && para.itemType != DifferTestItemType_HarmonicRation ) {
                [yarr addObject:@[@([para.fDown floatValue]),@([para.fUp floatValue])]];
                [xarr addObject:@[@([para.Ir floatValue]),@([para.Ir floatValue])]];
            }
        }
        _remarksy = [yarr copy];
        _remarksx = [xarr copy];
        
        NSArray *defaults = @[@(b1),@(x1_y),@(x2_y),@(y4),@(y4)];
        NSArray *defaults_up = [self valueWithArr:defaults rate:errorUpRate];
        NSArray *defaults_down = [self valueWithArr:defaults rate:errorDownRate];
        _yvalueArr = @[defaults,defaults_up,defaults_down];
        
        
    } else {
        float x1 = (float)self.setData.Ip1;//拐点1电流
        float b1 = (float)self.setData.Icdqd;//电流门槛值
        float k1 = (float)self.setData.Kid1;//启动电流斜率
        float k2 = (float)self.setData.Kid2;//基波比率制动特性斜率1
        float k3 = (float)self.setData.Kid3;//基波比率制动特性斜率2
        float k4 = (float)self.setData.Kid4;//速断电流斜率
        float x2 = (float)self.setData.Ip2;//拐点2电流
        float x3 = (float)self.setData.Ip3;//拐点电流
        float y5 = (float)self.setData.Isd;//速断电流
        
        float x1_y = k1*x1+b1;
        float x2_y = k2*(x2-x1)+x1_y;
        float x3_y = k3*(x3-x2)+x2_y;
        float x4 = (y5-x3_y)/k4 + x3;
        
        lineChartX_Max = x4*2;
        lineChartY_Max = y5*2;
        _xvalueArr = @[@(0.0),@(x1),@(x2),@(x3),@(x4),@(lineChartX_Max)];
        
        NSMutableArray *yarr = [[NSMutableArray alloc]init];
        NSMutableArray *xarr = [[NSMutableArray alloc]init];
        for (BD_DifferentialTestItemParaModel *para in self.testItemArr) {
            if (para.itemType != DifferTestItemType_ActionTime && para.itemType != DifferTestItemType_HarmonicRation ) {
                [yarr addObject:@[@([para.fDown floatValue]),@([para.fUp floatValue])]];
                [xarr addObject:@[@([para.Ir floatValue]),@([para.Ir floatValue])]];
            }
        }
        _remarksy = [yarr copy];
        _remarksx = [xarr copy];
        
        NSArray *defaults = @[@(b1),@(x1_y),@(x2_y),@(x3_y),@(y5),@(y5)];
        NSArray *defaults_up = [self valueWithArr:defaults rate:errorUpRate];
        NSArray *defaults_down = [self valueWithArr:defaults rate:errorDownRate];
        _yvalueArr = @[defaults,defaults_up,defaults_down];
        
    }
    
    
    
    [self setDataCount:_yvalueArr range:_xvalueArr remarkLineY:_remarksy remarkLineX:_remarksx];
    
    [self setmarkview:markViewPoint_Y range:markViewPoint_X];
    
    self.chartView.xAxis.axisMaximum = lineChartX_Max;
    self.chartView.leftAxis.axisMaximum = lineChartY_Max;
    _data.dataSets = _dataSets;
    _chartView.data = _data;
    [self.chartView setNeedsDisplay];
    if (_setData.Axis==0) {
        _remark_XL.text = @"Ir(A)";
        _remark_YL.text = @"Id(A)";
    } else{
        _remark_XL.text = @"Ir(In)";
        _remark_YL.text = @"Id(In)";
    }
   
    
}

//配置谐波测试特性曲线图
- (void)updateHarmChartData
{
    WeakSelf;
    
    
    BD_DifferentialTestItemParaModel *obj  = self.testItemArr[self.currentTestItem];
    if (obj.itemType == DifferTestItemType_HarmonicRation) {
        lineChartY_Max = [obj.Id floatValue]*2;
        NSArray *xvalues = @[@(obj.searchStart.floatValue/100),@(obj.searchEnd.floatValue/100)];
        NSArray *yvalues = @[@([obj.Id floatValue]),@([obj.Id floatValue])];
        [weakself setHarmDataCount:yvalues range:xvalues];
        markViewPoint_Y = [obj.Id floatValue];
        harmStartX = obj.searchStart.floatValue/100;
        
    }
    
    [self setmarkview:markViewPoint_Y range:harmStartX];
    
    self.chartView.xAxis.axisMinimum = 0.0;
    self.chartView.xAxis.axisMaximum = 1.0;
    self.chartView.leftAxis.axisMaximum = lineChartY_Max;
    _data.dataSets = _dataSets;
    _chartView.data = _data;
    [self.chartView setNeedsDisplay];
    if (_setData.Axis==0) {
        _remark_XL.text = @"Kr";
        _remark_YL.text = @"Id(A)";
    } else {
        _remark_XL.text = @"Kr";
        _remark_YL.text = @"Id(In)";
    }
    
    
}

//配置动作时间特性曲线图
- (void)updateActionTimeChartData
{
    if (self.setData.KneePoint == 1) {
        float x1 = self.setData.Ip1;//拐点1电流
        float b1 = self.setData.Icdqd;//电流门槛值
        float k1 = self.setData.Kid1;//启动电流斜率
        float x1_y = k1*x1+b1;//拐点1y值
        float k2 = self.setData.Kid2;//基波比率制动特性斜率1
        float y2 = self.setData.Isd;//速断电流定值
        float x2 = (y2-x1_y)/k2+x1;
        lineChartX_Max = x2*2;
        lineChartY_Max = y2*2;
        _xvalueArr = @[@(0.0),@(x1),@(x2),@(lineChartX_Max)];//x和y必须对应上，个数必须相同，否则闪退
        
        NSArray *defaults = @[@(b1),@(x1_y),@(y2),@(y2)];
        NSArray *defaults_up = [self valueWithArr:defaults rate:errorUpRate];
        NSArray *defaults_down = [self valueWithArr:defaults rate:errorDownRate];
        _yvalueArr = @[defaults,defaults_up,defaults_down];
        
    } else if (self.setData.KneePoint == 2)  {
        float x1 = (float)self.setData.Ip1;//拐点1电流
        float b1 = (float)self.setData.Icdqd;//电流门槛值
        float k1 = (float)self.setData.Kid1;//启动电流斜率
        float k2 = (float)self.setData.Kid2;//基波比率制动特性斜率1
        float k3 = (float)self.setData.Kid3;//基波比率制动特性斜率2
        float x2 = (float)self.setData.Ip2;//拐点2电流
        float y4 = (float)self.setData.Isd;//速断电流
        
        float x1_y = k1*x1+b1;
        
        float x2_y = k2*(x2-x1)+x1_y;
        float x3 = (y4-x2_y)/k3 + x2;
        lineChartX_Max = x3*2;
        lineChartY_Max = y4*2;
        _xvalueArr = @[@(0.0),@(x1),@(x2),@(x3),@(lineChartX_Max)];
        
        
        NSArray *defaults = @[@(b1),@(x1_y),@(x2_y),@(y4),@(y4)];
        NSArray *defaults_up = [self valueWithArr:defaults rate:errorUpRate];
        NSArray *defaults_down = [self valueWithArr:defaults rate:errorDownRate];
        _yvalueArr = @[defaults,defaults_up,defaults_down];
        
        
    } else {
        float x1 = (float)self.setData.Ip1;//拐点1电流
        float b1 = (float)self.setData.Icdqd;//电流门槛值
        float k1 = (float)self.setData.Kid1;//启动电流斜率
        float k2 = (float)self.setData.Kid2;//基波比率制动特性斜率1
        float k3 = (float)self.setData.Kid3;//基波比率制动特性斜率2
        float k4 = (float)self.setData.Kid4;//速断电流斜率
        float x2 = (float)self.setData.Ip2;//拐点2电流
        float x3 = (float)self.setData.Ip3;//拐点电流
        float y5 = (float)self.setData.Isd;//速断电流
        
        float x1_y = k1*x1+b1;
        float x2_y = k2*(x2-x1)+x1_y;
        float x3_y = k3*(x3-x2)+x2_y;
        float x4 = (y5-x3_y)/k4 + x3;
        
        lineChartX_Max = x4*2;
        lineChartY_Max = y5*2;
        _xvalueArr = @[@(0.0),@(x1),@(x2),@(x3),@(x4),@(lineChartX_Max)];
        
        NSArray *defaults = @[@(b1),@(x1_y),@(x2_y),@(x3_y),@(y5),@(y5)];
        NSArray *defaults_up = [self valueWithArr:defaults rate:errorUpRate];
        NSArray *defaults_down = [self valueWithArr:defaults rate:errorDownRate];
        _yvalueArr = @[defaults,defaults_up,defaults_down];
        
    }
    
    WeakSelf;
    [self.testItemArr enumerateObjectsUsingBlock:^(BD_DifferentialTestItemParaModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.itemType == DifferTestItemType_ActionTime) {
            [weakself setActionTimeDataCount:weakself.yvalueArr range:weakself.xvalueArr actionY:[obj.Id floatValue] actionX:[obj.Ir floatValue]];
        }
    }];
    self.chartView.xAxis.axisMaximum = lineChartX_Max;
    self.chartView.leftAxis.axisMaximum = lineChartY_Max;
    _data.dataSets = _dataSets;
    _chartView.data = _data;
    [self.chartView setNeedsDisplay];
    if (_setData.Axis == 0) {
        _remark_XL.text = @"Ir(A)";
        _remark_YL.text = @"Id(A)";
    } else {
        _remark_XL.text = @"Ir(In)";
        _remark_YL.text = @"Id(In)";
    }
    
    
}

-(void)updateMarkViewWithTestItemIndex:(NSInteger)index{
    [self moveViewOnStanderLine:[self.testItemArr[index].Ir floatValue] yvalue:0.0];
}
- (void)setDataCount:(NSArray *)yvalues range:(NSArray *)xvalues remarkLineY:(NSArray *)remarksy remarkLineX:(NSArray *)remarksx
{
    [_dataSets removeAllObjects];
    for (int i = 0; i<yvalues.count; i++) {
        
        NSMutableArray *values = [[NSMutableArray alloc] init];
        
        for (int n = 0; n < ((NSArray *)yvalues[i]).count; n++)
        {
            float val = [yvalues[i][n] floatValue];;
            [values addObject:[[ChartDataEntry alloc] initWithX:[xvalues[n] floatValue] y:val icon: [UIImage imageNamed:@"icon"]]];
        }
        
        LineChartDataSet *set1 = nil;
        
        set1 = [[LineChartDataSet alloc] initWithValues:values label:@""];
        
        set1.drawIconsEnabled = NO;
        if (i == 0) {
            set1.lineDashLengths = @[@0.0f, @0.0f];
            set1.highlightLineDashLengths = @[@0.0f, @0.0f];
        } else {
            set1.lineDashLengths = @[@5.0f, @2.5f];
            set1.highlightLineDashLengths = @[@5.0f, @2.5f];
        }
        
        
        [set1 setColor:UIColor.greenColor];
        
        [set1 setCircleColor:UIColor.greenColor];
        set1.lineWidth = LineWidth;
        set1.valueTextColor = White;
        set1.circleRadius = 0.0;
        set1.drawCircleHoleEnabled = NO;
        [set1 setDrawValuesEnabled:NO];
        [set1 setDrawVerticalHighlightIndicatorEnabled:NO];
        [set1 setDrawHorizontalHighlightIndicatorEnabled:NO];
        [_dataSets addObject:set1];
        //  set1.valueFont = [UIFont systemFontOfSize:9.f];
        ////    set1.formLineDashLengths = @[@0.f, @0.0f];
        ////    set1.formLineWidth = 1.0;
        ////    set1.formSize = 15.0;
        
        //    NSArray *gradientColors = @[
        //                                    (id)[ChartColorTemplates colorFromString:@"#00ff0000"].CGColor,
        //                                    (id)[ChartColorTemplates colorFromString:@"#ffff0000"].CGColor
        //                                    ];
        //    CGGradientRef gradient = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
        //
        //    set1.fillAlpha = 1.f;
        //    set1.fill = [ChartFill fillWithLinearGradient:gradient angle:90.f];
        //    set1.drawFilledEnabled = NO;//设置是否有填充线
        //
        //    CGGradientRelease(gradient);
        
    }
    
    for (int i = 0; i<remarksy.count; i++) {
        
        NSMutableArray *value = [[NSMutableArray alloc] init];
        
        for (int n = 0; n < ((NSArray *)remarksy[i]).count; n++)
        {
            float val = [remarksy[i][n] floatValue];;
            [value addObject:[[ChartDataEntry alloc] initWithX:[remarksx[i][n] floatValue] y:val icon: nil]];
        }
        
        LineChartDataSet *set = [[LineChartDataSet alloc] initWithValues:value label:[NSString stringWithFormat:@"DataSet %d", i + 1]];
        
        
        
        set.lineDashLengths = @[@5.0f, @2.5f];
        set.highlightLineDashLengths = @[@5.0f, @2.5f];
        [set setColor:UIColor.redColor];
        [set setCircleColor:UIColor.redColor];
        set.lineWidth = LineWidth;
        set.circleRadius = 0.0;
        set.valueTextColor = White;
        [set setDrawValuesEnabled:NO];
        [set setDrawVerticalHighlightIndicatorEnabled:NO];
        [set setDrawHorizontalHighlightIndicatorEnabled:NO];
        //        set.drawCircleHoleEnabled = YES;
        
        
        //        set.valueFont = [UIFont systemFontOfSize:9.f];
        //        set.formLineDashLengths = @[@5.f, @2.5f];
        //        set.formLineWidth = 1.0;
        //        set.formSize = 15.0;
        [_dataSets addObject:set];
    }
    
}


- (void)setHarmDataCount:(NSArray *)yvalues range:(NSArray *)xvalues
{
    [_dataSets removeAllObjects];
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    for (int n = 0; n < yvalues.count; n++)
    {
        float val = [yvalues[n] floatValue];;
        [values addObject:[[ChartDataEntry alloc] initWithX:[xvalues[n] floatValue] y:val icon: [UIImage imageNamed:@"icon"]]];
    }
    
    LineChartDataSet *set1 = nil;
    
    set1 = [[LineChartDataSet alloc] initWithValues:values label:@""];
    set1.drawIconsEnabled = NO;
    set1.lineDashLengths = @[@5.0f, @2.5f];
    set1.highlightLineDashLengths = @[@5.0f, @2.5f];
    [set1 setColor:Red];
    [set1 setCircleColor:Red];
    set1.lineWidth = LineWidth*2;
    set1.valueTextColor = White;
    set1.circleRadius = 0.0;
    set1.drawCircleHoleEnabled = NO;
    set1.drawValuesEnabled = NO;
    [set1 setDrawVerticalHighlightIndicatorEnabled:NO];
    [set1 setDrawHorizontalHighlightIndicatorEnabled:NO];
    [_dataSets addObject:set1];
    
}

- (void)setActionTimeDataCount:(NSArray *)yvalues range:(NSArray *)xvalues actionY:(float)actiony actionX:(float)actionx
{
    [_dataSets removeAllObjects];
    for (int i = 0; i<yvalues.count; i++) {
        
        NSMutableArray *values = [[NSMutableArray alloc] init];
        
        for (int n = 0; n < ((NSArray *)yvalues[i]).count; n++)
        {
            float val = [yvalues[i][n] floatValue];;
            [values addObject:[[ChartDataEntry alloc] initWithX:[xvalues[n] floatValue] y:val icon: [UIImage imageNamed:@"icon"]]];
        }
        
        LineChartDataSet *set1 = nil;
        
        set1 = [[LineChartDataSet alloc] initWithValues:values label:@""];
        
        set1.drawIconsEnabled = NO;
        if (i == 0) {
            set1.lineDashLengths = @[@0.0f, @0.0f];
            set1.highlightLineDashLengths = @[@0.0f, @0.0f];
        } else {
            set1.lineDashLengths = @[@5.0f, @2.5f];
            set1.highlightLineDashLengths = @[@5.0f, @2.5f];
        }
        [set1 setColor:UIColor.greenColor];
        [set1 setCircleColor:UIColor.greenColor];
        set1.lineWidth = LineWidth;
        set1.valueTextColor = White;
        set1.circleRadius = 0.0;
        set1.drawCircleHoleEnabled = NO;
        [set1 setDrawValuesEnabled:NO];
        [set1 setDrawVerticalHighlightIndicatorEnabled:NO];
        [set1 setDrawHorizontalHighlightIndicatorEnabled:NO];
        [_dataSets addObject:set1];
        
    }
    
    LineChartDataSet *set = nil;
    NSMutableArray *value = [[NSMutableArray alloc] init];
    [value addObject:[[ChartDataEntry alloc] initWithX:actionx y:actiony icon: nil]];
    
    set = [[LineChartDataSet alloc] initWithValues:value label:@""];
    
    set.lineDashLengths = @[@5.0f, @2.5f];
    
    set.highlightLineDashLengths = @[@5.0f, @2.5f];
    [set setColor:UIColor.redColor];
    [set setCircleColor:UIColor.redColor];
    set.lineWidth = 3.0;
    set.circleRadius = 5.0;
    [set setDrawValuesEnabled:NO];
    [set setDrawVerticalHighlightIndicatorEnabled:NO];//不显示垂直黄色高亮线
    [set setDrawHorizontalHighlightIndicatorEnabled:NO];//不显示水平黄色高亮线
    [_dataSets addObject:set];
    
}


- (void)setmarkview:(float)yvalues range:(float)xvalues
{
    
    NSMutableArray *value = [[NSMutableArray alloc] init];
    [value addObject:[[ChartDataEntry alloc] initWithX:xvalues y:yvalues icon: nil]];
    
    _markset.values  = value;
    [_markset setDrawValuesEnabled:NO];
    _markset.lineDashLengths = @[@5.0f, @2.5f];
    
    _markset.highlightLineDashLengths = @[@5.0f, @2.5f];
    [_markset setColor:UIColor.redColor];
    [_markset setCircleColor:UIColor.redColor];
    _markset.lineWidth = 3.0;
    _markset.circleRadius = 5.0;
    [_markset setDrawVerticalHighlightIndicatorEnabled:NO];//不显示垂直黄色高亮线
    [_markset setDrawHorizontalHighlightIndicatorEnabled:NO];//不显示水平黄色高亮线
    [_dataSets addObject:_markset];
    
}

- (void)addMarkView:(float)yvalues range:(float)xvalues
{
    
    
    LineChartDataSet *testset = [[LineChartDataSet alloc]init];
    NSMutableArray *value = [[NSMutableArray alloc] init];
    [value addObject:[[ChartDataEntry alloc] initWithX:xvalues y:yvalues icon: nil]];
    testset.values = value;
    
    
    testset.lineDashLengths = @[@5.0f, @2.5f];
    
    testset.highlightLineDashLengths = @[@5.0f, @2.5f];
    [testset setColor:UIColor.redColor];
    [testset setCircleColor:UIColor.yellowColor];
    
    testset.lineWidth = 3.0;
    testset.circleRadius = 5.0;
    [testset setDrawValuesEnabled:NO];
    [testset setDrawVerticalHighlightIndicatorEnabled:NO];//不显示垂直黄色高亮线
    [testset setDrawHorizontalHighlightIndicatorEnabled:NO];//不显示水平黄色高亮线
    [_dataSets addObject:testset];
    
    
    
}


#pragma mark - 根据返回值移动表识点
-(void)moveViewOnStanderLine:(float)xvalue yvalue:(float)yvalue{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableArray *value = [[NSMutableArray alloc] init];
        [value addObject:[[ChartDataEntry alloc] initWithX:xvalue y:yvalue icon: nil]];
        _markset.values = value;
        [_chartView setNeedsDisplay];
    });
    
}

-(void)markViewOnStanderLineWithyValue:(float)yvalue xvalue:(float)xvalue{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self addMarkView:yvalue range:xvalue];
        LineChartDataSet *set = [_dataSets objectAtIndex:_dataSets.count-1];
        NSMutableArray *value = [[NSMutableArray alloc] init];
        [value addObject:[[ChartDataEntry alloc] initWithX:xvalue y:yvalue icon: nil]];
        set.values = value;
        _data.dataSets = _dataSets;
        [_chartView setNeedsDisplay];
    });
    
}

-(void)changeErrorRate:(CGFloat)downRate upRate:(CGFloat)upRate{
    errorDownRate = downRate;
    errorUpRate = upRate;
}

#pragma mark - 点击屏幕，获取当前的触摸点位置
/*
 */
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    CGPoint point = [[[touches allObjects] lastObject] locationInView:self.view];
////   ChartDataEntry *touchEntry = [_chartView getEntryByTouchPointWithPoint:point];
//    CGPoint touchpoint = [_chartView valueForTouchPointWithPoint:point axis:AxisDependencyLeft];
//    NSLog(@"触摸点x:%.5f 触摸点y:%.5f",touchpoint.x,touchpoint.y);
//    
//  
//   
//    float x = touchpoint.x;
//   
//    float y;
//    
////    currentLineChart = (LineChartDataSet *)[_chartView getDataSetByTouchPointWithPoint:point];
//
//    
//    if (![_chartView.layer containsPoint:point]) {
//        currentLineChart.lineWidth = LineWidth;
//        currentLineChart = nil;
//        
//    }else {
//        if (!Selected_X) {
//            if ((int)x == (int)Singleton.qdCurrent) {
//                currentLineChart = _dataSets[3];
//                
//                
//            } else if ((int)x == (int)Singleton.ratio1Ir1){
//                currentLineChart = _dataSets[4];
//                
//            } else if ((int)x == (int)Singleton.ratio1Ir2){
//                currentLineChart = _dataSets[5];
//                
//            } else if ((int)x == (int)Singleton.sdCurrent){
//                if (Singleton.breakPointCount == 1) {
//                    currentLineChart = _dataSets[6];
//                    
//                } else {
//                    currentLineChart = _dataSets[8];
//                    
//                }
//                
//            }else if ((int)x == (int)Singleton.ratio2Ir1){
//                currentLineChart = _dataSets[6];
//                
//            }else if ((int)x == (int)Singleton.ratio2Ir2){
//                currentLineChart = _dataSets[7];
//                
//            } else {
//                
//            }
//            currentLineChart.lineWidth = LineSelectedWidth;
//            Selected_X = true;
//        } else {
//            switch ([_dataSets indexOfObject:currentLineChart]) {
//                case 3:
//                    Singleton.qdCurrent = x;
//                    [_IrArray replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%.3f",x]];
//                    
//                    break;
//                case 4:
//                    Singleton.ratio1Ir1 = x;
//                    [_IrArray replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%.3f",x]];
//                    break;
//                case 5:
//                    Singleton.ratio1Ir2 = x;
//                    [_IrArray replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%.3f",x]];
//                    break;
//                case 6:
//                    if (Singleton.breakPointCount == 1) {
//                        Singleton.sdCurrent = x;
//                        [_IrArray replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%.3f",x]];
//                    } else {
//                        Singleton.ratio2Ir1 = x;
//                        [_IrArray replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%.3f",x]];
//                    }
//                    break;
//                case 7:
//                    Singleton.ratio2Ir2 = x;
//                    [_IrArray replaceObjectAtIndex:4 withObject:[NSString stringWithFormat:@"%.3f",x]];
//                    break;
//                case 8:
//                    Singleton.sdCurrent = x;
//                    [_IrArray replaceObjectAtIndex:5 withObject:[NSString stringWithFormat:@"%.3f",x]];
//                    break;
//                default:
//                    break;
//            }
//            
//            if (Singleton.breakPointCount == 1) {
//                y = [self getCrossData_y_breakPoint1:x];
//                
//                
//            } else {
//                y = [self getCrossData_y_breakPoint2:x];
//                
//            }
//            NSArray *yy = @[@(y*0.5),@(y*1.5)];
//            NSArray *xx = @[@(x),@(x)];
//            NSMutableArray *value = [[NSMutableArray alloc] init];
//            for (int n = 0; n < yy.count; n++)
//            {
//                float val = [yy[n] floatValue];;
//                [value addObject:[[ChartDataEntry alloc] initWithX:[xx[n] floatValue] y:val icon: nil]];
//            }
//            currentLineChart.values = value;
//            currentLineChart.lineWidth = LineWidth;
//            [_chartView setNeedsDisplay];
//            Selected_X = false;
//            currentLineChart = nil;
//        }
//    }
//  
// 
//    
//  
//   
//   
//    
//}


#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
{
    
    
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    
    NSLog(@"chartValueNothingSelected");
}

#pragma mark - 低于/高于标准线5%数据
-(NSArray *)valueWithArr:(NSArray *)valueArr rate:(float)rate{
    NSMutableArray *result = [[NSMutableArray alloc]init];
    for (NSInteger i=0;i<valueArr.count;i++) {
        float elem = [valueArr[i] floatValue];
        [result addObject:@(elem*rate)];
        
    }
    return result;
}

-(void)dealloc{
    [kNotificationCenter removeObserver:self];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
