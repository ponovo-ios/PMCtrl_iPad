//
//  BD_StateTestNaviVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/26.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_StateTestNaviVC.h"
#import "UIImage+Extension.h"
@interface BD_StateTestNaviVC ()

@end

@implementation BD_StateTestNaviVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setShadowImage:[UIImage new]];
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:BDThemeColor width:1.0f height:1.0f title:@""]
                            forBarPosition:UIBarPositionAny
                                barMetrics:UIBarMetricsDefault];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
