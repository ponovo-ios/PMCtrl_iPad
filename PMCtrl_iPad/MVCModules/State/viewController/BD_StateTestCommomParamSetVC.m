//
//  BD_StateTestCommomParamSetVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/1/5.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_StateTestCommomParamSetVC.h"
#import "BD_QuickTestComParamCell.h"
#import "BD_PopListViewManager.h"
@interface BD_StateTestCommomParamSetVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,weak)UIView *commonView;
@property(nonatomic,strong)BD_StateTestCommonParamModel *resultParam;
@end

@implementation BD_StateTestCommomParamSetVC

-(instancetype)init{
    
    if (self = [super init]) {
        [self configTBView];
    }
    return self;
}
-(void)configTBView{
    
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    UIButton *closeBtn = [[UIButton alloc]init];
    closeBtn.frame = CGRectMake(self.view.width-50,10, 35.0, 35.0);
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    
    WeakSelf;
    
    UIView *commonView = [[UIView alloc]initWithFrame:CGRectZero];
    self.commonView = commonView;
    self.commonView.center = self.view.center;
    self.commonView.backgroundColor = BDThemeColor;
    [self.view addSubview:self.commonView];
    
    
    
    UIButton *okBtn = [[UIButton alloc]init];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setCorenerRadius:8 borderColor:BtnViewBorderColor borderWidth:1.0];
    okBtn.tag = 101;
    [okBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.commonView addSubview:okBtn];
    
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
    [self.commonView addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(okBtn.mas_width);
        make.left.mas_equalTo(okBtn.mas_right).offset(10);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(-10);
    }];
    
   
   UITableView * tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = BDThemeColor;
    tableView.tableFooterView = [UIView new];
    tableView.bounces = NO;
    tableView.scrollEnabled = YES;
    [self.commonView addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.center.mas_equalTo(weakself.commonView.center);
        make.bottom.mas_equalTo(okBtn.mas_top).offset(-10);
    }];
    [tableView registerNib:[UINib nibWithNibName:@"BD_QuickTestComParamCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BD_QuickTestComParamCellID"];
    self.tableView = tableView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 4;
            break;
            
        default:
            break;
    }
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.tableView.width, 35)];
        UILabel *title = [[UILabel alloc]init];
        title.text = @"系统配置";
        title.textColor = White;
        headerView.backgroundColor = ClearColor;
        [headerView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(headerView.mas_left).offset(10);
            [make centerYWithinMargins];
            
        }];
        return headerView;
    }
    return nil;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BD_QuickTestComParamCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BD_QuickTestComParamCellID" forIndexPath:indexPath];
    cell.contentView.backgroundColor = BDThemeColor;
    cell.celltitle.text = @[@[@"额定线电压(V)",@"额定电流(A)",@"额定频率(Hz)"],@[@"开入翻转参考状态",@"叠加衰减直流分量",@"衰减时间常数",@"循环次数"]][indexPath.section][indexPath.row];
    cell.cellIndex = indexPath;
    cell.ratedVoltageMax = _ratedVoltageMax;
    cell.ratedCurrentMax = _ratedCurrentMax;
    cell.cellvalue.text = @[@[self.paramDataModel.nominalVoltage,self.paramDataModel.nominalCurrent,self.paramDataModel.ratedPower],@[self.paramDataModel.binaryChangeState==0?@"第一个状态":@"上一个状态",[self booToString:self.paramDataModel.reduceCocurrent],self.paramDataModel.reduceTime,self.paramDataModel.cycleIndex]][indexPath.section][indexPath.row];
    
    if (indexPath.section == 1 && (indexPath.row == 0||indexPath.row == 1)) {
        cell.cellBtn.hidden = NO;
    } else {
        cell.cellBtn.hidden = YES;
    }
    WeakSelf;
    
    cell.popViewBlock = ^(NSIndexPath *cellindex, UITextField *tf) {
        if (cellindex.row == 0 && cellindex.section == 1) {
            [BD_PopListViewManager ShowPopViewWithlistDataSource:@[@"第一个状态",@"上一个状态"] textField:tf viewController:self direction:UIPopoverArrowDirectionUp complete:^(NSString *selectedStr) {
                tf.text = selectedStr;
                weakself.resultParam.binaryChangeState = [weakself stringToInt:selectedStr];
            }];
        } else if (cellindex.row == 1 && cellindex.section == 1) {
            [BD_PopListViewManager ShowPopViewWithlistDataSource:@[@"是",@"否"] textField:tf viewController:self direction:UIPopoverArrowDirectionUp complete:^(NSString *selectedStr) {
                tf.text = selectedStr;
               weakself.resultParam.reduceCocurrent = [weakself stringToBool:selectedStr];
            }];
        }
    };
    
    cell.textFieldChangedBlock = ^(NSIndexPath *indexPath, NSString *tftext) {
        //修改输入框内容
        if (indexPath.section == 0) {
            switch (indexPath.row) {
                case 0:
                    weakself.resultParam.nominalVoltage = tftext;
                    break;
                case 1:
                    weakself.resultParam.nominalCurrent = tftext;
                    break;
                case 2:
                    weakself.resultParam.ratedPower = tftext;
                    break;
                default:
                    break;
            }
        } else if (indexPath.section == 1){
            switch (indexPath.row) {
                case 2:
                    weakself.resultParam.reduceTime = tftext;
                    break;
                case 3:
                    weakself.resultParam.cycleIndex = tftext;
                    break;
                default:
                    break;
            }
        }
    };
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 35;
            break;
        case 1:
            return 10;
            break;
        default:
            break;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return  0.01;
}


#pragma mark - 懒加载
-(BD_StateTestCommonParamModel *)paramDataModel{
    if (!_paramDataModel) {
        _paramDataModel = [[BD_StateTestCommonParamModel alloc]init];
    }
    return _paramDataModel;
}
-(BD_StateTestCommonParamModel *)resultParam{
    if (!_resultParam) {
        _resultParam = [[BD_StateTestCommonParamModel alloc]init];
    }
    return _resultParam;
}
-(NSString *)booToString:(BOOL)boolvalue{
    if (boolvalue) {
        return @"是";
    } else {
        return @"否";
    }
}
-(BOOL)stringToBool:(NSString *)stringValue{
    if ([stringValue isEqualToString:@"是"]) {
        return YES;
    } else if ([stringValue isEqualToString:@"否"]) {
        return NO;
    } else {
        return YES;
    }
}
-(int)stringToInt:(NSString *)stringValue{
    if ([stringValue isEqualToString:@"第一个状态"]) {
        return 0;
    } else if ([stringValue isEqualToString:@"上一个状态"]){
        return 1;
    } else {
        return 0;
    }
}


-(void)showCommomParaView{
    WeakSelf;
    UIViewController *window = [[UIApplication sharedApplication]keyWindow].rootViewController;
    [window.view addSubview:self.view];
    [UIView animateWithDuration:0.3 animations:^{
        
        weakself.commonView.frame = CGRectMake(0, 0, self.view.width*0.5,self.view.height*0.8);
        weakself.commonView.center = weakself.view.center;
        [weakself.tableView reloadData];
        [weakself.commonView layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
        
    }];
}

-(void)closeCommomParaView{
    WeakSelf;
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *window = [[UIApplication sharedApplication]keyWindow].rootViewController;
        [window.view addSubview:self.view];
        [UIView animateWithDuration:0.3 animations:^{
            [weakself.tableView reloadData];
            weakself.commonView.frame = CGRectZero;
            weakself.commonView.center = weakself.view.center;
            [weakself.commonView layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            
            [self.view removeFromSuperview];
        }];
        
    });
}


-(void)buttonAction:(UIButton *)sender{
    
    if (sender.tag == 101) {
        //确定
        self.paramDataModel.nominalVoltage = self.resultParam.nominalVoltage;
        self.paramDataModel.nominalCurrent = self.resultParam.nominalCurrent;
        self.paramDataModel.ratedPower = self.resultParam.ratedPower ;
        self.paramDataModel.binaryChangeState =  self.resultParam.binaryChangeState;
        self.paramDataModel.reduceTime = self.resultParam.reduceTime;
        self.paramDataModel.reduceCocurrent = self.resultParam.reduceCocurrent;
        self.paramDataModel.cycleIndex = self.resultParam.cycleIndex;
        [self closeCommomParaView];
    } else {
        //取消
        [self closeCommomParaView];
    }
}
-(void)closeView:(UIButton *)sender{
    [self closeCommomParaView];
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
