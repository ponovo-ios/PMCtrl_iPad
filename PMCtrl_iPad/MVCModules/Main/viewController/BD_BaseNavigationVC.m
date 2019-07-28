//
//  BD_BaseNavigationVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/10.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_BaseNavigationVC.h"
#import "UIImage+Extension.h"
@interface BD_BaseNavigationVC ()<UIGestureRecognizerDelegate>

@end

@implementation BD_BaseNavigationVC


-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    if (self = [super initWithRootViewController:rootViewController]) {
        self.navigationBar.barTintColor = BtnViewBorderColor;
//        [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:BtnViewBorderColor}];
        [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:BtnViewBorderColor,NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];
        
        self.navigationItem.titleView = nil;
        self.navigationBar.tintColor = BtnViewBorderColor;
        [self.navigationBar setShadowImage:[UIImage new]];
//        self.navigationItem.hidesBackButton = YES;
//        //隐藏navigationbar 返回按钮的文字
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
        
        [self.navigationBar setBackgroundImage:[UIImage imageWithColor:MainBgColor width:1.0f height:1.0f title:@""]
                           forBarPosition:UIBarPositionAny
                               barMetrics:UIBarMetricsDefault];
    }
    return self;
}


- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    self.interactivePopGestureRecognizer.delegate = self;
  
    
}
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    
}

-(UIViewController *)getPreviousViewController
{
    return  self.viewControllers.count >1? self.viewControllers[self.viewControllers.count-2]:nil;
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer
                                      *)gestureRecognizer{
    return NO; //YES：允许右滑返回  NO：禁止右滑返回
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
