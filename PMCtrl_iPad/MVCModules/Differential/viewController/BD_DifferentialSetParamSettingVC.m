//
//  BD_DifferentialSetParamSettingVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/10.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_DifferentialSetParamSettingVC.h"
#import "BD_DifferentialSetTBView.h"
#import "SettingValueModel.h"
#import "IQKeyboardManager.h"
#import "BD_DifferSetDataModel.h"
@interface BD_DifferentialSetParamSettingVC (){
     NSMutableArray<SettingValueModel *> *setBackModelArr;
}
@property (nonatomic, weak) BD_DifferentialSetTBView * setTableView;

@property (nonatomic,strong)UIView *setView;
@end

@implementation BD_DifferentialSetParamSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化block返回的数据
    
    setBackModelArr = [[NSMutableArray alloc]init];

    [self setupView];

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
-(void)TBViewEndEditing{

    [self.setTableView endEditing];
    [self.setTableView reloadData];
}

- (void)goBack{
    WeakSelf;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
/**--------------------整定值plist文件保存到沙盒，暂时不用-------------------------------
//
//        [FileUtil deleteFileWithPath:@"settingValue.plist"];
//
//        NSMutableArray *settingArr = [[NSMutableArray alloc]init];
//        for (SettingValueModel *model in setBackModelArr) {
//            NSDictionary *dic = @{@"name":model.name,@"val":model.val};
//            [settingArr addObject:dic];
//        }
//
//        [FileUtil saveInfoToPlist:@"settingValue.plist" dic:@{@"settingValue":settingArr}];
-----------------------------------------------------------------------*/
       
        
        if ([setBackModelArr[0].val isEqualToString:@"有名值"]) {
            self.setDataModel.Axis = 0;
        } else if ([setBackModelArr[0].val isEqualToString:@"标幺值"]) {
            self.setDataModel.Axis = 1;
        }
        
        if ([setBackModelArr[1].val isEqualToString:@"高侧额定二次电流"]) {
            self.setDataModel.Insel = 0;
        } else if ([setBackModelArr[1].val isEqualToString:@"其它"]) {
            self.setDataModel.Insel = 1;
        }
        
        if ([setBackModelArr[5].val isEqualToString:@"一个拐点"]) {
             self.setDataModel.KneePoint = 1;
        } else if ([setBackModelArr[5].val isEqualToString:@"两个拐点"]) {
             self.setDataModel.KneePoint = 2;
        } else if ([setBackModelArr[5].val isEqualToString:@"三个拐点"]){
             self.setDataModel.KneePoint = 3;
        }
        
      
        self.setDataModel.Inom = [setBackModelArr[2].val floatValue];
        self.setDataModel.Isd = [setBackModelArr[3].val floatValue];
        self.setDataModel.Icdqd = [setBackModelArr[4].val floatValue];
     
        self.setDataModel.Ip1 = [setBackModelArr[6].val floatValue];
        self.setDataModel.Ip2 = [setBackModelArr[7].val floatValue];
        self.setDataModel.Ip3 = [setBackModelArr[8].val floatValue];
        self.setDataModel.Kid1 = [setBackModelArr[9].val floatValue];
        self.setDataModel.Kid2 = [setBackModelArr[10].val floatValue];
        self.setDataModel.Kid3 = [setBackModelArr[11].val floatValue];
        self.setDataModel.Kid4 = [setBackModelArr[12].val floatValue];
        self.setDataModel.Kxb2 = [setBackModelArr[13].val floatValue];
        self.setDataModel.Kxb3 = [setBackModelArr[14].val floatValue];
        self.setDataModel.Kxb5 = [setBackModelArr[15].val floatValue];
        
        
        if (_okBlock) {
            weakself.okBlock();
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself TBViewEndEditing];
            [weakself closeSetParaView];
        });
    });
                   
}


-(BD_DifferSetDataModel *)setDataModel{
    if (!_setDataModel) {
        _setDataModel = [[BD_DifferSetDataModel alloc]init];
    }
    return _setDataModel;
}

-(NSMutableArray *)setModelArray{
    if (!_setModelArray) {
        _setModelArray = [[NSMutableArray alloc]init];
    }
    return _setModelArray;
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
    
    _setView = [[UIView alloc]initWithFrame:CGRectZero];
    _setView.backgroundColor = BDThemeColor;
    _setView.center = self.view.center;
    [self.view addSubview:_setView];
    
    UIButton *okBtn = [[UIButton alloc]init];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:1.0];
    okBtn.tag = 101;
    [okBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];

    [_setView addSubview:okBtn];
    
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
    [_setView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(okBtn.mas_width);
        make.left.mas_equalTo(okBtn.mas_right).offset(10);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(-10);
    }];
    
    //添加标题
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"整定值";
    titleLabel.textColor = White;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:20];
    [self.setView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.centerX.mas_equalTo(weakself.setView.centerX);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    
    
    
    BD_DifferentialSetTBView *setTableView = [[BD_DifferentialSetTBView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    [self.setModelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [datas addObject:[(SettingValueModel *)obj mutableCopy]];
    }];
    setTableView.modelArr = datas;
    setBackModelArr = setTableView.modelArr;
    
    //    setTableView.pVC = self;
    self.setTableView = setTableView;
    setTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    setTableView.showSettingBlock = ^(UIButton *button) {
        [weakself actionSheetWith:button];
    };
    
    setTableView.settingResultBlock = ^(NSMutableArray *arr){
        setBackModelArr = arr;
    };
    
    [_setView addSubview:self.setTableView];
    [_setTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(5);
        make.center.mas_equalTo(weakself.setView.center);
        make.bottom.mas_equalTo(okBtn.mas_top).offset(-10);
    }];
    
}


-(void)showSetParaView{
    WeakSelf;
    
    [self.setModelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SettingValueModel *model = (SettingValueModel *)obj;
        ((SettingValueModel *)weakself.setTableView.modelArr[idx]).val = model.val;
        ((SettingValueModel *)setBackModelArr[idx]).val = model.val;
    }];
    
    
    UIViewController *window = [[UIApplication sharedApplication]keyWindow].rootViewController;
    [window.view addSubview:self.view];
    [UIView animateWithDuration:0.3 animations:^{
        [weakself.setTableView reloadData];
        weakself.setView.frame = CGRectMake(0, 0, self.view.width*0.8,self.view.height*0.9);

        weakself.setView.center = weakself.view.center;
        [weakself.setView layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        
    }];
}

-(void)closeSetParaView{
    WeakSelf;
    if ([[self.setTableView.modelArr[0] val] isEqualToString:@"有名值"]) {
        [kNotificationCenter postNotificationName:BD_DifferSettingType object:@(0)];
    } else {
        [kNotificationCenter postNotificationName:BD_DifferSettingType object:@(1)];
    }
    UIViewController *window = [[UIApplication sharedApplication]keyWindow].rootViewController;
    [window.view addSubview:self.view];
    [UIView animateWithDuration:0.3 animations:^{
        
        weakself.setView.frame = CGRectZero;
        weakself.setView.center = weakself.view.center;
         [weakself.setView layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        [self.view removeFromSuperview];
    }];
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

#pragma mark - 整定值设置
- (void)actionSheetWith:(UIButton *)button{
    [self.setTableView endEditing];
    NSArray *arr;
    
    switch (button.tag) {
        case 0:
            arr = @[@"有名值",@"标幺值"];
            [self row0:arr button:button];
            break;
        case 1:
            arr = @[@"高侧额定二次电流",@"其它"];
            [self row1:arr button:button];
            break;
        case 5:
            arr = @[@"一个拐点",@"两个拐点",@"三个拐点"];
            [self row5:arr button:button];
            break;
            
        default:
            break;
    }
}
- (void)row0:(NSArray *)arr button:(UIButton *)button{
    [self.setTableView endEditing];
    //1.创建控制器
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //  2.创建选项
    UIAlertAction *SUAction = [UIAlertAction actionWithTitle:arr[0] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.setTableView.modelArr[3] setName: @"差动速断电流定值(A)"];
        [self.setTableView.modelArr[4] setName: @"差动动作电流门槛值(A)"];
        [self.setTableView.modelArr[6] setName: @"比率制动特性拐点1电流(A)"];
        [self.setTableView.modelArr[7] setName: @"比率制动特性拐点2电流(A)"];
        [self.setTableView.modelArr[8] setName: @"比率制动特性拐点3电流(A)"];
        [self.setTableView.modelArr[0] setVal:arr[0]];
        
        [self.setTableView reloadData];
       
    }];
    
    UIAlertAction *famAction = [UIAlertAction actionWithTitle:arr[1] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.setTableView.modelArr[3] setName: @"差动速断电流定值(In)"];
        [self.setTableView.modelArr[4] setName: @"差动动作电流门槛值(In)"];
        [self.setTableView.modelArr[6] setName: @"比率制动特性拐点1电流(In)"];
        [self.setTableView.modelArr[7] setName: @"比率制动特性拐点2电流(In)"];
        [self.setTableView.modelArr[8] setName: @"比率制动特性拐点3电流(In)"];
        
        [self.setTableView.modelArr[0] setVal:arr[1]];
        [self.setTableView.modelArr[1] setVal:@"高侧额定二次电流"];
        
        [self.setTableView reloadData];
        
    }];
    
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    //3.添加选项
    [alertController addAction:SUAction];
    [alertController addAction:famAction];
    [alertController addAction:alertAction];
    
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

- (void)row1:(NSArray *)arr button:(UIButton *)button{
    [self.setTableView endEditing];
    //1.创建控制器
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //2.创建选项
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:arr[0] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.setTableView.modelArr[1] setVal:arr[0]];
        
        [self.setTableView reloadData];
        
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:arr[1] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.setTableView.modelArr[1] setVal:arr[1]];
        
        [self.setTableView reloadData];
    }];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    //3.添加选项
    [alertController addAction:secondAction];
    [alertController addAction:otherAction];
    [alertController addAction:alertAction];
    
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

- (void)row5:(NSArray *)arr button:(UIButton *)button{
    [self.setTableView endEditing];
    //1.创建控制器
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //2.创建选项
    UIAlertAction *onePointAction = [UIAlertAction actionWithTitle:arr[0] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.setTableView.modelArr[5] setVal:arr[0]];
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:BD_KneePointCount];
        [self.setTableView reloadData];
        
    }];
    
    UIAlertAction *twoPointAction = [UIAlertAction actionWithTitle:arr[1] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.setTableView.modelArr[5] setVal:arr[1]];
        [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:BD_KneePointCount];
        [self.setTableView reloadData];
        
    }];
    
    
        UIAlertAction *threePointAction = [UIAlertAction actionWithTitle:arr[2] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
            [self.setTableView.modelArr[5] setVal:arr[2]];
    
            [self.setTableView reloadData];
    
        }];
    
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    //3.添加选项
    [alertController addAction:onePointAction];
    [alertController addAction:twoPointAction];
    [alertController addAction:threePointAction];
    [alertController addAction:alertAction];
    
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


-(void)buttonAction:(UIButton *)sender{
    
    if (sender.tag == 101) {
        //确定
        WeakSelf;
        [self.setTableView.modelArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SettingValueModel *model = (SettingValueModel *)obj;
            ((SettingValueModel *)weakself.setModelArray[idx]).val = model.val;;
        }];
        [self goBack];
      
       
      
       
        
    } else {
        //取消
        [self closeSetParaView];
    }
}
-(void)closeView:(UIButton *)sender{
    [self closeSetParaView];
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
