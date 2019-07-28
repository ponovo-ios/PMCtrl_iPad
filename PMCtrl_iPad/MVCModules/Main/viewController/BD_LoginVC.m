//
//  BD_LoginVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/10.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_LoginVC.h"
#import "BD_QuickTestMainVC.h"
#import "BD_HarmonicController.h"
#import "BD_DifferentialTestMainVC.h"
#import "UIButton+Extension.h"
#import "BD_DeviceInfoService.h"

#import "BD_GradientMainVC.h"

#import "BD_ZeroSequenceMainVC.h"
#define ModuleBtnBGColor RGB(20, 65, 130)
@interface BD_LoginVC ()
@property (weak, nonatomic) IBOutlet UIButton *confitBtn;
@property (weak, nonatomic) IBOutlet UIButton *calibrationBtn;
@property (weak, nonatomic) IBOutlet UIButton *testManageBtn;
@property (weak, nonatomic) IBOutlet UIButton *techSupportBtn;
@property (weak, nonatomic) IBOutlet UIButton *manulTestBtn;
@property (weak, nonatomic) IBOutlet UIButton *stateTestBtn;
@property (weak, nonatomic) IBOutlet UIButton *harmTestBtn;
@property (weak, nonatomic) IBOutlet UIButton *distanceTestBtn;
@property (weak, nonatomic) IBOutlet UIButton *differTestBtn;
@property (weak, nonatomic) IBOutlet UIButton *searchZBorderTestBtn;
@property (weak, nonatomic) IBOutlet UIButton *wholeTestBtn;

@property (weak, nonatomic) IBOutlet UIButton *specialTestBtn;
@property (weak, nonatomic) IBOutlet UIButton *extensionTestBtn;

@property (weak, nonatomic) IBOutlet UIButton *customTestBtn;
@property (weak, nonatomic) IBOutlet UIButton *messageTestBtn;

@property (weak, nonatomic) IBOutlet UIButton *seniorTestBtn;


@property (weak, nonatomic) IBOutlet UIButton *gradientBtn;
@property (weak, nonatomic) IBOutlet UIButton *lowUBtn;
@property (weak, nonatomic) IBOutlet UIButton *ZeroSequenceBtn;


@end

@implementation BD_LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [_quickTestBtn setCorenerRadius:6 borderColor:White borderWidth:1.0];
    [_stateBtn setCorenerRadius:6 borderColor:White  borderWidth:1.0];
    [_quickTestBtn setBackgroundColor:ModuleBtnBGColor];
    [_stateBtn setBackgroundColor:ModuleBtnBGColor];
    // Do any additional setup after loading the view.
    
    [_confitBtn setImgViewStyle:ButtonImgViewStyleTop imageSize:CGSizeMake(50, 50) space:5];
    [_calibrationBtn setImgViewStyle:ButtonImgViewStyleTop imageSize:CGSizeMake(50, 50) space:5];
    [_testManageBtn setImgViewStyle:ButtonImgViewStyleTop imageSize:CGSizeMake(50, 50) space:5];
    [_techSupportBtn setImgViewStyle:ButtonImgViewStyleTop imageSize:CGSizeMake(50, 50) space:5];
    [_manulTestBtn setImgViewStyle:ButtonImgViewStyleTop imageSize:CGSizeMake(80, 80) space:5];
    [_stateTestBtn setImgViewStyle:ButtonImgViewStyleTop imageSize:CGSizeMake(80, 80) space:5];
    [_harmTestBtn setImgViewStyle:ButtonImgViewStyleTop imageSize:CGSizeMake(80, 80) space:5];
    [_differTestBtn setImgViewStyle:ButtonImgViewStyleTop imageSize:CGSizeMake(80, 80) space:5];
    [_distanceTestBtn setImgViewStyle:ButtonImgViewStyleTop imageSize:CGSizeMake(80, 80) space:5];
    [_searchZBorderTestBtn setImgViewStyle:ButtonImgViewStyleTop imageSize:CGSizeMake(80, 80) space:5];
    [_wholeTestBtn setImgViewStyle:ButtonImgViewStyleTop imageSize:CGSizeMake(80, 80) space:5];
    [_gradientBtn setImgViewStyle:ButtonImgViewStyleTop imageSize:CGSizeMake(80, 80) space:5];
    [_lowUBtn setImgViewStyle:ButtonImgViewStyleTop imageSize:CGSizeMake(80, 80) space:5];
    [_ZeroSequenceBtn setImgViewStyle:ButtonImgViewStyleTop imageSize:CGSizeMake(80, 80) space:5];
    
    [_specialTestBtn setImgViewStyle:ButtonImgViewStyleTop imageSize:CGSizeMake(50, 50) space:5];
    [_extensionTestBtn setImgViewStyle:ButtonImgViewStyleTop imageSize:CGSizeMake(50, 50) space:5];
    [_customTestBtn setImgViewStyle:ButtonImgViewStyleTop imageSize:CGSizeMake(50, 50) space:5];
    [_messageTestBtn setImgViewStyle:ButtonImgViewStyleTop imageSize:CGSizeMake(50, 50) space:5];
    [_seniorTestBtn setImgViewStyle:ButtonImgViewStyleTop imageSize:CGSizeMake(50, 50) space:5];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    if ([BD_DeviceInfoService shared].timer) {
        [[BD_DeviceInfoService shared] stopTimer];
    }
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([BD_DeviceInfoService shared].timer) {
        [[BD_DeviceInfoService shared] startTimer];
    }
    self.navigationController.navigationBarHidden = NO;
}


- (IBAction)harmTestVCShow:(id)sender {
    BD_HarmonicController *harmonicVC = [[BD_HarmonicController alloc] init];
    [self.navigationController pushViewController:harmonicVC animated:YES];
}
- (IBAction)differTestVCShow:(id)sender {
    BD_DifferentialTestMainVC *differVC = [[BD_DifferentialTestMainVC alloc]init];
    [self.navigationController pushViewController:differVC animated:YES];
}


- (IBAction)quickTestAction:(id)sender {
    [self popToVCWithVCName:@"BD_QuickTestMainVCID"];
   
}
- (IBAction)stateAction:(id)sender {
    
    [self popToVCWithVCName:@"BD_StateTestMainVCID"];
    
}

- (IBAction)distanceTestVCShow:(id)sender {
    
    
}


- (IBAction)searchZBorderTestVCShow:(id)sender {
    
    
}
- (IBAction)wholeTestVCShow:(id)sender {
    
    
}


- (IBAction)gradientVCShow:(id)sender {
    BD_GradientMainVC *gradientVC = [[BD_GradientMainVC alloc]init];
    [self.navigationController pushViewController:gradientVC animated:YES];
}


- (IBAction)lowUVCShow:(id)sender {
   
}


- (IBAction)zeroSequenceVCShow:(id)sender {
    BD_ZeroSequenceMainVC *zeroVC = [[BD_ZeroSequenceMainVC alloc]init];
    [self.navigationController pushViewController:zeroVC animated:YES];
}



-(void)popToVCWithVCName:(NSString *)vcname{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *vc = [story instantiateViewControllerWithIdentifier:vcname];
    [self.navigationController pushViewController:vc animated:YES];
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
