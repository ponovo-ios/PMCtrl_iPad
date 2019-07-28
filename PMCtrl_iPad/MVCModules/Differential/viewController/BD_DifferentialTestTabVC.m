//
//  BD_DifferentialTestTabVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/1/24.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_DifferentialTestTabVC.h"


#import "BD_StateTestVectorgraphVC.h"

//tab页面分三个分项,参数设置／特性曲线图／矢量图（矢量图只要使用状态序列的矢量图就可以了）
@interface BD_DifferentialTestTabVC ()<UITabBarControllerDelegate>
//@property(nonatomic,strong)BD_DifferentalTestParamItemVC *paramItemVC;

@property(nonatomic,strong)BD_StateTestVectorgraphVC *vectorgraphVC;
@end

@implementation BD_DifferentialTestTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadViewControllers];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loadViewControllers{
//    _paramItemVC = [[BD_DifferentalTestParamItemVC alloc]init];
//    [self addChildViewController:_paramItemVC];
//    [_paramItemVC.tabBarItem setTitle:@"试验参数"];
//
//    [_paramItemVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:White,NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
//    [_paramItemVC.tabBarItem setImage:nil];
//    [_paramItemVC.tabBarItem setSelectedImage:nil];
    
//    _characteristicVC = [[BD_DifferentalTestCharacteristicVC alloc]init];
//    [self addChildViewController:_characteristicVC];
//    [_characteristicVC.tabBarItem setTitle:@"特性曲线图"];
    _vectorgraphVC = [[BD_StateTestVectorgraphVC alloc]init];
    [self addChildViewController:_vectorgraphVC];
    [_vectorgraphVC.tabBarItem setTitle:@"矢量图"];
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
