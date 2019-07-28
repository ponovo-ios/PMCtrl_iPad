//
//  BD_SpecialTestVC.m
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2018/5/23.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_SpecialTestVC.h"
#import "UIButton+Extension.h"
#import "BD_DifferentialTestMainVC.h"
#import "UIImage+Extension.h"
#import "BD_OverCurrProMainVC.h"
#import "BD_PowerFrequencyMainVC.h"
@interface BD_SpecialTestVC ()
@property (weak, nonatomic) IBOutlet UIButton *diffBtn;

@property (weak, nonatomic) IBOutlet UIButton *distanceBtn;
@property (weak, nonatomic) IBOutlet UIButton *searchZBorderTestBtn;

@property (weak, nonatomic) IBOutlet UIButton *CBOperateBtn;
@property (weak, nonatomic) IBOutlet UIButton *powerFrequencyBtn;
@property (weak, nonatomic) IBOutlet UIButton *overCurrProBtn;

@property (weak, nonatomic) IBOutlet UIButton *faultBackBtn;


@end

@implementation BD_SpecialTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
     [_diffBtn setImgViewStyle:ButtonImgViewStyleTop imageSize:CGSizeMake(80, 80) space:5];
     [_distanceBtn setImgViewStyle:ButtonImgViewStyleTop imageSize:CGSizeMake(80, 80) space:5];
     [_searchZBorderTestBtn setImgViewStyle:ButtonImgViewStyleTop imageSize:CGSizeMake(80, 80) space:5];
     [_CBOperateBtn setImgViewStyle:ButtonImgViewStyleTop imageSize:CGSizeMake(80, 80) space:5];
     [_powerFrequencyBtn setImgViewStyle:ButtonImgViewStyleTop imageSize:CGSizeMake(80, 80) space:5];
     [_overCurrProBtn setImgViewStyle:ButtonImgViewStyleTop imageSize:CGSizeMake(80, 80) space:5];
     [_faultBackBtn setImgViewStyle:ButtonImgViewStyleTop imageSize:CGSizeMake(80, 80) space:5];
   
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:RGB(58.0, 136.0, 145.0) width:1.0f height:1.0f title:@""]
                                                 forBarPosition:UIBarPositionAny
                                                     barMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = White;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)differAction:(id)sender {
    BD_DifferentialTestMainVC *differVC = [[BD_DifferentialTestMainVC alloc]init];
    [self.navigationController pushViewController:differVC animated:YES];
}
- (IBAction)distanceAction:(id)sender {
}
- (IBAction)seatchZBorderAction:(id)sender {
}
- (IBAction)CBOperateAction:(id)sender {
}

- (IBAction)powerFrequencyAction:(id)sender {
    BD_PowerFrequencyMainVC *powerFreVC = [[BD_PowerFrequencyMainVC alloc]init];
    [self.navigationController pushViewController:powerFreVC animated:YES];
}

- (IBAction)overCurAction:(id)sender {
    BD_OverCurrProMainVC *overCurrVC = [[BD_OverCurrProMainVC alloc]init];
    [self.navigationController pushViewController:overCurrVC animated:YES];
}

- (IBAction)faultBackAction:(id)sender {
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.tintColor = BtnViewBorderColor;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:MainBgColor width:1.0f height:1.0f title:@""]
                            forBarPosition:UIBarPositionAny
                                barMetrics:UIBarMetricsDefault];
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
