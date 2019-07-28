//
//  BD_QuickTestIECView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/13.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_QuickTestIECView.h"
#import "BD_QuickTestParamCell.h"
#import "BD_QuickTestIECParamCell1.h"
#import "BD_QuickTestIECParamCell2.h"

@interface BD_QuickTestIECView()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *titleArr;
    NSArray *valueArr;
    NSArray *unitArr;
    
}
@property (weak, nonatomic) IBOutlet UIButton *paramSetBtn;
@property (weak, nonatomic) IBOutlet UIButton *SMVBtn;
@property (weak, nonatomic) IBOutlet UIButton *GooseSendBtn;
@property (weak, nonatomic) IBOutlet UIButton *GooseBookBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end


@implementation BD_QuickTestIECView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = MainBgColor;
    [self.tableView registerNib:[UINib nibWithNibName:@"BD_QuickTestIECParamCell1" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BD_QuickTestIECParamCell1ID"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BD_QuickTestIECParamCell2" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BD_QuickTestIECParamCell2ID"];

    //gooseBookSelected googseSendSelected smvSendSelected paramsettingSelected
    [_paramSetBtn setImage:[UIImage imageNamed:@"paramsetting"] forState:UIControlStateNormal];
    [_paramSetBtn setImage:[UIImage imageNamed:@"paramsettingSelected"] forState:UIControlStateSelected];
    
    [_GooseBookBtn setImage:[UIImage imageNamed:@"googseBook"] forState:UIControlStateNormal];
    [_GooseBookBtn setImage:[UIImage imageNamed:@"googseBookSelected"] forState:UIControlStateSelected];
    
    [_GooseSendBtn setImage:[UIImage imageNamed:@"googseSend"] forState:UIControlStateNormal];
    [_GooseSendBtn setImage:[UIImage imageNamed:@"googseSendSelected"] forState:UIControlStateSelected];
    
    [_SMVBtn setImage:[UIImage imageNamed:@"smvSend"] forState:UIControlStateNormal];
    [_SMVBtn setImage:[UIImage imageNamed:@"smvSendSelected"] forState:UIControlStateSelected];
  
    titleArr = @[@[@"额定线电压",@"额定功率"],@[@"额定电流",@"开入防抖时间"],@[@"输出选择",@"弱信号输出设置"]];
    valueArr = @[@[@"100.000",@"50.000"],@[@"1.000",@"0"],@[@"IEC850-9-2",@"弱信号不输出"]];
    unitArr = @[@[@"V",@"Hz"],@[@"A",@"ms"],@[@"▼",@"▼"]];
    
    [_btncontentView setCorenerRadius:10.0 borderColor:BtnViewBorderColor borderWidth:2.0];
    _btncontentView.backgroundColor = ClearColor;
    [self readDefaultDataFromPlist];
    
}


- (IBAction)setParam:(id)sender {
    
    [self changeBtnStatesToParamBtn:YES googseSend:NO googseBook:NO SMV:NO];

}

- (IBAction)sendSMV:(id)sender {

[self changeBtnStatesToParamBtn:NO googseSend:NO googseBook:NO SMV:YES];

}
- (IBAction)sendGoose:(id)sender {
    
    [self changeBtnStatesToParamBtn:NO googseSend:YES googseBook:NO SMV:NO];
    
}


- (IBAction)bookGoose:(id)sender {
    
    [self changeBtnStatesToParamBtn:NO googseSend:NO googseBook:YES SMV:NO];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 60;
            break;
            
        case 1:
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
            return 3;
            break;
        case 1:
            return _iecParamDS.count;
            break;
        default:
            break;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    
    UITableViewCell *cell;
    if (indexPath.section ==  0) {
        
          BD_QuickTestIECParamCell1 *cell1 = [self.tableView dequeueReusableCellWithIdentifier:@"BD_QuickTestIECParamCell1ID" forIndexPath:indexPath];
        if (indexPath.row!=2) {
            cell1.valueBtn1.hidden = YES;
            cell1.valueBtn2.hidden = YES;
            
        } else {
            cell1.valueBtn1.hidden = NO;
            cell1.valueBtn2.hidden = NO;
            cell1.value1BtnClickBlock = ^(UITextField *tf) {
                [self row:@[@"11",@"22"] textField:tf];
            };
        }
        
        
        cell1.title1.text = titleArr[indexPath.row][0];
        cell1.title2.text = titleArr[indexPath.row][1];
        
        cell1.value1.text = valueArr[indexPath.row][0];
        cell1.value2.text = valueArr[indexPath.row][1];
        cell1.unit1.text = unitArr[indexPath.row][0];
        cell1.unit2.text = unitArr[indexPath.row][1];
        
        cell = cell1;
    } else {
     
        BD_QuickTestIECParamCell2 *cell2 = [self.tableView dequeueReusableCellWithIdentifier:@"BD_QuickTestIECParamCell2ID" forIndexPath:indexPath];
        cell2.cellTitle.text = @[@"第一组(Ua,Ub,Uc,Ia,Ib,Ic/报文测试光口A)",@"第er组(Ua',Ub',Uc',Ia',Ib',Ic'/报文测试光口B)",@"第三组(Usa,Usb,Usc,Isa,Isb,Isc/报文测试光口C)",@"第四组(Uta,Utb,Utc,Ita,Itb,Itc/报文测试光口D)"][indexPath.row];
        cell2.PTvoltage1.text = [NSString stringWithFormat:@"%.3f",_iecParamDS[indexPath.row].PT1];
        cell2.PTvoltage2.text = kTStrings(_iecParamDS[indexPath.row].PT2);
        cell2.CTcurrent1.text = kTStrings(_iecParamDS[indexPath.row].CT1);
        cell2.CTcurrent2.text = kTStrings(_iecParamDS[indexPath.row].CT2);
        cell = cell2;
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


-(void)changeBtnStatesToParamBtn:(BOOL)paramBtn googseSend:(BOOL)googseSend googseBook:(BOOL)googseBook SMV:(BOOL)SMV{
    _paramSetBtn.selected = paramBtn;
    _GooseSendBtn.selected = googseSend;
    _GooseBookBtn.selected = googseBook;
    _SMVBtn.selected = SMV;
}

#pragma mark - 懒加载
-(NSMutableArray *)iecParamDS{
    if (!_iecParamDS) {
        _iecParamDS = [[NSMutableArray alloc]init];
    }
    return  _iecParamDS;
}




- (void)row:(NSArray *)arr textField:(UITextField *)tf{
    
    //1.创建控制器
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //2.创建选项
    UIAlertAction *onePointAction = [UIAlertAction actionWithTitle:arr[0] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        tf.text = arr[0];
//        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }];
    
    UIAlertAction *twoPointAction = [UIAlertAction actionWithTitle:arr[1] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        tf.text = arr[1];
//        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }];
    
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    //3.添加选项
    [alertController addAction:onePointAction];
    [alertController addAction:twoPointAction];
    //    [alertController addAction:threePointAction];
    [alertController addAction:alertAction];
    
    alertController.modalPresentationStyle = UIModalPresentationPopover;
    alertController.preferredContentSize = CGSizeMake(tf.bounds.size.width, 240);
    
    UIPopoverPresentationController *popPresenter = alertController.popoverPresentationController;
    popPresenter.sourceView = tf;
    popPresenter.sourceRect = tf.bounds;
    popPresenter.permittedArrowDirections = UIPopoverArrowDirectionUp; //设置弹出方向
    
    [[self GetSubordinateControllerForSelf] presentViewController:alertController animated:NO completion:nil];
}

/*
 
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
