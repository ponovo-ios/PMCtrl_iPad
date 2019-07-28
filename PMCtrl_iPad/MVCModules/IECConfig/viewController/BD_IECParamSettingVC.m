//
//  BD_IECParamSettingVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/23.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_IECParamSettingVC.h"
#import "BD_QuickTestParamCell.h"
#import "BD_QuickTestIECParamCell1.h"
#import "BD_QuickTestIECParamCell2.h"
#import "BD_IECParamCell3.h"
@interface BD_IECParamSettingVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *titleArr;
    NSArray *valueArr;
    NSArray *unitArr;
    
}

@end

@implementation BD_IECParamSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    self.tableView.backgroundColor = MainBgColor;
    [self.tableView registerNib:[UINib nibWithNibName:@"BD_QuickTestIECParamCell1" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BD_QuickTestIECParamCell1ID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BD_QuickTestIECParamCell2" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BD_QuickTestIECParamCell2ID"];
       [self.tableView registerNib:[UINib nibWithNibName:@"BD_IECParamCell3" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BD_IECParamCell3ID"];
//    [self.tableView setCorenerRadius:10 borderColor:BtnViewBorderColor borderWidth:2.0];
    
    titleArr = @[@[@"额定线电压",@"额定频率"],@[@"额定电流",@"开入防抖时间"],@[@"输出选择",@"弱信号输出设置"],@[@"产品型号",@""]];
    valueArr = @[@[@"100.000",@"50.000"],@[@"1.000",@"0"],@[@"IEC850-9-2",@"弱信号不输出"],@[@"PNI302",@""]];
    unitArr = @[@[@"V",@"Hz"],@[@"A",@"ms"],@[@"▼",@"▼"],@[@"▼",@""]];
    
    [self readDefaultDataFromPlist];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 60;
            break;
            
        case 1:
            return 80;
            break;
        case 2:
            return 80;
            break;
        default:
            break;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = ClearColor;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return titleArr.count;
            break;
        case 1:
            return _iecParamDS.count;
            break;
        case 2:
            return 4;
        default:
            break;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    if (indexPath.section ==  0) {
        
        BD_QuickTestIECParamCell1 *cell1 = [self.tableView dequeueReusableCellWithIdentifier:@"BD_QuickTestIECParamCell1ID" forIndexPath:indexPath];
        if (indexPath.row<2) {
            cell1.valueBtn1.hidden = YES;
            cell1.valueBtn2.hidden = YES;
        } else {
            cell1.valueBtn1.hidden = NO;
            cell1.valueBtn2.hidden = NO;
            cell1.value1BtnClickBlock = ^(UITextField *tf1) {
                switch (indexPath.row) {
                    case 2:
//                        [self row:@[] textField:tf1 title:titleArr[indexPath.row][0]];
                        break;
                    case 3:
                         [self row:@[@"PNI302",@"PW800"] textField:tf1 title:titleArr[indexPath.row][0]];
                        break;
                    default:
                        break;
                }
            };
            cell1.value2BtnClickBlock = ^(UITextField *tf2) {
               
            };
        }
        
        
        cell1.title1.text = titleArr[indexPath.row][0];
        cell1.title2.text = titleArr[indexPath.row][1];
        
        cell1.value1.text = valueArr[indexPath.row][0];
        cell1.value2.text = valueArr[indexPath.row][1];
        cell1.unit1.text = unitArr[indexPath.row][0];
        cell1.unit2.text = unitArr[indexPath.row][1];
        if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
            cell1.value2.hidden = YES;
            cell1.valueBtn2.hidden = YES;
        } else{
            cell1.value2.hidden = NO;
            cell1.valueBtn2.hidden = NO;
        }
        cell = cell1;
    } else if (indexPath.section == 1) {
        
        BD_QuickTestIECParamCell2 *cell2 = [self.tableView dequeueReusableCellWithIdentifier:@"BD_QuickTestIECParamCell2ID" forIndexPath:indexPath];
        cell2.cellTitle.text = @[@"第一组(Ua,Ub,Uc,Ia,Ib,Ic/报文测试光口A)",@"第er组(Ua',Ub',Uc',Ia',Ib',Ic'/报文测试光口B)",@"第三组(Usa,Usb,Usc,Isa,Isb,Isc/报文测试光口C)",@"第四组(Uta,Utb,Utc,Ita,Itb,Itc/报文测试光口D)"][indexPath.row];
        cell2.PTvoltage1.text = [NSString stringWithFormat:@"%.3f",_iecParamDS[indexPath.row].PT1];
        cell2.PTvoltage2.text = kTStrings(_iecParamDS[indexPath.row].PT2);
        cell2.CTcurrent1.text = kTStrings(_iecParamDS[indexPath.row].CT1);
        cell2.CTcurrent2.text = kTStrings(_iecParamDS[indexPath.row].CT2);
        cell = cell2;
    } else {
        if (indexPath.row <3) {
            BD_IECParamCell3 *cell3 = [self.tableView dequeueReusableCellWithIdentifier:@"BD_IECParamCell3ID" forIndexPath:indexPath];
            NSArray *section3TitleArr = @[@"B码逻辑",@"光纤连接",@"IEC61588同步机制"];
            NSArray *section3ValueArr = @[@[@"正逻辑",@"负逻辑"],@[@"双回",@"单回"],@[@"对等延时",@"延时请求-响应"]];
            cell3.cellTitle.text = section3TitleArr[indexPath.row];
            cell3.cellValue1.text = section3ValueArr[indexPath.row][0];
            cell3.cellValue2.text = section3ValueArr[indexPath.row][1];
            cell3.radioSelectedBlock = ^(int index) {
                //用户选择的是哪一项
                
            };
            cell = cell3;
        } else {
            BD_QuickTestIECParamCell1 *cell1 = [self.tableView dequeueReusableCellWithIdentifier:@"BD_QuickTestIECParamCell1ID" forIndexPath:indexPath];
                cell1.valueBtn1.hidden = NO;
                cell1.valueBtn2.hidden = NO;
                cell1.value1BtnClickBlock = ^(UITextField *tf) {
                    [self row:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"] textField:tf title:@"IEC588接收口"];
                };

            cell1.title1.text = @"IEC588接收口:   光口:";
            cell1.title2.text = @"";
            cell1.value1.text = @"8";
            cell1.value2.hidden = YES;
            cell1.valueBtn2.hidden = YES;
            cell1.unit1.text = @"▼";
            cell1.unit2.text = @"";
            cell1.value1.clearButtonMode = UITextFieldViewModeNever;
            cell = cell1;
        }
       
    }
    return  cell;
}

#pragma mark - 从plist文件中读取默认设置的参数
-(void)readDefaultDataFromPlist{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSArray *dictArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"QuickTestIECParam" ofType:@".plist"]];
        NSMutableArray *TVdatas = [NSMutableArray arrayWithCapacity:dictArr.count];
        
        for (NSDictionary *dict in dictArr) {
            
            BD_QuickTestIECParam_ChangeRateModel *peopleList = [BD_QuickTestIECParam_ChangeRateModel groupWithDict:dict];
            [TVdatas addObject:peopleList];
        }
        
        _iecParamDS = TVdatas;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    });
    
    
}

#pragma mark - 懒加载
-(NSMutableArray *)iecParamDS{
    if (!_iecParamDS) {
        _iecParamDS = [[NSMutableArray alloc]init];
    }
    return  _iecParamDS;
}




- (void)row:(NSArray *)arr textField:(UITextField *)tf title:(NSString *)title{
    
    //1.创建控制器
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //2.创建选项
    for (int i = 0; i<arr.count; i++) {
        UIAlertAction *onePointAction = [UIAlertAction actionWithTitle:arr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            tf.text = arr[i];
       
        }];
        [alertController addAction:onePointAction];
    }

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    alertController.modalPresentationStyle = UIModalPresentationPopover;
    alertController.preferredContentSize = CGSizeMake(tf.bounds.size.width, 240);
    
    UIPopoverPresentationController *popPresenter = alertController.popoverPresentationController;
    popPresenter.sourceView = tf;
    popPresenter.sourceRect = tf.bounds;
    if ([title isEqualToString:@"IEC588接收口"]) {
        popPresenter.permittedArrowDirections = UIPopoverArrowDirectionDown; //设置弹出方向
    } else {
        popPresenter.permittedArrowDirections = UIPopoverArrowDirectionUp; //设置弹出方向
    }
    
    
    [self presentViewController:alertController animated:NO completion:nil];
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
