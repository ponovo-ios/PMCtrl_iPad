//
//  BD_StateTestStateDiagramVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/1/15.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_StateTestStateDiagramVC.h"
#import "BD_OutputwaveShapeDataModel.h"
#import "BD_StateTestParamModel.h"
@interface BD_StateTestStateDiagramVC ()<BD_QuickTestGetOscillographDataDelegate>

@property (nonatomic,strong)  NSMutableArray<BD_QuickTestOscillographModel *>* stateDiagramDataArr;
@end

@implementation BD_StateTestStateDiagramVC

- (void)viewDidLoad {
    [super viewDidLoad];
    WeakSelf;
    self.view.backgroundColor = ClearColor;
    //状态图
    _stateDiagramView = [[BD_QuickTestOscillographTBView alloc]initWithFrame:CGRectZero];
    
    _stateDiagramView.backgroundColor = ClearColor;
    _stateDiagramView.dataDelegate = self;
    _stateDiagramView.isBegin = self.beginModel.isBegin;
//    _stateDiagramView.isLock = _isLock;
    _stateDiagramView.lineDataSourceArr = _stateDiagramDataArr;
    [self.view addSubview:_stateDiagramView];
    [_stateDiagramView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.view.mas_left);
        make.right.mas_equalTo(weakself.view.mas_right);
        make.top.mas_equalTo(weakself.view.mas_top).offset(0);
        make.bottom.mas_equalTo(weakself.view.mas_bottom).offset(0);
    }];
    [kNotificationCenter addObserver:self selector:@selector(deviceConfigCompleteRefreshView:) name:BD_StateTestDeviceConfigFinished object:nil];
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载

-(NSMutableArray<NSMutableArray<BD_TestDataParamModel *> *> *)vcDatas{
    if (!_vcDatas) {
        _vcDatas = [[NSMutableArray alloc]init];
    }
    return _vcDatas;
}

-(BD_BeginTestModel *)beginModel{
    if (!_beginModel) {
        _beginModel = [[BD_BeginTestModel alloc]init];
    }
    return _beginModel;
}

#pragma mark - BD_QuickTestGetOscillographDataDelegate 状态图页面主动获取数据delegate
-(void)refreshData{
    if (_beginModel.isBegin) {
        
      
        @autoreleasepool{
            for (int n = 0; n<_stateDiagramDataArr.count; n++) {
                BD_QuickTestOscillographModel *model = (BD_QuickTestOscillographModel *)_stateDiagramDataArr[n];
                NSLog(@"------刷新页面啦-----");
                for (int i = 0; i<model.VAmplitudeArr.count;i++) {
                    if (model.VAmplitudeArr[i].model.count>=600) {
                        [model.VAmplitudeArr[i].model removeAllObjects];
                    }
                    [model.VAmplitudeArr[i].model addObject:_vcDatas[0][3*n+i].amplitude];
                }
                
                for (int i = 0; i<model.CAmplitudeArr.count;i++) {
                    if (model.CAmplitudeArr[i].model.count>=600) {
                        [model.CAmplitudeArr[i].model removeAllObjects];
                    }
                    [model.CAmplitudeArr[i].model addObject:_vcDatas[1][3*n+i].amplitude];
                }
                
            }
        }
      [self setOscillographBinaryArr];
    
    }
    
}
#pragma mark - 初始化波形图页面的数据
-(void)loadStateDiagramData:(void(^)(NSMutableArray *))complete{
   
    dispatch_async(dispatch_get_main_queue(), ^{
         _stateDiagramDataArr = [[NSMutableArray alloc]init];
        NSInteger totalNum = _vcDatas[0].count<_vcDatas[1].count?_vcDatas[0].count/3:_vcDatas[1].count/3;
        for (int i = 0; i<totalNum;i++) {
            NSMutableArray *UArr = [[NSMutableArray alloc]init];
            NSMutableArray *CArr = [[NSMutableArray alloc]init];
            
            if (_vcDatas[0].count == 4) {
                for(int j = 0;j<4;j++){
                    
                    NSMutableArray *Umodel = [[NSMutableArray alloc]init];
                    NSMutableArray *Cmodel = [[NSMutableArray alloc]init];
                    
                    BD_QuickTestOscillographModel_Base *Ubase = [[BD_QuickTestOscillographModel_Base alloc]initWithTitle:_vcDatas[0][j].titleName model:Umodel];
                    if (j<3) {
                        BD_QuickTestOscillographModel_Base *Cbase = [[BD_QuickTestOscillographModel_Base alloc]initWithTitle:_vcDatas[1][j].titleName model:Cmodel];
                        [CArr addObject:Cbase];
                    }
                    [UArr addObject:Ubase];
                    
                }
            } else {
                for (int j = 3*i; j<(i+1)*3;j++) {
                    NSMutableArray *Umodel = [[NSMutableArray alloc]init];
                    NSMutableArray *Cmodel = [[NSMutableArray alloc]init];
                   
                    BD_QuickTestOscillographModel_Base *Ubase = [[BD_QuickTestOscillographModel_Base alloc]initWithTitle:_vcDatas[0][j].titleName model:Umodel];
                    BD_QuickTestOscillographModel_Base *Cbase = [[BD_QuickTestOscillographModel_Base alloc]initWithTitle:_vcDatas[1][j].titleName model:Cmodel];
                    
                    [UArr addObject:Ubase];
                    [CArr addObject:Cbase];
                }
            }
            
            
            BD_QuickTestOscillographModel *os = [[BD_QuickTestOscillographModel alloc]initWithVAmplitudeArr:UArr CAmplitudeArr:CArr];
            [_stateDiagramDataArr addObject:os];
        }

        NSInteger otherNum =  abs((int)(_vcDatas[0].count-_vcDatas[1].count))/3;

        for (int n = (int)totalNum; n<otherNum+totalNum; n++) {
            NSMutableArray *UArr = [[NSMutableArray alloc]init];
            NSMutableArray *CArr = [[NSMutableArray alloc]init];
            if (_vcDatas[0].count>_vcDatas[1].count) {
                for (int j = 3*n; j<(n+1)*3;j++) {
                    NSMutableArray *Umodel = [[NSMutableArray alloc]init];

                    BD_QuickTestOscillographModel_Base *Ubase = [[BD_QuickTestOscillographModel_Base alloc]initWithTitle:_vcDatas[0][j].titleName model:Umodel];


                    [UArr addObject:Ubase];
                }

                BD_QuickTestOscillographModel *os = [[BD_QuickTestOscillographModel alloc]initWithVAmplitudeArr:UArr CAmplitudeArr:CArr];
                [_stateDiagramDataArr addObject:os];
            } else {
                for (int j = 3*n; j<(n+1)*3;j++) {

                    NSMutableArray *Cmodel = [[NSMutableArray alloc]init];
                    BD_QuickTestOscillographModel_Base *Cbase = [[BD_QuickTestOscillographModel_Base alloc]initWithTitle:_vcDatas[1][j].titleName model:Cmodel];


                    [CArr addObject:Cbase];
                }
                BD_QuickTestOscillographModel *os = [[BD_QuickTestOscillographModel alloc]initWithVAmplitudeArr:UArr CAmplitudeArr:CArr];
                [_stateDiagramDataArr addObject:os];
            }

        }
        
    
            complete(_stateDiagramDataArr);
            _stateDiagramView.lineDataSourceArr = _stateDiagramDataArr;
            //状态图页面刷新显示数据后，更新selectedarr中的数据
            [_stateDiagramView.selectedDataArr removeAllObjects];
            for (int i = 0; i<_stateDiagramDataArr.count; i++) {
                BD_OutputwaveShapeDataModel *model;
                if (_stateDiagramDataArr[i].VAmplitudeArr.count !=0 && _stateDiagramDataArr[i].CAmplitudeArr.count !=0 ) {
                    model = [[BD_OutputwaveShapeDataModel alloc]initWithVoltageArr:[[NSMutableArray alloc]initWithArray:@[@(YES),@(YES),@(YES)]] currentArr:[[NSMutableArray alloc]initWithArray:@[@(YES),@(YES),@(YES)]]];
                     [_stateDiagramView.selectedDataArr addObject:model];
                } else if (_stateDiagramDataArr[i].VAmplitudeArr.count ==0){
                    model = [[BD_OutputwaveShapeDataModel alloc]initWithVoltageArr:[[NSMutableArray alloc]init] currentArr:[[NSMutableArray alloc]initWithArray:@[@(YES),@(YES),@(YES)]]];
                     [_stateDiagramView.selectedDataArr addObject:model];
                } else if (_stateDiagramDataArr[i].CAmplitudeArr.count ==0){
                    model = [[BD_OutputwaveShapeDataModel alloc]initWithVoltageArr:[[NSMutableArray alloc]initWithArray:@[@(YES),@(YES),@(YES)]] currentArr:[[NSMutableArray alloc]init]];
                     [_stateDiagramView.selectedDataArr addObject:model];
                }
                
                
               
            }
            //状态图页面刷新后，修改titleArr中的数据
            [_stateDiagramView.titleArr removeAllObjects];
            for (int i = 0; i<_stateDiagramDataArr.count; i++) {
                NSMutableArray *titleArr = [[NSMutableArray alloc]init];
                for (BD_QuickTestOscillographModel_Base *base in _stateDiagramDataArr[i].VAmplitudeArr) {
                    [titleArr addObject:base.title];
                }
                for (BD_QuickTestOscillographModel_Base *base in _stateDiagramDataArr[i].CAmplitudeArr) {
                    [titleArr addObject:base.title];
                }
                [_stateDiagramView.titleArr addObject:titleArr];
            }
            [_stateDiagramView.tableView reloadData];
        });
   

}

//接收改变时通道配置的通知
-(void)deviceConfigCompleteRefreshView:(NSNotification *)noti{
    WeakSelf;
    NSDictionary *data = (NSDictionary *)noti.userInfo;
    self.vcDatas = [@[((BD_StateTestOutputParamModel *)[data objectForKey:@"result"]).voltageOutputDatas,((BD_StateTestOutputParamModel *)[data objectForKey:@"result"]).currentOutputDatas] mutableCopy];
    
    [self loadStateDiagramData:^(NSMutableArray *datas) {
        weakself.stateDiagramView.lineDataSourceArr  = datas;
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [weakself stateDiagramTBViewReloadData];
        
    });
    
}

-(void)stateDiagramTBViewReloadData{
    [self.stateDiagramView.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//    [self setOscillographDataToZero];
    [self.stateDiagramView.tableView reloadData];
}

-(void)setBeginState{
    self.stateDiagramView.isBegin = self.beginModel.isBegin;

    if (self.beginModel.isBegin) {
        //每次重新开始应该重新绘制轨迹
        [self loadStateDiagramData:^(NSMutableArray *dataArr) {
            }];
        [self.stateDiagramView.binaryStates enumerateObjectsUsingBlock:^(NSMutableArray<NSNumber *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeAllObjects];
        }];
        self.stateDiagramView.xvalueMax=600;
    } else {
    
    }
}
-(void)reloadTBView{
    WeakSelf;
    [self loadStateDiagramData:^(NSMutableArray *dataArr) {
        weakself.stateDiagramView.lineDataSourceArr = dataArr;
        [weakself.stateDiagramView.tableView reloadData];
//        [weakself setOscillographDataToZero];
    }];
    [self.stateDiagramView.tableView reloadData];
}

#pragma mark - 开入开出状态图数据
-(void)setOscillographBinaryArr{
    if (self.stateDiagramView.binaryStates[0].count>=600) {
        self.stateDiagramView.xvalueMax += 600;
        [self.stateDiagramView.binaryStates enumerateObjectsUsingBlock:^(NSMutableArray<NSNumber *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeAllObjects];
        }];
        
    }
    int binaryIn = _binaryInValue;
    int ch[32];
    for (int k=0;k<32;k++)
    {
        ch[k] = -1;
    }
    
    for ( int k=31; k>=0; k-- )
    {
        ch[k] = (binaryIn&0x80000000)==0?1:0;
        binaryIn = binaryIn<<1;
    }
    
    int binaryOut = _binaryOutValue;
    int chout[32];
    for (int i = 0; i<32; i++) {
        chout[i] = -1;
    }
    for (int i =31; i>=0; i--) {
        chout[i] = (binaryOut&0x80000000)==0?1:0;
        binaryOut = binaryOut<<1;
    }
    for (int i = 0; i<8; i++) {
        [self.stateDiagramView.binaryStates[i] addObject:@(chout[7-i])];
    }
    for (int n = 8; n<18; n++) {
        [self.stateDiagramView.binaryStates[n] addObject:@(ch[17-n])];
    }
    
}

- (void)dealloc {
    //[super dealloc];  非ARC中需要调用此句
    [kNotificationCenter removeObserver:self name:BD_StateTestDeviceConfigFinished object:nil];
    //添加监听后，必须移除
    

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
