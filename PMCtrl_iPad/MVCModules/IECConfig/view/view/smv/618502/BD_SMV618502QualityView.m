//
//  BD_SMV618502QualityView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/14.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_SMV618502QualityView.h"
#import "UITextField+Extension.h"
#import "BD_SMV618502QualityCell.h"
#import "BD_PopListViewManager.h"
@interface BD_SMV618502QualityView()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;
@property (weak, nonatomic) IBOutlet UIButton *isallPassagewaySelectedBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *binaryBtn;
@property (weak, nonatomic) IBOutlet UITextField *binaryTF;


@end

@implementation BD_SMV618502QualityView

-(void)awakeFromNib{
    [super awakeFromNib];
    [_okBtn setCorenerRadius:6 borderColor:BtnViewBorderColor borderWidth:1.0];
    [_okBtn setTitleColor:White forState:UIControlStateNormal];
    
    [_cancelBtn setCorenerRadius:6 borderColor:BtnViewBorderColor borderWidth:1.0];
    [_cancelBtn setTitleColor:White forState:UIControlStateNormal];
    
    [_binaryTF setDefaultSetting];
    [_binaryTF setCorenerRadius:6 borderColor:Black borderWidth:1.0];
    [_binaryBtn setTitleColor:White forState:UIControlStateNormal];
    [_binaryBtn setCorenerRadius:6 borderColor:BtnViewBorderColor borderWidth:1.0];
    
    [_isallPassagewaySelectedBtn setImage:BD_SelectedImage forState:UIControlStateSelected];
     [_isallPassagewaySelectedBtn setImage:BD_UnSelectedImage forState:UIControlStateNormal];
    [_isallPassagewaySelectedBtn setSelected:NO];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = ClearColor;
    [_tableView registerNib:[UINib nibWithNibName:@"BD_SMV618502QualityCell" bundle:nil] forCellReuseIdentifier:@"BD_SMV618502QualityCellID"];
    _tableView.bounces = NO;
    
}
- (IBAction)okAction:(id)sender {
    self.okBlock();
}



- (IBAction)cancelAction:(id)sender {
    self.cancelBlock();
}


- (IBAction)changeAllPassageway:(id)sender {
    [_isallPassagewaySelectedBtn setSelected:!_isallPassagewaySelectedBtn.selected];
}

- (IBAction)binaryChangedAction:(id)sender {
    [BD_PopListViewManager ShowPopViewWithlistDataSource:@[@"二进制",@"十进制",@"十六进制"] textField:_binaryBtn viewController:[self GetSubordinateControllerForSelf] direction:UIPopoverArrowDirectionUp complete:^(NSString *title) {
        [_binaryBtn setTitle:title forState:UIControlStateNormal];
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 4;
            break;
        case 1:
            return 8;
            
        default:
            break;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = self.backgroundColor;
    
    UILabel *titleLabel1 = [[UILabel alloc] init];
    titleLabel1.textAlignment = NSTextAlignmentCenter;
    titleLabel1.textColor = RGB(31.0,57.0, 57.0);
    titleLabel1.font = [UIFont systemFontOfSize:17];
    titleLabel1.text = @[@"setting(设置)",@"detailQual(详细设置)"][section];
    
    [headerView addSubview:titleLabel1];
    
    [titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(10);
    }];
    return headerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BD_SMV618502QualityCell *cell1 = [self.tableView dequeueReusableCellWithIdentifier:@"BD_SMV618502QualityCellID" forIndexPath:indexPath];
    cell1.contentView.backgroundColor = ClearColor;
    cell1.backgroundColor = ClearColor;
    cell1.title.text = @[@[@"validity(有效)[bit0-1]",@"source(源)[bit10]",@"test(测试)[bit11]",@"bpb(操作员闭锁)[bit12]"],@[@"overflow(溢出)[bit2]",@"outofrange(超值域)[bit3]",@"badReference(坏基准值)[bit4]",@"oscillatory(抖动)[bit5]",@"failure(故障)[bit6]",@"oldData(旧数据)[bit7]",@"inconsisitent(不一致)[bit8]",@"inaccurate(不精确)[bit9]"]][indexPath.section][indexPath.row];
  
    NSString * btnTitle = @[@[@"10:reserved(保留)",@"1:substituted(被取代",@"0:运行",@"0:不闭锁"],@[@"0:无溢出",@"0:正常",@"0:正常",@"0:无抖动",@"0:无故障",@"0:无超时",@"一致",@"精确"]][indexPath.section][indexPath.row];
    [cell1.valueBtn setTitle:[[@"  " stringByAppendingString:btnTitle] stringByAppendingString:@"  "] forState:UIControlStateNormal];
    cell1.cellIndexpath = indexPath;
    cell1.qualityValueChangeBlock = ^(NSIndexPath *cellIndexPath, UIButton *valueBtn) {
        if (cellIndexPath.section == 0) {
            switch (indexPath.row) {
                case 0:
                    [self cellBlockAction:valueBtn array:@[@"00:good(好)",@"01:invalid(无效)",@"10:reserved(保留)",@"11:questionable(可疑)"]];
                    break;
                case 1:
                    [self cellBlockAction:valueBtn array:@[@"0:process(过程)",@"1:substituted(被取代)"]];
                    break;
                case 2:
                    [self cellBlockAction:valueBtn array:@[@"0:运行",@"1:测试"]];
                    break;
                case 3:
                    [self cellBlockAction:valueBtn array:@[@"0:不闭锁",@"1:闭锁"]];
                    break;
                default:
                    break;
            }
        } else if (cellIndexPath.section == 1){
            switch (indexPath.row) {
                case 0:
                    [self cellBlockAction:valueBtn array:@[@"0:无溢出",@"1:溢出"]];
                    break;
                case 1:
                    [self cellBlockAction:valueBtn array:@[@"0:正常",@"1:超值域"]];
                    break;
                case 2:
                    [self cellBlockAction:valueBtn array:@[@"0:正常",@"1:坏基准值"]];
                    break;
                case 3:
                    [self cellBlockAction:valueBtn array:@[@"0:无抖动",@"1:有抖动"]];
                    break;
                case 4:
                    [self cellBlockAction:valueBtn array:@[@"0:无故障",@"1:有故障"]];
                    break;
                case 5:
                    [self cellBlockAction:valueBtn array:@[@"0:无超时",@"1:数据超时"]];
                    break;
                case 6:
                    [self cellBlockAction:valueBtn array:@[@"0:一致",@"1:不一致"]];
                    break;
                case 7:
                    [self cellBlockAction:valueBtn array:@[@"0:精确",@"1:不精确"]];
                    break;
                default:
                    break;
            }
        }
    };
    return  cell1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}


-(void)cellBlockAction:(UIButton *)sourceView array:(NSArray *)array{
    [BD_PopListViewManager ShowPopViewWithlistDataSource:array textField:sourceView viewController:[self GetSubordinateControllerForSelf] direction:UIPopoverArrowDirectionUp complete:^(NSString *title) {
        [sourceView setTitle:[[@"  "stringByAppendingString:title] stringByAppendingString:@"  " ] forState:UIControlStateNormal];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
