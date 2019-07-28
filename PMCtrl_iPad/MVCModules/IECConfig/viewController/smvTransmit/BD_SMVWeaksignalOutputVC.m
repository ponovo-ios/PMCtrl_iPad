//
//  BD_SMVWeaksignalOutputVC.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/6.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_SMVWeaksignalOutputVC.h"
#import "BD_QuickTestIECParamCell2.h"
#import "BD_SMVWeaksignalOutputCell1.h"
#import "BD_SMVWeaksignalOutputHeaderView.h"
#import "BD_PopListViewManager.h"
@interface BD_SMVWeaksignalOutputVC ()<UITableViewDataSource,UITableViewDelegate,BD_SMVWeaksignalChangePassagewayMapDelegate>

@property(nonatomic,strong)UITableView *tableView;
@end

@implementation BD_SMVWeaksignalOutputVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainBgColor;
    [self confitTBView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)confitTBView{
    WeakSelf;
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.view.mas_top).offset(10);
        make.bottom.mas_equalTo(weakself.view.mas_bottom).offset(-5);
        make.left.mas_equalTo(weakself.view.mas_left).offset(10);
        make.right.mas_equalTo(weakself.view.mas_right).offset(-10);
    }];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = ClearColor;
//    [self.tableView setCorenerRadius:10 borderColor:BtnViewBorderColor borderWidth:2.0];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BD_QuickTestIECParamCell2 class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BD_QuickTestIECParamCell2ID"];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BD_SMVWeaksignalOutputCell1 class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BD_SMVWeaksignalOutputCell1ID"];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BD_SMVWeaksignalOutputHeaderView class]) bundle:nil] forHeaderFooterViewReuseIdentifier:@"BD_SMVWeaksignalOutputHeaderViewID"];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2 ;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 6;
            break;
        case 1:
            return 4;
            break;
            
        default:
            break;
    }
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 50;
            break;
        case 1:
            return 80;
            
        default:
            break;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 40;
    } else if (section == 1){
        return 0.01;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = ClearColor;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        BD_SMVWeaksignalOutputHeaderView *headerView = [[NSBundle mainBundle]loadNibNamed:@"BD_SMVWeaksignalOutputHeaderView" owner:nil options:nil].lastObject;
        return headerView;
    }
    return [UIView new];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *commonCell;
    if (indexPath.section == 0) {
        BD_SMVWeaksignalOutputCell1 *cell1 = [self.tableView dequeueReusableCellWithIdentifier:@"BD_SMVWeaksignalOutputCell1ID" forIndexPath:indexPath];
        cell1.cell1delegate = self;
        cell1.passagewayNumLabel1.text = [NSString stringWithFormat:@"通道%ld",indexPath.row+1];
        [cell1.passagewayMap1 setTitle:@"0" forState:UIControlStateNormal];
        cell1.passagewayNumLabel2.text = [NSString stringWithFormat:@"通道%ld",indexPath.row+1+[tableView numberOfRowsInSection:indexPath.section]];
        [cell1.passagewayMap2 setTitle:@"0" forState:UIControlStateNormal];
        commonCell = cell1;
    } else {
        
        BD_QuickTestIECParamCell2 *cell2 = [tableView dequeueReusableCellWithIdentifier:@"BD_QuickTestIECParamCell2ID" forIndexPath:indexPath];
        commonCell = cell2;
        
    }
    return commonCell;
   
}

#pragma mark - BD_SMVWeaksignalChangePassagewayMapDelegate
-(void)changepassageWayMap1:(NSInteger)index sourceView:(UIButton *)sourceView{
        [BD_PopListViewManager ShowPopViewWithlistDataSource:@[@"0",@"Ua",@"Ub",@"Uc",@"Ua2",@"Ub2",@"Uc2",@"Ia",@"Ib",@"Ic",@"Ia2",@"Ib2",@"Ic2"] textField:sourceView viewController:self direction:UIPopoverArrowDirectionUp complete:^(NSString *title) {
            [sourceView setTitle:title forState:UIControlStateNormal];
        } ];
 
}

-(void)changepassageWayMap2:(NSInteger)index sourceView:(UIButton *)sourceView{
    [BD_PopListViewManager ShowPopViewWithlistDataSource:@[@"0",@"Ua",@"Ub",@"Uc",@"Ua2",@"Ub2",@"Uc2",@"Ia",@"Ib",@"Ic",@"Ia2",@"Ib2",@"Ic2"] textField:sourceView viewController:self direction:UIPopoverArrowDirectionUp complete:^(NSString *title) {
        [sourceView setTitle:title forState:UIControlStateNormal];
    }];
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
