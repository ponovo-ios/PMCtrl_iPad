//
//  BD_DifferentialSettingVC.m
//  PMCtrl_iOS
//
//  Created by wang on 2017/5/30.
//  Copyright © 2017年 wgx. All rights reserved.
//

#import "BD_DifferentialGeneralSettingVC.h"
#import "BD_DifferentialGeneralTBView.h"

#import "GeneralParaModel.h"
#import "BD_DifferentialGeneralTBView.h"
#import "BD_DifferGeneralSetDataModel.h"
#import "IQKeyboardManager.h"
@interface BD_DifferentialGeneralSettingVC ()<UIScrollViewDelegate,UIPopoverPresentationControllerDelegate>{
   
    NSArray<NSArray<GeneralParaModel *> *> *generalBackModelArr;
}


@property (nonatomic, weak) BD_DifferentialGeneralTBView * generTableView;
@property(nonatomic,strong)UIView *generalView;
@property(nonatomic,strong)NSMutableArray *lastViewDataArr;


@end

@implementation BD_DifferentialGeneralSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //初始化block返回的数据

    generalBackModelArr = [[NSArray alloc]init];
    
    [self setupView];
    
    
    //设置键盘出现后移动页面
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 60;
    
}

-(void)TBViewEndEditing{
    [self.generTableView endEditing];
    [self.generTableView reloadData];

}

-(NSInteger)stringToInt:(NSString *)text{
    if ([text isEqualToString:@"开放"] || [text isEqualToString:@"逻辑或"] | [text isEqualToString:@"打开"]) {
        return 0;
    } else if ([text isEqualToString:@"闭锁"] || [text isEqualToString:@"逻辑与"] | [text isEqualToString:@"关闭"])  {
        return 1;
    }
    return 0;
}

#pragma mark - 导航栏返回操作
- (void)goBack{
 
   
  
    //保存文件到plist文件中，异步存入
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

/**---------------------通用参数plist文件保存到沙盒，暂时不用----------------------------
//        [FileUtil deleteFileWithPath:@"generalValue.plist"];
//        NSMutableArray *generalArr = [[NSMutableArray alloc]init];
//        for (NSArray *_arr in generalBackModelArr) {
//            NSMutableArray *arr = [[NSMutableArray alloc]init];
//            for (GeneralParaModel *model in _arr) {
//                NSDictionary *dic = @{@"name":model.name,@"param":model.param};
//
//                [arr addObject:dic];
//
//            }
//            [generalArr addObject:arr];
//
//        }
//
//        [FileUtil saveInfoToPlist:@"generalValue.plist" dic:@{@"generalValue":generalArr}];
-----------------------------------------------------------------*/

        
        if ([generalBackModelArr[1][3].param isEqualToString:@"自动计算"]) {
            self.generalDataParam.BalanceParaCacuType = @"0";
        } else if ([generalBackModelArr[1][3].param isEqualToString:@"手动计算并输入"]){
            self.generalDataParam.BalanceParaCacuType = @"1";
        }

        if ([generalBackModelArr[2][0].param isEqualToString:@"Y"]) {
           self.generalDataParam.WindH = @"1";
        } else {
            self.generalDataParam.WindH = @"0";
        }

        if ([generalBackModelArr[2][1].param isEqualToString:@"Y"]) {
            self.generalDataParam.WindM = @"1";
        } else {
            self.generalDataParam.WindM = @"0";
        }
        if ([generalBackModelArr[2][2].param isEqualToString:@"Y"]) {
            self.generalDataParam.WindL = @"1";
        } else {
           self.generalDataParam.WindL = @"0";
        }

        if ([generalBackModelArr[2][3].param isEqualToString:@"无校正"]){
            self.generalDataParam.AngleMode = @"0";
        } else if ([generalBackModelArr[2][3].param isEqualToString:@"Y侧校正"]){
            self.generalDataParam.AngleMode = @"2";
        } else if ([generalBackModelArr[2][3].param isEqualToString:@"▲侧校正"]){
            self.generalDataParam.AngleMode = @"1";
        }

        if ([generalBackModelArr[2][4].param isEqualToString:@"高-低"]) {
            self.generalDataParam.WindSide = @"0";
        }else if ([generalBackModelArr[2][4].param isEqualToString:@"高-中"]){
            self.generalDataParam.WindSide = @"1";
        } else if ([generalBackModelArr[2][4].param isEqualToString:@"中-低"]){
            self.generalDataParam.WindSide = @"2";
        }

        if ([generalBackModelArr[2][5].param isEqualToString:@"1点"]) {
            self.generalDataParam.ConnMode = @"1";
        } else if ([generalBackModelArr[2][5].param isEqualToString:@"2点"]){
            self.generalDataParam.ConnMode = @"2";
        }else if ([generalBackModelArr[2][5].param isEqualToString:@"3点"]){
            self.generalDataParam.ConnMode = @"3";
        }else if ([generalBackModelArr[2][5].param isEqualToString:@"4点"]){
            self.generalDataParam.ConnMode = @"4";
        }else if ([generalBackModelArr[2][5].param isEqualToString:@"5点"]){
           self.generalDataParam.ConnMode = @"5";
        }else if ([generalBackModelArr[2][5].param isEqualToString:@"6点"]){
            self.generalDataParam.ConnMode = @"6";
        }else if ([generalBackModelArr[2][5].param isEqualToString:@"7点"]){
            self.generalDataParam.ConnMode = @"7";
        }else if ([generalBackModelArr[2][5].param isEqualToString:@"8点"]){
            self.generalDataParam.ConnMode = @"8";
        }else if ([generalBackModelArr[2][5].param isEqualToString:@"9点"]){
            self.generalDataParam.ConnMode = @"9";
        }else if ([generalBackModelArr[2][5].param isEqualToString:@"10点"]){
            self.generalDataParam.ConnMode = @"10";
        }else if ([generalBackModelArr[2][5].param isEqualToString:@"11点"]){
            self.generalDataParam.ConnMode = @"11";
        }else if ([generalBackModelArr[2][5].param isEqualToString:@"12点"]){
            self.generalDataParam.ConnMode = @"0";
        }

        if ([generalBackModelArr[2][6].param isEqualToString:@"不考虑绕组接线型式"]) {
            self.generalDataParam.JXFactor = @"0";
        } else if ([generalBackModelArr[2][6].param isEqualToString:@"考虑绕组接线型式"]) {
            self.generalDataParam.JXFactor = @"1";
        }

        if ([generalBackModelArr[2][7].param isEqualToString:@"二分法"]) {
            self.generalDataParam.SerachMode = @"0";
        } else if([generalBackModelArr[2][7].param isEqualToString:@"单步逼近"]){
            self.generalDataParam.SerachMode = @"1";
        }

        if ([generalBackModelArr[2][8].param isEqualToString:@"两侧指向变压器"]) {
            self.generalDataParam.IdEqu = @"0";
        } else if ([generalBackModelArr[2][8].param isEqualToString:@"一侧指向变压器"]) {
            self.generalDataParam.IdEqu = @"1";
        }
        NSArray *a = @[@"Ir=(|I1-I2|)/K1或Ir=(|I1+I2|)/K1",@"Ir=(|I1|+|I2|*K2)/K1",@"Ir=max(|I1|,|I2|)",@"Ir=(|Id-|I1|-|I2||)/K1",@"Ir=|I2|",@"Sqrt(K1*I1*I2*Cos(δ))"];
        for (int i = 0; i<a.count; i++) {
            //制动方程
            if ([generalBackModelArr[2][9].param isEqualToString:a[i]]) {
                self.generalDataParam.Equation = [NSString stringWithFormat:@"%d",i];
            }
        }



        if ([generalBackModelArr[2][12].param isEqualToString:@"A"]) {
            self.generalDataParam.Phase_Type = @"0";
        } else if ([generalBackModelArr[2][12].param isEqualToString:@"B"]){
            self.generalDataParam.Phase_Type = @"1";
        }else if ([generalBackModelArr[2][12].param isEqualToString:@"C"]){
            self.generalDataParam.Phase_Type = @"2";
        }else if ([generalBackModelArr[2][12].param isEqualToString:@"ABC"]){
            self.generalDataParam.Phase_Type = @"3";
        }
        
        self.generalDataParam.ED_V = generalBackModelArr[0][0].param;
        self.generalDataParam.ED_I = generalBackModelArr[0][1].param;
        self.generalDataParam.ED_Hz = generalBackModelArr[0][2].param;
        
        self.generalDataParam.PreTime = generalBackModelArr[1][0].param;
        self.generalDataParam.PrefaultTime = generalBackModelArr[1][1].param;
        self.generalDataParam.FaultTime = generalBackModelArr[1][2].param;
        
        self.generalDataParam.SN = generalBackModelArr[1][4].param;
        self.generalDataParam.Uh = generalBackModelArr[1][5].param;
        self.generalDataParam.Um = generalBackModelArr[1][6].param;
        self.generalDataParam.Ul = generalBackModelArr[1][7].param;
        self.generalDataParam.CTPh = generalBackModelArr[1][8].param;
        self.generalDataParam.CTPm = generalBackModelArr[1][9].param;
        self.generalDataParam.CTPl = generalBackModelArr[1][10].param;
        self.generalDataParam.CTSh = generalBackModelArr[1][11].param;
        self.generalDataParam.CTSm = generalBackModelArr[1][12].param;
        self.generalDataParam.CTSl = generalBackModelArr[1][13].param;
        self.generalDataParam.Kph = generalBackModelArr[1][14].param;
        self.generalDataParam.Kpm = generalBackModelArr[1][15].param;
        self.generalDataParam.Kpl = generalBackModelArr[1][16].param;
        
        
    
        self.generalDataParam.K1 = generalBackModelArr[2][10].param;
        self.generalDataParam.K2 = generalBackModelArr[2][11].param;

        self.generalDataParam.Reso = generalBackModelArr[2][13].param;
        self.generalDataParam.Ugroup1 = generalBackModelArr[2][14].param;
        self.generalDataParam.Ugroup2 = generalBackModelArr[2][15].param;
        WeakSelf
        if (_okBlock) {
            weakself.okBlock();
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself TBViewEndEditing];
            [weakself closeGeneralParaView];
        });
        
    });

}




-(BD_DifferGeneralSetDataModel *)generalDataParam{
    if (!_generalDataParam) {
        _generalDataParam = [[BD_DifferGeneralSetDataModel alloc]init];
    }
    return _generalDataParam;
}

-(NSMutableArray *)generModelArray{
    if (!_generModelArray) {
        _generModelArray = [[NSMutableArray alloc]init];
    }
    return _generModelArray;
}
-(NSMutableArray *)lastViewDataArr{
    if (!_lastViewDataArr) {
        _lastViewDataArr = [[NSMutableArray alloc]init];
    }
    return _lastViewDataArr;
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
    
    _generalView = [[UIView alloc]initWithFrame:CGRectZero];
    _generalView.backgroundColor = BDThemeColor;
    _generalView.center = self.view.center;
    [self.view addSubview:_generalView];
    
    UIButton *okBtn = [[UIButton alloc]init];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:1.0];
    okBtn.tag = 101;
    [okBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_generalView addSubview:okBtn];
    
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
    [_generalView addSubview:cancelBtn];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(okBtn.mas_width);
        make.left.mas_equalTo(okBtn.mas_right).offset(10);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(-10);
    }];

    //添加标题
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"通用参数";
    titleLabel.textColor = White;
    titleLabel.font = [UIFont systemFontOfSize:20];
     titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.generalView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.centerX.mas_equalTo(weakself.generalView.centerX);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    
    //添加tableView视图
    BD_DifferentialGeneralTBView *generTableView = [[BD_DifferentialGeneralTBView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    for (NSMutableArray *subArr in self.generModelArray) {
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        [subArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [arr addObject:[((GeneralParaModel *)obj) copy]];
        }];
        [generTableView.modelArr addObject:arr];
    }
    self.generTableView = generTableView;
    generTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    generTableView.showGeneralBlock = ^(UIButton *button) {
        [weakself generalSheetWith:button];
    };
    generalBackModelArr = generTableView.modelArr;
    generTableView.generalResultBlock = ^(NSMutableArray *generalArr){
        generalBackModelArr = generalArr;
    };
    [generTableView setCorenerRadius:6 borderColor:BDThemeColor borderWidth:2.0];
    [self.generalView addSubview:generTableView];

    [_generTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.center.mas_equalTo(weakself.generalView.center);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(5);
        make.bottom.mas_equalTo(okBtn.mas_top).offset(-10);
    }];
    
}


-(void)showGeneralParaView{
    WeakSelf;
    for (NSInteger i = 0; i<self.generModelArray.count; i++) {
        NSMutableArray *subArr = self.generModelArray[i];
        [subArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            GeneralParaModel *model = (GeneralParaModel *)obj;
            ((GeneralParaModel *)weakself.generTableView.modelArr[i][idx]).param = model.param;
             ((GeneralParaModel *)generalBackModelArr[i][idx]).param = model.param;
            
        }];
    }
    
    UIViewController *window = [[UIApplication sharedApplication]keyWindow].rootViewController;
    [window.view addSubview:self.view];
    [UIView animateWithDuration:0.3 animations:^{
        [weakself.generTableView reloadData];
        weakself.generalView.frame = CGRectMake(0, 0, self.view.width*0.8,self.view.height*0.9);
        weakself.generalView.center = weakself.view.center;
        [weakself.generalView layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        
    }];
}

-(void)closeGeneralParaView{
    WeakSelf;
    UIViewController *window = [[UIApplication sharedApplication]keyWindow].rootViewController;
    [window.view addSubview:self.view];
    [UIView animateWithDuration:0.3 animations:^{
        
        weakself.generalView.frame = CGRectZero;
        weakself.generalView.center = weakself.view.center;
        [weakself.generalView layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        [self.view removeFromSuperview];
    }];
}

#pragma mark - 设置通用参数可选择项的popview

- (void)generalSheetWith:(UIButton *)button{
  [self.generTableView endEditing];
    NSArray *arr;
//    (row == 203 || row == 300 || row == 301 || row == 302 || row == 303 || row == 304 || row == 305 || row == 306 || row == 307 || row == 308 || row == 309 || row == 312) 
    switch (button.tag) {
        case 203:
            arr = @[@"自动计算",@"手动计算并输入"];//各侧平衡系数
            [self generalrow:arr button:button];
            break;
        case 300:
            arr = @[@"▲",@"Y"];//高压侧绕组界限形式
            [self generalrow:arr button:button];
            break;
        case 301:
            arr = @[@"▲",@"Y"];//中压侧绕组界限形式
            [self generalrow:arr button:button];
            break;
        case 302:
            arr = @[@"▲",@"Y"];//低压侧绕组界限形式
            [self generalrow:arr button:button];
            break;
        case 303:
            arr = @[@"无校正",@"Y侧校正",@"▲侧校正"];//校正选择
            [self generalrow:arr button:button];
            break;
        case 304:
            arr = @[@"高-低",@"高-中",@"中-低"]; //测试绕组
            [self generalrow:arr button:button];
            break;
        case 305:
            arr = @[@"1点",@"2点",@"3点",@"4点",@"5点",@"6点",@"7点",@"8点",@"9点",@"10点",@"11点",@"12点"];//测试绕组之间角差（钟点数）通过pickView的方式展示
            [self generalrow:arr button:button];
            break;
        case 306:
            arr = @[@"不考虑绕组接线型式",@"考虑绕组接线型式"];//平衡系数计算 不考虑false 考虑 true
            [self generalrow:arr button:button];
            break;
        case 307:
            arr = @[@"二分法",@"单步逼近"];//搜索方法
            [self generalrow:arr button:button];
            break;
        case 308:
            arr = @[@"两侧指向变压器",@"一侧指向变压器"];//CT极性
            [self generalrow:arr button:button];
            break;
        case 309:
            arr = @[@"Ir=(|I1-I2|)/K1或Ir=(|I1+I2|)/K1",@"Ir=(|I1|+|I2|*K2)/K1",@"Ir=max(|I1|,|I2|)",@"Ir=(|Id-|I1|-|I2||)/K1",@"Ir=|I2|",@"Sqrt(K1*I1*I2*Cos(δ))"];//制动方程
            [self generalrow:arr button:button];
            break;
        case 312:
            arr = @[@"A",@"B",@"C",@"ABC"];//测试项
            [self generalrow:arr button:button];
            break;
        default:
            break;
    }
    
}

- (void)generalrow:(NSArray *)arr button:(UIButton *)button{
      [self.generTableView endEditing];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int i = 0; i<arr.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:arr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.generTableView.modelArr[button.tag/100-1][button.tag%100] setParam:arr[i]];
            [self.generTableView reloadData];
            
        }];
        [alertController addAction:action];
    }
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];

    [alertController addAction:cancelAction];
    //4.显示
    if ([[UIDevice currentDevice].model isEqualToString:@"iPad"]) {
        
        alertController.modalPresentationStyle = UIModalPresentationPopover;
        alertController.preferredContentSize = CGSizeMake(button.bounds.size.width, 240);
        
        UIPopoverPresentationController *popPresenter = alertController.popoverPresentationController;
        popPresenter.sourceView = button;
        popPresenter.sourceRect = button.bounds;
        popPresenter.permittedArrowDirections = UIPopoverArrowDirectionUp; //设置弹出方向
        [self presentViewController:alertController animated:NO completion:nil];
    }
    else{
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}

//选择参数的代理方法
-(void)selectedIndex:(NSString *)selectedParamer{
    //
}


#pragma mark - 开关量设置
//- (void)binarySheetWith:(UIButton *)button{
//
//    NSArray *arr;
//
//    if (button.tag == 10) {
//        arr = @[@"逻辑或",@"逻辑与"];
//    }
//    else if (button.tag>10){
//        arr = @[@"打开",@"关闭"];
//    }
//    else if (button.tag<10){
//        arr = @[@"开放",@"闭锁"];
//    }
//    
//   
//}

-(void)buttonAction:(UIButton *)sender{

    if (sender.tag == 101) {
        //确定
        WeakSelf;
        for (NSInteger i = 0; i<self.generTableView.modelArr.count; i++) {
            NSMutableArray *subArr = self.generTableView.modelArr[i];
            [subArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                GeneralParaModel *model = (GeneralParaModel *)obj;
                ((GeneralParaModel *)weakself.generModelArray[i][idx]).param = model.param;
             
            }];
        }
        [self goBack];
        
    } else {
        //取消
        
        [self closeGeneralParaView];
    }
}
-(void)closeView:(UIButton *)sender{
    [self closeGeneralParaView];
}


@end
