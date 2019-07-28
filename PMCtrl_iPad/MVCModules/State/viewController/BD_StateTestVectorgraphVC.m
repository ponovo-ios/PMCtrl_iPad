//
//  BD_StateTestVectorgraphVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/1/15.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_StateTestVectorgraphVC.h"
#import "BD_StateTestParamModel.h"
@interface BD_StateTestVectorgraphVC ()

@end

@implementation BD_StateTestVectorgraphVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ClearColor;
    WeakSelf;
    _vectorgraphView = [[BD_QuickTestVectorgraphTBView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
  
    [self.view addSubview:_vectorgraphView];
    [_vectorgraphView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.view.mas_left);
        make.right.mas_equalTo(weakself.view.mas_right);
        make.top.mas_equalTo(weakself.view.mas_top).offset(44);
        make.bottom.mas_equalTo(weakself.view.mas_bottom).offset(-44);
    }];
    
     [kNotificationCenter addObserver:self selector:@selector(deviceConfigCompleteRefreshView:) name:BD_StateTestDeviceConfigFinished object:nil];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    WeakSelf;
    [self computationsVectorgraphViewData:_vectorgraphDataArr[0] currentArr:_vectorgraphDataArr[1]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakself.vectorgraphView reloadData];
    });
}
#pragma mark - 懒加载
-(NSMutableArray *)vectorgraphDataArr{
    if (_vectorgraphDataArr) {
        _vectorgraphDataArr = [[NSMutableArray alloc]init];
    }
    return _vectorgraphDataArr;
}

-(void)computationsVectorgraphViewData:(NSMutableArray<BD_TestDataParamModel *> *)voltageArr currentArr:(NSMutableArray<BD_TestDataParamModel *> *)currentArr{
    
    NSMutableArray *vecArr = [[NSMutableArray alloc]init];
    NSInteger totalNum = voltageArr.count<currentArr.count?voltageArr.count/3:currentArr.count/3;
    for (int i = 0; i<totalNum; i++) {
        NSMutableArray *UArr = [[NSMutableArray alloc]init];
        NSMutableArray *CArr = [[NSMutableArray alloc]init];
        if (voltageArr.count == 4) {
            for(int j = 0;j<4;j++){
                BD_TestDataParamModel *base_U = voltageArr[j];
                if (j<3) {
                    BD_TestDataParamModel *base_C = currentArr[j];
                    [CArr addObject:base_C];
                }
                
                [UArr addObject:base_U];
                
            }
        } else {
            for (int j = 3*i; j<(i+1)*3;j++) {
                BD_TestDataParamModel *base_U = voltageArr[j];
                BD_TestDataParamModel *base_C = currentArr[j];
                [UArr addObject:base_U];
                [CArr addObject:base_C];
            }
        }
        
        BD_QuickTestVactorgraphModel *model = [[BD_QuickTestVactorgraphModel alloc]initWithvoltageArr:UArr currentArr:CArr];
        [vecArr addObject:model];
    }
    
    NSInteger otherNum =  abs((int)(voltageArr.count-currentArr.count))/3;
    
    for (int n = (int)totalNum; n<otherNum+totalNum; n++) {
        NSMutableArray *UArr = [[NSMutableArray alloc]init];
        NSMutableArray *CArr = [[NSMutableArray alloc]init];
        if (voltageArr.count>currentArr.count) {
            for (int j = 3*n; j<(n+1)*3;j++) {
                BD_TestDataParamModel *base_U = voltageArr[j];
                [UArr addObject:base_U];
                
            }
            BD_QuickTestVactorgraphModel *model = [[BD_QuickTestVactorgraphModel alloc]initWithvoltageArr:UArr currentArr:CArr];
            [vecArr addObject:model];
        } else {
            for (int j = 3*n; j<(n+1)*3;j++) {
                BD_TestDataParamModel *base_C = currentArr[j];
                [CArr addObject:base_C];
            }
            BD_QuickTestVactorgraphModel *model = [[BD_QuickTestVactorgraphModel alloc]initWithvoltageArr:UArr currentArr:CArr];
            [vecArr addObject:model];
        }
        
        
    }
    
    _vectorgraphView.drawViewDataSource = vecArr;
    [_vectorgraphView createCellSelectedArr];
}


-(void)deviceConfigCompleteRefreshView:(NSNotification *)noti{
    WeakSelf;
    NSDictionary *data = (NSDictionary *)noti.userInfo;
    self.vectorgraphDataArr = [@[((BD_StateTestOutputParamModel *)[data objectForKey:@"result"]).voltageOutputDatas,((BD_StateTestOutputParamModel *)[data objectForKey:@"result"]).currentOutputDatas] mutableCopy];
     [self computationsVectorgraphViewData:_vectorgraphDataArr[0] currentArr:_vectorgraphDataArr[1]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakself.vectorgraphView reloadData];
    });
    
}



- (void)dealloc {
    //[super dealloc];  非ARC中需要调用此句
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
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
