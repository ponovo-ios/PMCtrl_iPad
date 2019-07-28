//
//  BD_HarmSwitchTableView.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/30.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_HarmSwitchTableView.h"
#import "BD_HarmSwitchCell.h"
#import "BD_HarmPickerCell.h"

@interface BD_HarmSwitchTableView()<UITableViewDataSource, UITableViewDelegate>

@end

static NSString * const PickerCell = @"HarmPickerCell";
static NSString * const SwitchCell = @"HarmSwitchCell";

@implementation BD_HarmSwitchTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
    
        [self setup];
        
    }
    return self;
}

-(void)setup
{
    self.dataSource = self;
    self.delegate = self;
    self.scrollEnabled = NO;
    [self registerClass:[BD_HarmPickerCell class] forCellReuseIdentifier:PickerCell];
    [self registerClass:[BD_HarmSwitchCell class] forCellReuseIdentifier:SwitchCell];
}

#pragma mark UITableViewDelegate, UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.height / 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if (indexPath.row < 6) {//选项卡cell
        BD_HarmPickerCell *cell = [tableView dequeueReusableCellWithIdentifier:PickerCell];
        cell.index = indexPath.row;
        
        //赋值
        cell.switchModel = self.switchModel;
        
        if (indexPath.row == 5) {//逻辑cell隐藏标题
            cell.secondTitle.hidden = YES;
            cell.secondBtn.hidden = YES;
            cell.lineView.backgroundColor = cell.backgroundColor;
        }else{
            cell.secondTitle.hidden = NO;
            cell.secondBtn.hidden = NO;
            cell.lineView.backgroundColor = RGB(193, 213, 230);
        }
        
        return cell;
        
    }else{//开关量cell
        
        BD_HarmSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:SwitchCell];
        cell.index = indexPath.row;
        cell.switchOutArray = self.switchModel.switchOutArray;
        return cell;
    }
    
}

@end
