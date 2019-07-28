//
//  BD_IECTabBarVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/23.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_IECTabBarVC.h"
#import "BD_TabbarUtil.h"
#import "UIImage+Extension.h"
#import "BD_IECConfitDecodManager.h"
@interface BD_IECTabBarVC ()<UITabBarControllerDelegate>

@end

@implementation BD_IECTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //配置导航栏
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    NSArray *titles = @[@"确定",@"保存配置文件",@"打开配置文件",@"导入SCL"];
    NSMutableArray *rigthItems = [[NSMutableArray alloc]init];
    for (NSString *title in titles) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:title forState:UIControlStateNormal];

        [btn addTarget:self action:@selector(sendIECParamAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
        btn.tag = [titles indexOfObject:title];
        [rigthItems addObject:rightItem];
    }
    
    self.navigationItem.rightBarButtonItems = [rigthItems copy];
    
    //配置tabbar
    self.tabBar.shadowImage = [UIImage new];
    UIView *view = [[UIView alloc]initWithFrame:self.tabBar.bounds];
    view.backgroundColor = BDThemeColor_Light;
    [self.tabBar insertSubview:view atIndex:0];
    for (UIViewController *vc in self.viewControllers) {
        [[BD_TabbarUtil new] setBarItemTitleNormalColor:vc.tabBarItem color:BDTabbarItemNoramlColor];
        [[BD_TabbarUtil new]setBarItemTitleSelectedColor:vc.tabBarItem color:BDTabbarItemSelectedColor];
    }
    self.tabBar.selectionIndicatorImage = [UIImage imageWithColor:[UIColor colorWithRed:150.0/255.0 green:220.0/255.0 blue:227.0/255.0 alpha:0.8] width:(self.tabBar.width/(self.childViewControllers.count))*0.5 height:self.tabBar.height title:@""];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sendIECParamAction:(UIBarButtonItem *)item{
    DLog(@"navigationItem:%ld",item.tag);
    switch (item.tag) {
        case 0:
             //确定
            DLog(@"确定");
            [self.navigationController popViewControllerAnimated:YES];
            
            break;
        case 1:
          //保存配置文件
            
            break;
        case 2:
            //打开配置文件
            break;
        case 3:
            //导入scl文件
            [[[BD_IECConfitDecodManager alloc]init] showIECViewInVC:self sourceView:item];
            break;
        default:
            break;
    }
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
