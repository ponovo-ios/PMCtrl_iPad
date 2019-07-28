//
//  BD_SMVWeakSignalMapBaseView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/12.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_SMVDetailSettingWeakSignalMapBaseView.h"
#import "BD_SMVWeaksignalOutputCell1.h"
#import "BD_PopListViewManager.h"
#import "UITextField+Extension.h"
@interface BD_SMVDetailSettingWeakSignalMapBaseView()<UITableViewDelegate,UITableViewDataSource,BD_SMVWeaksignalChangePassagewayMapDelegate>
@end

@implementation BD_SMVDetailSettingWeakSignalMapBaseView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = ClearColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = ClearColor;
    _tableView.scrollEnabled = NO;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BD_SMVWeaksignalOutputCell1 class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BD_SMVWeaksignalOutputCell1ID"];
    
    [_weakSignalBtn setImage:BD_UnSelectedImage forState:UIControlStateNormal];
    [_weakSignalBtn setImage:BD_SelectedImage forState:UIControlStateSelected];
    [_CTChangeTF1 setDefaultSetting];
    [_CTChangeTF2 setDefaultSetting];
    [_PTChangeTF1 setDefaultSetting];
    [_PTChangeTF2 setDefaultSetting];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BD_SMVWeaksignalOutputCell1 *cell = [self.tableView dequeueReusableCellWithIdentifier:@"BD_SMVWeaksignalOutputCell1ID" forIndexPath:indexPath];
    cell.cell1delegate = self;
    
    cell.contentView.backgroundColor = ClearColor;
    cell.passagewayNumLabel1.text = [NSString stringWithFormat:@"%zd",indexPath.row+1];
    [cell.passagewayMap1 setTitle:@"0" forState:UIControlStateNormal];
    cell.passagewayNumLabel2.text = [NSString stringWithFormat:@"%zd",indexPath.row+1+[tableView numberOfRowsInSection:indexPath.section]];
    [cell.passagewayMap2 setTitle:@"0" forState:UIControlStateNormal];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (IBAction)isSelectedWeaksingalMap:(id)sender {
    [_weakSignalBtn setSelected:!_weakSignalBtn.selected];
}

//按钮点击事件代理方法
-(void)changepassageWayMap1:(NSInteger)index sourceView:(UIButton *)sourceView{
    [BD_PopListViewManager ShowPopViewWithlistDataSource:@[@"0",@"Ua'",@"Ub'",@"Uc'",@"Ia'",@"Ib'",@"Ic'"] textField:sourceView viewController:[self GetSubordinateControllerForSelf]  complete:^(NSString *title) {
        [sourceView setTitle:title forState:UIControlStateNormal];
    }];
}
-(void)changepassageWayMap2:(NSInteger)index sourceView:(UIButton *)sourceView{
    [BD_PopListViewManager ShowPopViewWithlistDataSource:@[@"0",@"Ua'",@"Ub'",@"Uc'",@"Ia'",@"Ib'",@"Ic'"] textField:sourceView viewController:[self GetSubordinateControllerForSelf]  complete:^(NSString *title) {
        [sourceView setTitle:title forState:UIControlStateNormal];
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
