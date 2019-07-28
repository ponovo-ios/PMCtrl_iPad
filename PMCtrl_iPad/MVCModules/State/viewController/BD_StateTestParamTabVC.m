//
//  BD_StateTestParamTabVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/26.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_StateTestParamTabVC.h"
#import "BD_StateTeststateParamVC.h"
#import "BD_StateTesttriggerParamVC.h"
#import "BD_StateTestVectorgraphVC.h"
#import "BD_StateTestStateDiagramVC.h"
@interface BD_StateTestParamTabVC ()<UITabBarControllerDelegate>
@property (nonatomic,strong)BD_StateTeststateParamVC *vc;
@property (nonatomic,strong)BD_StateTesttriggerParamVC *vc1;
@property (nonatomic,strong)BD_StateTestVectorgraphVC *vc3;
@property (nonatomic,strong)BD_StateTestStateDiagramVC *vc2;
@end

@implementation BD_StateTestParamTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ClearColor;
    NSArray *arr = self.viewControllers;
    _vc =arr[0];
    _vc1 = arr[1];
    _vc2 = arr[2];
    _vc3 = arr[3];
    [[UITabBar appearance] setBackgroundColor:BDThemeColor];
   
    self.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setDataModel:(BD_StateTestParamModel *)dataModel{
    _dataModel = dataModel;
    _vc.outputParam = _dataModel.stateParam;
    _vc1.dataModel = _dataModel.triggerParam ;
    _vc1.gradientModel = _dataModel.transmutationParam;
    _vc1.paramTypeArr = [self createParamTypeDatas];
    _vc3.vectorgraphDataArr = _dataModel.stateParam.outputDatas;
    _vc2.vcDatas = _dataModel.stateParam.outputDatas;
}
-(void)setNaviTitle:(NSString *)naviTitle{
    _naviTitle = naviTitle;
    self.navigationItem.title = _naviTitle;
}
#pragma mark UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0){
    return YES;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    _vc.outputParam = _dataModel.stateParam;
    _vc1.dataModel = _dataModel.triggerParam ;
    _vc1.gradientModel = _dataModel.transmutationParam;
    _vc1.paramTypeArr = [self createParamTypeDatas];
    _vc3.vectorgraphDataArr = _dataModel.stateParam.outputDatas;
    _vc2.vcDatas = _dataModel.stateParam.outputDatas;
}


-(NSArray *)createParamTypeDatas{
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    NSMutableArray *data1 = [[NSMutableArray alloc]init];
    NSMutableArray *data2 = [[NSMutableArray alloc]init];
    
        if (_dataModel.stateParam.outputDatas[0].count<=6) {
            for (int n = 0; n<_dataModel.stateParam.outputDatas[0].count; n++) {
                [data1 addObject:_dataModel.stateParam.outputDatas[0][n].titleName];
            }
            
        } else {
            for (int n = 0; n<6; n++) {
                [data1 addObject:_dataModel.stateParam.outputDatas[0][n].titleName];
            }
        }
    
    
    if (_dataModel.stateParam.outputDatas[1].count<=6) {
        for (int n = 0; n<_dataModel.stateParam.outputDatas[1].count; n++) {
            [data2 addObject:_dataModel.stateParam.outputDatas[1][n].titleName];
        }
        
    } else {
        for (int n = 0; n<6; n++) {
            [data2 addObject:_dataModel.stateParam.outputDatas[1][n].titleName];
        }
    }
    
    [datas addObject:data1];
    [datas addObject:data2];
    
    return [datas copy];
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
