//
//  BD_VectorDiagramListVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/6/14.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_VectorDiagramListVC.h"
#import "BD_QuickTestVectorgraphTBView.h"
#import "BD_QuickTestVactorgraphModel.h"
@interface BD_VectorDiagramListVC ()
@property (nonatomic,weak)BD_QuickTestVectorgraphTBView *vectorgraphView;//矢量图
@end

@implementation BD_VectorDiagramListVC

-(instancetype)init{
    if (self == [super init]) {
        [self confitMainView];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.vectorgraphView setFrame: self.view.bounds];
}

-(void)confitMainView{
    BD_QuickTestVectorgraphTBView *vectorgraphView = [[BD_QuickTestVectorgraphTBView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    vectorgraphView.backgroundColor = ClearColor;
    [self.view addSubview:vectorgraphView];
    self.vectorgraphView = vectorgraphView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载
-(NSMutableArray *)voltageDataArr{
    if (!_voltageDataArr) {
        _voltageDataArr = [[NSMutableArray alloc]init];
    }
    return _voltageDataArr;
}
-(NSMutableArray *)currentDataArr{
    if (!_currentDataArr) {
        _currentDataArr = [[NSMutableArray alloc]init];
    }
    return _currentDataArr;
}
#pragma mark - 计算矢量图数据算法

-(void)computationsVectorgraphViewData{
    NSMutableArray *vecArr = [[NSMutableArray alloc]init];
    NSInteger totalNum = _voltageDataArr.count<_currentDataArr.count?_voltageDataArr.count/3:_currentDataArr.count/3;
    for (int i = 0; i<totalNum; i++) {
        NSMutableArray *UArr = [[NSMutableArray alloc]init];
        NSMutableArray *CArr = [[NSMutableArray alloc]init];
        if (_voltageDataArr.count == 4) {
            for(int j = 0;j<4;j++){
                BD_TestDataParamModel *base_U = _voltageDataArr[j];
                if (j<3) {
                    BD_TestDataParamModel *base_C = _currentDataArr[j];
                    [CArr addObject:base_C];
                }
                
                [UArr addObject:base_U];
                
            }
        } else {
            for (int j = 3*i; j<(i+1)*3;j++) {
                BD_TestDataParamModel *base_U = _voltageDataArr[j];
                BD_TestDataParamModel *base_C = _currentDataArr[j];
                [UArr addObject:base_U];
                [CArr addObject:base_C];
            }
        }
        
        BD_QuickTestVactorgraphModel *model = [[BD_QuickTestVactorgraphModel alloc]initWithvoltageArr:UArr currentArr:CArr];
        [vecArr addObject:model];
    }
    
    
    NSInteger otherNum=0;
    if (_voltageDataArr.count!=4) {
        otherNum =  abs((int)(_voltageDataArr.count-_currentDataArr.count))/3;
    } else {
        otherNum =  abs((int)(3-_currentDataArr.count))/3;
    }
    for (int n = (int)totalNum; n<otherNum+totalNum; n++) {
        NSMutableArray *UArr = [[NSMutableArray alloc]init];
        NSMutableArray *CArr = [[NSMutableArray alloc]init];
        if (_voltageDataArr.count>_currentDataArr.count) {
            for (int j = 3*n; j<(n+1)*3;j++) {
                BD_TestDataParamModel *base_U = _voltageDataArr[j];
                [UArr addObject:base_U];
                
            }
            BD_QuickTestVactorgraphModel *model = [[BD_QuickTestVactorgraphModel alloc]initWithvoltageArr:UArr currentArr:CArr];
            [vecArr addObject:model];
        } else {
            for (int j = 3*n; j<(n+1)*3;j++) {
                BD_TestDataParamModel *base_C = _currentDataArr[j];
                [CArr addObject:base_C];
            }
            BD_QuickTestVactorgraphModel *model = [[BD_QuickTestVactorgraphModel alloc]initWithvoltageArr:UArr currentArr:CArr];
            [vecArr addObject:model];
        }
        
        
    }
    
    _vectorgraphView.drawViewDataSource = vecArr;
    if (_vectorgraphView.selectedDataArr.count==0) {
        [_vectorgraphView createCellSelectedArr];
    }
    
}

-(void)cleanVectorgraphSelectedArr{
    [_vectorgraphView.selectedDataArr removeAllObjects];
}

-(void)refreshViewData{
    [self computationsVectorgraphViewData];
    [self.vectorgraphView reloadData];
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
