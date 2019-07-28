//
//  BD_HarmWaveformView.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2018/1/23.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_HarmWaveformView.h"
#import "PMCtrl_iPad-Swift.h"
#import "BD_HarmWaveformSelView.h"

@interface BD_HarmWaveformView()<BD_HarmWaveformSelViewDelegate>
{
    WaveformType _type;
    double _maximum;
    NSMutableArray *maxnumArr;
}

/**波形视图*/
@property (nonatomic, weak) LineChartView *chartView;

/**波形数组*/
@property (nonatomic, strong) NSMutableArray *lineChartArray;

/**波形边栏*/
@property (nonatomic, weak) ChartYAxis *leftAxis;
/**左侧纵坐标单位*/
@property(nonatomic,weak)UILabel *leftUnitLabel;
@end

@implementation BD_HarmWaveformView

-(NSMutableArray *)lineChartArray
{
    if (!_lineChartArray) {
        _lineChartArray = [NSMutableArray array];
    }
    return _lineChartArray;
}

-(instancetype)initWithFrame:(CGRect)frame type:(WaveformType)type
{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor colorWithRed:42.0/255.0 green:41.0/255.0 blue:42.0/255.0 alpha:1.0];
        self.backgroundColor = ClearColor;
        _type = type;
        //页面布局
        [self configureUI];
        maxnumArr = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)configureUI
{
    
    //侧边选择视图
    BD_HarmWaveformSelView *leftView = [[BD_HarmWaveformSelView alloc] initWithFrame:CGRectMake(Marge, Marge, 100, self.height - 20) type:(NSInteger)_type];
    leftView.delegate = self;
//    leftView.backgroundColor = [UIColor yellowColor];
    [self addSubview:leftView];
    
    UILabel *leftUnit = [[UILabel alloc]init];
    leftUnit.font = [UIFont systemFontOfSize:11.0];
    leftUnit.textAlignment = NSTextAlignmentCenter;
    [self addSubview:leftUnit];
    self.leftUnitLabel = leftUnit;
    [leftUnit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftView.mas_right).offset(Marge);
        make.centerY.mas_equalTo(leftView.mas_centerY);
        make.width.mas_equalTo(50);
    }];
    
    
    
    //波形视图
    LineChartView *chartView = [[LineChartView alloc] init];
    chartView.backgroundColor = [UIColor colorWithRed:42.0/255.0 green:41.0/255.0 blue:42.0/255.0 alpha:1.0];
    [self addSubview:chartView];
    [chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(Marge);
        make.bottom.mas_equalTo(-30);
        make.right.mas_equalTo(-10);
        make.left.mas_equalTo(leftUnit.mas_right).offset(0);
    }];
    
    UILabel *bottomUnit = [[UILabel alloc]init];
    bottomUnit.font = [UIFont systemFontOfSize:11.0];
    bottomUnit.text = @"时间(ms)";
    bottomUnit.textAlignment = NSTextAlignmentCenter;
    [self addSubview:bottomUnit];
    [bottomUnit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(chartView.mas_centerX);
        make.height.mas_equalTo(30);
        make.bottom.mas_equalTo(0);
    }];
    
    self.chartView = chartView;
    
    chartView.chartDescription.enabled = NO;
    chartView.dragEnabled = NO;
    [chartView setScaleEnabled:NO];
    chartView.pinchZoomEnabled = NO;
    chartView.drawGridBackgroundEnabled = NO;
    chartView.doubleTapToZoomEnabled = NO;
    chartView.noDataTextColor = White;
    
    chartView.xAxis.gridLineDashLengths = @[@5.f,@5.f];
    chartView.xAxis.gridLineDashPhase = 0.5f;
    chartView.xAxis.labelTextColor = White;
    chartView.xAxis.gridColor = White;
    chartView.xAxis.labelPosition = XAxisLabelPositionBottom;
    [chartView.xAxis setLabelCount:6];
    chartView.xAxis.drawAxisLineEnabled = YES;
    chartView.xAxis.drawGridLinesEnabled = YES;
    chartView.xAxis.centerAxisLabelsEnabled = NO;
    chartView.xAxis.drawLabelsEnabled = NO;
    
    ChartYAxis *leftAxis = chartView.leftAxis;
    [leftAxis removeAllLimitLines];
    leftAxis.axisMaximum = 100;
    leftAxis.axisMinimum = -100.0;
    leftAxis.gridLineDashLengths = @[@5.f, @5.f];
    leftAxis.drawZeroLineEnabled = YES;
    leftAxis.drawLimitLinesBehindDataEnabled = NO;
    leftAxis.labelTextColor = White;
    leftAxis.axisLineColor = White;
    leftAxis.gridColor = White;
    self.leftAxis = leftAxis;
    
    chartView.rightAxis.enabled = NO;
    [chartView.legend setEnabled:NO];
    
}

//绘制波形
-(void)drawWaveformLine
{
//    self.chartView.data = [self setData];
    
    LineChartData *data = [[LineChartData alloc] initWithDataSets:[self drawLineChartDataSet]];
    
    //设置最大值
    _maximum = floor(_maximum) * 2;
    DLog(@"%f", _maximum);
    self.leftAxis.axisMaximum = _maximum;
    self.leftAxis.axisMinimum = -_maximum;
    
    self.chartView.data = data;
    
    if ([_tableModel.itemArray.firstObject hasPrefix:@"U"]) {
        self.leftUnitLabel.text = @"电压(V)";
    } else if ([_tableModel.itemArray.firstObject hasPrefix:@"I"]){
        self.leftUnitLabel.text = @"电流(A)";
        
    }
   
//    [self.chartView.data notifyDataChanged];
//    [self.chartView notifyDataSetChanged];
}

-(NSArray *)drawLineChartDataSet
{
    NSMutableDictionary *itemDic = [NSMutableDictionary dictionary];
    NSArray *colorArray = @[[UIColor yellowColor], [UIColor greenColor], [UIColor redColor], [UIColor blueColor]];
    //计算列
    for (NSInteger i = 0; i < self.tableModel.headerDataArray.count; i++) {
        //遍历选中通道
        for (NSInteger j = 0; j < self.channelArray.count; j++) {
            //选中行下标
            NSInteger index;
            if (j == 0) {
                index = 0;
            }else{
                index = [self.channelArray[j] integerValue] - 1;
            }
            
            //行数据模型
            BD_HarmCellModel *cellModel = self.tableModel.contentDataArray[index];
            //item模型
            BD_HarmItem *item = cellModel.itemArray[i];
            
            if (j == 0) {
                //基波
                [itemDic setValue:item forKey:@"1"];
            }else{
                //谐波
                [itemDic setValue:item forKey:self.channelArray[j]];
            }
            
        }
        
        //设置波形点
        LineChartDataSet *set;
        if (self.lineChartArray.count != self.tableModel.headerDataArray.count) {
            
            NSArray *setArr = [self setupLineChartSetWithItemArray:itemDic dcData:[self.dcDataArray[i] floatValue]];
            
            set = [[LineChartDataSet alloc] initWithValues:setArr];

            //对于线的各种设置
            set.lineWidth = 2.f;
            //不显示文字
            set.drawValuesEnabled = NO;
            //选中拐点,是否开启高亮效果(显示十字线)
            set.highlightEnabled = NO;
            // 十字线颜色
            set.highlightColor = [UIColor clearColor];
            //是否绘制拐点
            set.drawCirclesEnabled = NO;
            //是否绘制中间的空心
            set.drawCircleHoleEnabled = NO;
            // 模式为曲线模式
            set.mode = LineChartModeCubicBezier;
            //是否填充颜色
            set.drawFilledEnabled = NO;
            //设置颜色
            [set setColor:colorArray[i]];
            [self.lineChartArray addObject:set];
        }else{
            set = self.lineChartArray[i];
            if (set.lineWidth != 0) {
                NSArray *valueArr = [self setupLineChartSetWithItemArray:itemDic dcData:[self.dcDataArray[i] floatValue]];
                set.values = valueArr ;
            }
        }
        
        //清空数组
        [itemDic removeAllObjects];
    }
    
    return self.lineChartArray;
}

-(NSArray *)setupLineChartSetWithItemArray:(NSDictionary *)itemDic dcData:(CGFloat)dcData
{
   
        BD_HarmItem *firstItem = itemDic[@"1"];
        _maximum = 0;
        NSMutableArray *arr = [NSMutableArray array];
   
    @autoreleasepool{
        for (int i = 0; i < 500; i++) {
            
            //基波y值
            
            CGFloat amplitude = [firstItem.validValues floatValue];
            CGFloat frequency = [self.fre floatValue];
            CGFloat phase = [firstItem.phase floatValue];
            
            double y = [firstItem.validValues floatValue] * sin((1 / [self.fre floatValue]) * i + DEGREES_TO_RADIANS([firstItem.phase floatValue]));
            //计算其他谐波叠加y值
            for (NSInteger j = 0; j < itemDic.allValues.count; j++) {
                //除去基波
                BD_HarmItem *item = itemDic[itemDic.allKeys[j]];
                if (item == firstItem) {
                    continue;
                }
                if ([item.containingRate floatValue] == 0) {
                    continue;
                }
                y += [item.containingRate floatValue] * 0.01 * [firstItem.validValues floatValue] * sin([itemDic.allKeys[j] integerValue] * (1 / [self.fre floatValue]) * i + DEGREES_TO_RADIANS([item.phase floatValue]));
                
            }
            
            //添加直流数据
            y += dcData;
            
            //获取最大值
            if (y > _maximum) {
                _maximum = y;
            }
            
            //        double y = 60 * sin(0.02 * i) + 0.2 * 60 * sin(2 * 0.02 * i) + 0.5 * 60 * sin(3 * 0.02 * i);
            
            ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:y];
            
            [arr addObject:entry];
        }
    }
    
    [maxnumArr addObject:@(_maximum)];
        return arr;

    
}

-(LineChartData *)setData
{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 700; i++) {
        
//        double y = 60 * sin(0.02 * i) + 0.2 * 60 * sin(2 * 0.02 * i) + 0.5 * 60 * sin(3 * 0.02 * i);
        double y = 60 * sin(0.02 * i - M_PI);
        
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:y];
        
        [arr addObject:entry];
    }

    LineChartDataSet *set = [[LineChartDataSet alloc] initWithValues:arr];
    
    //对于线的各种设置
    set.lineWidth = 2.f;
    set.drawValuesEnabled = NO;//不显示文字
    set.highlightEnabled = NO;//选中拐点,是否开启高亮效果(显示十字线)
    set.highlightColor = [UIColor clearColor];// 十字线颜色
    set.drawCirclesEnabled = NO;//是否绘制拐点
    set.drawCircleHoleEnabled = NO;//是否绘制中间的空心
    set.mode = LineChartModeCubicBezier;// 模式为曲线模式
    set.drawFilledEnabled = NO;//是否填充颜色
    [set setColor:[UIColor colorWithRed:0.114 green:0.812 blue:1.000 alpha:1.000]];//折线颜色
//    [set setColor:[UIColor grayColor]];
    set.fillAlpha = 1.0f;//透明度
    
//    set.cubicIntensity = 0.2;// 曲线弧度
//    set.circleRadius = 5.0f;//拐点半径
//    set.circleHoleRadius = 4.0f;//空心的半径
//    set.circleHoleColor = [UIColor whiteColor];//空心的颜色
//    set.circleColors = @[[UIColor colorWithRed:0.114 green:0.812 blue:1.000 alpha:1.000]];
//    设置渐变效果
//    NSArray *gradientColors = @[(id)[ChartColorTemplates colorFromString:@"#FFFFFFFF"].CGColor,
//                                (id)[ChartColorTemplates colorFromString:@"#C4F3FF"].CGColor];
//    CGGradientRef gradientRef = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
   
//    set.fill = [ChartFill fillWithLinearGradient:gradientRef angle:90.0f];//赋值填充颜色对象
//    CGGradientRelease(gradientRef);//释放gradientRef
    
    // 把线放到LineChartData里面,因为只有一条线，所以集合里面放一个就好了，多条线就需要不同的 set 啦
    LineChartData *data = [[LineChartData alloc] initWithDataSets:@[set]];
    return data;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
//    self.layer.shadowColor = BtnViewBorderColor.CGColor;
//    self.layer.shadowOffset = CGSizeZero;
//    self.layer.shadowOpacity = 1.f;
//    self.layer.shadowRadius = 2.f;
    
//    [self setCorenerRadius:2 borderColor:Black borderWidth:2.0];
}

//刷新波形数据
-(void)refreshWaveformData
{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self drawLineChartDataSet];
            //设置最大值
            double maxValue = 0.000;
            for (int i = 0; i<maxnumArr.count; i++) {
                if ([maxnumArr[i] doubleValue]>maxValue) {
                    maxValue = [maxnumArr[i] doubleValue];
                }
            }
          
            if (maxValue<=170) {
                maxValue = 200;
            } else {
                maxValue = floor(maxValue)*1.5;
            }
            
            self.leftAxis.axisMaximum = maxValue;
            self.leftAxis.axisMinimum = -maxValue;
            [self.chartView.data notifyDataChanged];
            [self.chartView notifyDataSetChanged];
            [self.chartView setNeedsDisplay];
        });
  
}

#pragma mark BD_HarmWaveformSelViewDelegate
-(void)waveformDidChangeWith:(UIButton *)button
{
    DLog(@"%@ -- %zd -- %@", button.titleLabel.text, button.tag, button.selected ? @"YES" : @"NO");
    
    LineChartDataSet *set = self.lineChartArray[button.tag];
    set.lineWidth = button.selected ? 2 : 0;
    [self.chartView notifyDataSetChanged];
}


@end
