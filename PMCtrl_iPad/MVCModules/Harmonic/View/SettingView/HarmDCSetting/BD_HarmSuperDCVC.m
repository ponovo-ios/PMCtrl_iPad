//
//  BD_HarmSuperDCVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/7/3.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_HarmSuperDCVC.h"
#import "IQKeyboardManager.h"
#import "BD_HarmDCTableView.h"
#import "BD_HarmDCSettingModel.h"
@interface BD_HarmSuperDCVC (){
}
@property(nonatomic,strong)BD_HarmDCTableView *dcTBView;
@property(nonatomic,strong)UIView *dcBGView;
@property(nonatomic,strong)BD_HarmDCSettingModel *lastdcSettingModel;
@property(nonatomic,strong)BD_HarmDCSettingModel *dcSettingModel;
@end

@implementation BD_HarmSuperDCVC

-(instancetype)init{
    if (self=[super init]) {
      [self setupView];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //设置键盘出现后移动页面
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 60;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setViewData:(BD_HarmDCSettingModel *)dcSettingModel deviceType:(BDDeviceType)deviceType passageWay:(BDHarmPassageType)passageType{
    self.dcSettingModel = dcSettingModel;
    self.dcTBView.dcSettingModel = self.dcSettingModel;
    [self.dcTBView reloadDataWithType:deviceType passageway:passageType];
    [self showView];
}
-(void)TBViewEndEditing{
    
    [self.dcTBView endEditing:YES];
    [self.dcTBView reloadData];
}

-(void)setupView
{
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    UIButton *closeBtn = [[UIButton alloc]init];
    closeBtn.frame = CGRectMake(self.view.width-50,10, 35.0, 35.0);
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    
    WeakSelf;
    
    _dcBGView = [[UIView alloc]initWithFrame:CGRectZero];
    _dcBGView.backgroundColor = BDThemeColor;
    _dcBGView.center = self.view.center;
    [self.view addSubview:_dcBGView];
    
    UIButton *okBtn = [[UIButton alloc]init];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:1.0];
    okBtn.tag = 101;
    [okBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_dcBGView addSubview:okBtn];
    
    [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(-10);
    }];
    
    UIButton *cancelBtn = [[UIButton alloc]init];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:1.0];
    cancelBtn.tag = 102;
    [cancelBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_dcBGView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(okBtn.mas_width);
        make.left.mas_equalTo(okBtn.mas_right).offset(10);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(-10);
    }];
    
    //添加标题
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"叠加直流";
    titleLabel.textColor = White;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:20];
    [self.dcBGView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.centerX.mas_equalTo(weakself.dcBGView.centerX);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    
    
    
    BD_HarmDCTableView *dcTBView = [[BD_HarmDCTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.dcTBView = dcTBView;
    dcTBView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [_dcBGView addSubview:self.dcTBView];
    
    [dcTBView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(5);
        make.center.mas_equalTo(weakself.dcBGView.center);
        make.bottom.mas_equalTo(okBtn.mas_top).offset(-10);
    }];
    
}


-(void)showView{
    WeakSelf;
    self.lastdcSettingModel = [_dcSettingModel copy];
    UIViewController *window = [[UIApplication sharedApplication]keyWindow].rootViewController;
    [window.view addSubview:self.view];
    [UIView animateWithDuration:0.3 animations:^{
        [weakself.dcTBView reloadData];
        weakself.dcBGView.frame = CGRectMake(0, 0, self.view.width*0.6,self.view.height*0.6);
        weakself.dcBGView.center = weakself.view.center;
        [weakself.dcBGView layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        
    }];
}

-(void)closeView{
    WeakSelf;
    
    UIViewController *window = [[UIApplication sharedApplication]keyWindow].rootViewController;
    [window.view addSubview:self.view];
    [UIView animateWithDuration:0.3 animations:^{
        
        weakself.dcBGView.frame = CGRectZero;
        weakself.dcBGView.center = weakself.view.center;
        [weakself.dcBGView layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        [self.view removeFromSuperview];
    }];
}




-(void)buttonAction:(UIButton *)sender{
    
    if (sender.tag == 101) {
        //确定
        //刷新波形
        [kNotificationCenter postNotificationName:BD_HarmDCSettingChanged object:nil userInfo:nil];
      
        //向服务器发送数据改变通知
        [kNotificationCenter postNotificationName:BD_HarmSendData object:nil];
        [self closeView];
    } else {
        //取消
        self.dcSettingModel.ua = self.lastdcSettingModel.ua;
         self.dcSettingModel.ub = self.lastdcSettingModel.ub;
         self.dcSettingModel.uc = self.lastdcSettingModel.uc;
         self.dcSettingModel.uz = self.lastdcSettingModel.uz;
         self.dcSettingModel.ia = self.lastdcSettingModel.ia;
         self.dcSettingModel.ib = self.lastdcSettingModel.ib;
         self.dcSettingModel.ic = self.lastdcSettingModel.ic;
         self.dcSettingModel.ua2 = self.lastdcSettingModel.ua2;
         self.dcSettingModel.ub2 = self.lastdcSettingModel.ub2;
         self.dcSettingModel.uc2 = self.lastdcSettingModel.uc2;
         self.dcSettingModel.ia2 = self.lastdcSettingModel.ia2;
         self.dcSettingModel.ib2 = self.lastdcSettingModel.ib2;
         self.dcSettingModel.ic2 = self.lastdcSettingModel.ic2;
        
        [self closeView];
    }
}
-(void)closeView:(UIButton *)sender{
    [self closeView];
}
#pragma mark - 懒加载
-(BD_HarmDCSettingModel *)lastdcSettingModel{
    if (!_lastdcSettingModel) {
        _lastdcSettingModel = [[BD_HarmDCSettingModel alloc]init];
    }
    return _lastdcSettingModel;
}
-(BD_HarmDCSettingModel *)dcSettingModel{
    if (!_dcSettingModel) {
        _dcSettingModel = [[BD_HarmDCSettingModel alloc]init];
    }
    return _dcSettingModel;
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
