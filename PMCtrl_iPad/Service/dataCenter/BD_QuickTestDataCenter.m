//
//  BD_QuickTestDataCenter.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/22.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_QuickTestDataCenter.h"
#import "BD_BinaryStateModel.h"
@interface BD_QuickTestDataCenter()
@property(nonatomic,strong)NSMutableArray *originalArr;//状态图数据源
@property(nonatomic,assign)NSTimeInterval currentTime;//开入状态图当前时刻距离开始时刻的时间

@end
@implementation BD_QuickTestDataCenter

-(instancetype)init{
    self = [super init];
    if (self) {
        [self createTimer];
        [self stopTimer];//开始不启动定时器，试验开始后，启动定时器
        _currentTime = 0;
        _binarynbinall = 255;
        _binarynbinall_out = 255;
    }
    return self;
}

-(NSMutableArray *)originalArr{
    if (!_originalArr) {
        _originalArr = [[NSMutableArray alloc]init];
    }
    return _originalArr;
}
-(void)readDataFromPlist{   
        NSArray *dictArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"QuickTestParam" ofType:@".plist"]];
        NSMutableArray *TVdatas = [NSMutableArray arrayWithCapacity:dictArr.count];
        
        for (NSArray *arr in dictArr) {
            
            NSMutableArray *arrM = [NSMutableArray array];
            
            for (NSDictionary *dict in arr) {
                
                BD_TestDataParamModel *peopleList = [BD_TestDataParamModel groupWithDict:dict];
                
                [arrM addObject:peopleList];
            }
            [TVdatas addObject:arrM];
        }
       
       self.originalArr = TVdatas;
}

-(void)updateTestData:(int)V_passNum C_passNum:(int)C_passNum complete:(void(^)(NSMutableArray *))complete{
    dispatch_group_t group = dispatch_group_create();
     dispatch_queue_t queue = dispatch_queue_create("com.pmCtrlCenter.gcd.group", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_enter(group);
    [self readDataFromPlist];
    dispatch_group_leave(group);
    
    dispatch_group_notify(group,queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.originalArr.count!=0) {
                [self.originalArr replaceObjectAtIndex:0 withObject:[self createPassagewayOutputData:[_originalArr[0] copy] passageNum:V_passNum]];
                [self.originalArr replaceObjectAtIndex:1 withObject:[self createPassagewayOutputData:[_originalArr[1] copy] passageNum:C_passNum]];
                complete(self.originalArr);
            }
           
        });
    });
    
}

-(NSMutableArray *)createPassagewayOutputData:(NSMutableArray<BD_TestDataParamModel *> *)originalArr passageNum:(int)passageNum{
    NSMutableArray *resultArr = [[NSMutableArray alloc]init];
    if (passageNum/3 !=1) {
        for (int i = 0; i<passageNum/3; i++) {
            for (int n = 0; n<3;n++) {
                BD_TestDataParamModel *model = [[BD_TestDataParamModel alloc]initWithtitleName:[[originalArr[n].titleName substringToIndex:2] stringByAppendingString:[NSString stringWithFormat:@"%d",i+1]] frequency:originalArr[n].frequency phase:originalArr[n].phase amplitude:originalArr[n].amplitude unit:@""];
                [resultArr addObject:model];
            }
        }
    } else{
        if (passageNum == 4) {
            for (int n = 0; n<4;n++) {
                if (n!=3) {
                    BD_TestDataParamModel *model = [[BD_TestDataParamModel alloc]initWithtitleName:[originalArr[n].titleName substringToIndex:2] frequency:originalArr[n].frequency phase:originalArr[n].phase amplitude:originalArr[n].amplitude unit:@""];
                    [resultArr addObject:model];
                } else {
                    
                    BD_TestDataParamModel *model = [[BD_TestDataParamModel alloc]initWithtitleName:@"Uz" frequency:originalArr[0].frequency phase:originalArr[0].phase amplitude:originalArr[0].amplitude unit:@""];
                    [resultArr addObject:model];

                }
                
            }
        } else {
            for (int n = 0; n<3;n++) {
                BD_TestDataParamModel *model = [[BD_TestDataParamModel alloc]initWithtitleName:[originalArr[n].titleName substringToIndex:2] frequency:originalArr[n].frequency phase:originalArr[n].phase amplitude:originalArr[n].amplitude unit:@""];
                [resultArr addObject:model];
            }
        }
    }
    return resultArr;
}


-(NSMutableArray *)outPutWaveShapeDataCenter:(NSArray<NSMutableArray<BD_TestDataParamModel *> *> *)dataArr{
    NSMutableArray * result = [[NSMutableArray alloc]init];
    NSMutableArray *currentArr = [dataArr[1] mutableCopy];
    NSMutableArray *voltageArr = [dataArr[0] mutableCopy];
    
    if (voltageArr.count == 4) {
        BD_OutputwaveShapeDataModel *waveShapeModel = [[BD_OutputwaveShapeDataModel alloc]init];
        NSMutableArray *array = [[NSMutableArray alloc]init];
//        waveShapeModel.voltageArr = [[NSMutableArray alloc]initWithArray:[voltageArr copy]];
        waveShapeModel.voltageArr = [[NSMutableArray alloc]initWithObjects:[voltageArr[0] copy],[voltageArr[1] copy],[voltageArr[2] copy],[voltageArr[3] copy],nil];
        for (int i = 0; i<currentArr.count/3; i++) {
            NSMutableArray *currentArray = [[NSMutableArray alloc]init];
            for (int j=0 ; j<3; j++) {
                [currentArray addObject:[currentArr[3*i+j] copy]];
            }
            [array addObject:currentArray];
        }
        waveShapeModel.currentArr = array[0];
        [result addObject:waveShapeModel];
        
        for (int i = 1; i<array.count; i++) {
            BD_OutputwaveShapeDataModel *waveShapeModel = [[BD_OutputwaveShapeDataModel alloc]initWithVoltageArr:[[NSMutableArray alloc]init] currentArr:array[i]];
            [result addObject:waveShapeModel];
        }
    } else {
       
        NSMutableArray *Varray = [[NSMutableArray alloc]init];
        NSMutableArray *Carray = [[NSMutableArray alloc]init];
        for (int i = 0; i<voltageArr.count/3; i++) {
            NSMutableArray *voltageArray = [[NSMutableArray alloc]init];
            for (int j=0 ; j<3; j++) {
                [voltageArray addObject:[voltageArr[3*i+j]copy]];
            }
            [Varray addObject:voltageArray];
        }
        
        for (int i = 0; i<currentArr.count/3; i++) {
             NSMutableArray *currentArray = [[NSMutableArray alloc]init];
            for (int j=0 ; j<3; j++) {
                [currentArray addObject:[currentArr[3*i+j] copy]];
            }
            [Carray addObject:currentArray];
        }
        
        if (Varray.count<=Carray.count) {
            for (int i = 0; i<Varray.count; i++) {
                BD_OutputwaveShapeDataModel *waveShapeModel = [[BD_OutputwaveShapeDataModel alloc]initWithVoltageArr:Varray[i] currentArr:Carray[i]];
                [result addObject:waveShapeModel];
            }
            for (int n = (int)Varray.count; n<Carray.count; n++) {
                BD_OutputwaveShapeDataModel *waveShapeModel = [[BD_OutputwaveShapeDataModel alloc]initWithVoltageArr:[[NSMutableArray alloc]init] currentArr:Carray[n]];
                [result addObject:waveShapeModel];
            }
        } else {
            for (int i = 0; i<Carray.count; i++) {
                BD_OutputwaveShapeDataModel *waveShapeModel = [[BD_OutputwaveShapeDataModel alloc]initWithVoltageArr:Varray[i] currentArr:Carray[i]];
                [result addObject:waveShapeModel];
            }
            for (int n = (int)Carray.count; n<Varray.count; n++) {
                BD_OutputwaveShapeDataModel *waveShapeModel = [[BD_OutputwaveShapeDataModel alloc]initWithVoltageArr:Varray[n] currentArr:[[NSMutableArray alloc]init]];
                [result addObject:waveShapeModel];
            }
        }
        
    }
    return  result;
}

-(NSMutableArray *)createBinaryStateLineViewDatas{
    _binaryStateDatas = [[NSMutableArray alloc]init];
    [self createRefreshTime];
    NSArray *titles = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H"];
    NSArray *states = @[@(NO),@(NO),@(NO),@(NO),@(NO),@(NO),@(NO),@(NO)];
    NSMutableArray *modelArr = [[NSMutableArray alloc]init];
    for (int i = 0 ;i<titles.count; i++) {
        BD_BinaryStateModel *sm = [[BD_BinaryStateModel alloc]initWithBinaryName:titles[i] binaryState:[states[i] isEqual:@(YES)]?YES:NO lengthData:0-[_times[0] intValue]];
        
        BD_BinaryStateViewModel *model = [[BD_BinaryStateViewModel alloc]initWithbinaryName:titles[i] lineData:[[NSMutableArray alloc]initWithObjects:sm, nil]];
        [modelArr addObject:model];
    }
    [_binaryStateDatas addObject:modelArr];
    
    NSArray *titles1 = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"];
    NSArray *states1 = @[@(NO),@(NO),@(NO),@(NO),@(NO),@(NO),@(NO),@(NO)];
    NSMutableArray *modelArr1 = [[NSMutableArray alloc]init];
    for (int i = 0 ;i<titles1.count; i++) {
        BD_BinaryStateModel *sm = [[BD_BinaryStateModel alloc]initWithBinaryName:titles1[i] binaryState:[states1[i] isEqual:@(YES)]?YES:NO lengthData:0-[_times[0] intValue]];
        
        BD_BinaryStateViewModel *model1 = [[BD_BinaryStateViewModel alloc]initWithbinaryName:titles1[i] lineData:[[NSMutableArray alloc]initWithObjects:sm, nil]];
        [modelArr1 addObject:model1];
    }
    [_binaryStateDatas addObject:modelArr1];
    
    return _binaryStateDatas;
}

-(void)timerRefreshBinaryStateLineData{
    _currentTime = _currentTime+1;
    NSArray *xValues = [[self createRefreshTime] copy];//必须定时刷，否则如果再改变x轴数据的时候，正好在数据状态图页面，该方法不刷新，就会导致绘图错误；
    if (_binaryStateDatas.count!=0) {
        NSArray *viewM = _binaryStateDatas[0];
        for (BD_BinaryStateViewModel *stateVew in viewM) {
            NSInteger index = [viewM indexOfObject:stateVew];
            NSMutableArray *stateArr = [self binaryNbinallToBoolean:_binarynbinall];
            //如果开入量变化了，判断状体数组中的值，如果是通道打开，BD_BinaryStateViewModel 中lineData添加一项，对于单条线是添加一个贝塞尔曲线，保证出现宽度为1 和5的状态线
            //获取每条线最后一个对象的状态值
            BOOL linestate = ((BD_BinaryStateModel *)[stateVew.lineData lastObject]).binaryState;
            
            //如果开入状态和每条线最后一个对象状态值相同，就改变它的长度值即可，单如果不相同，就添加一个对象，添加一个贝塞尔曲线
            if (![stateArr[index] isEqual:@(linestate)]) {
                BD_BinaryStateModel *mm = [[BD_BinaryStateModel alloc]initWithBinaryName:stateVew.binaryName binaryState:!linestate lengthData:(CGFloat)_currentTime-[xValues[0] intValue]];//初始化数据类型必须一致，否则报错
                [stateVew.lineData addObject:mm];
            } else{
                //只要修改stateView中数据源lineData的最后一个对象的长度就行，不需要全改，全改的话，所有的之前的状态就会都改变了
                BD_BinaryStateModel *state = [stateVew.lineData lastObject];
                state.binaryState = linestate;
                state.lengthData = (CGFloat)_currentTime-[xValues[0] intValue];
                
            }
            
        }
        
        NSArray *viewM1 = _binaryStateDatas[1];
        for (BD_BinaryStateViewModel *stateVew1 in viewM1) {
            NSInteger index1 = [viewM1 indexOfObject:stateVew1];
            NSMutableArray *stateArr1 = [self binaryNbinallToBoolean:_binarynbinall_out];
            //如果开入量变化了，判断状体数组中的值，如果是通道打开，BD_BinaryStateViewModel 中lineData添加一项，对于单条线是添加一个贝塞尔曲线，保证出现宽度为1 和5的状态线
            //获取每条线最后一个对象的状态值
            BOOL linestate1 = ((BD_BinaryStateModel *)[stateVew1.lineData lastObject]).binaryState;
            
            //如果开入状态和每条线最后一个对象状态值相同，就改变它的长度值即可，单如果不相同，就添加一个对象，添加一个贝塞尔曲线
            if (![stateArr1[index1] isEqual:@(linestate1)]) {
                BD_BinaryStateModel *mm1 = [[BD_BinaryStateModel alloc]initWithBinaryName:stateVew1.binaryName binaryState:!linestate1 lengthData:(CGFloat)_currentTime-[xValues[0] intValue]];//初始化数据类型必须一致，否则报错
                [stateVew1.lineData addObject:mm1];
            } else{
                //只要修改stateView中数据源lineData的最后一个对象的长度就行，不需要全改，全改的话，所有的之前的状态就会都改变了
                BD_BinaryStateModel *state1 = [stateVew1.lineData lastObject];
                state1.binaryState = linestate1;
                state1.lengthData = (CGFloat)_currentTime-[xValues[0] intValue];
                
            }
            
        }
        
    }
    
        //每次数据源改变后，发出通知，通知开入开出状态曲线页面刷新UI,即(刷新tableView)
        [kNotificationCenter postNotificationName:BD_BinaryStateLineRefresh object:nil];
    
    
}

-(NSMutableArray *)createRefreshTime{
    if (!_times) {
        _times = [[NSMutableArray alloc]initWithObjects:@(0),@(10),@(20),@(30),@(40),@(50),@(60),@(70),@(80),@(90), nil];
    }
    if (_currentTime==[[_times lastObject] doubleValue]) {
        for (int i = 0;i<_times.count;i++) {
            NSNumber *num = _times[i];
            [_times replaceObjectAtIndex:i withObject:@([num intValue]+90)];//修改x轴时间显示，需要+90,表示x轴的范围跨度，而不是加上时间数组中最后一个值，之前显示有误就是因为加了数组中最后一个值，导致时间变化发生跳跃；绘制图显示错误，在第3轮回的时候，就不会显示画的状态线了；
            //
           
        }
    }
    //x轴时间变化后，删除最后一个状态之前的数据
    if (_currentTime == [[_times firstObject] intValue]) {
        for (NSArray *viewM in _binaryStateDatas) {
            for (BD_BinaryStateViewModel *stateVew in viewM) {
                
                [stateVew.lineData removeObjectsInRange:NSMakeRange(0, stateVew.lineData.count-1)];
               
                
            }
        }
    }
    return _times;
}

-(void)startTimer{
    [_timer setFireDate:[NSDate distantPast]];
}

-(void)stopTimer{
    [_timer setFireDate:[NSDate distantFuture]];
}
-(void)createTimer{
   _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerRefreshBinaryStateLineData) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
-(void)cancelTimer{
    [_timer invalidate];
    _timer = nil;
}
-(NSMutableArray *)binaryNbinallToBoolean:(int)n{
    NSMutableArray *result = [[NSMutableArray alloc]init];
    int d;
    for(int i=0;i<8;i++)
    {
        d=n%2;  //取余,余数
        n=n/2;  //取整
        if (d == 0) {
            //通道开
            [result addObject:@(YES)];
        }
        else if (d == 1){
            //通道关
            [result addObject:@(NO)];
        }
    }
    return result;
}

-(void)setBinaryDataDefault{
    _currentTime = 0;
    for (int i = 0;i<_times.count;i++) {
        [_times replaceObjectAtIndex:i withObject:@(10*i)];
    }
    for (NSMutableArray *model in _binaryStateDatas) {
        for (BD_BinaryStateViewModel *mm in model) {
            [mm.lineData enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ((BD_BinaryStateModel *)obj).binaryState = NO;
                ((BD_BinaryStateModel *)obj).lengthData = 0.000;
            }];
        }
    }
   
}
@end
