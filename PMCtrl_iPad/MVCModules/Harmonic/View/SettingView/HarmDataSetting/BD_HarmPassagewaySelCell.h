//
//  BD_HarmPassagewaySelCell.h
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/30.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_PickerButton.h"

@class BD_HarmDataSettingModel;
@interface BD_HarmPassagewaySelCell : UITableViewCell

/**通道数组*/
@property (nonatomic, weak) NSMutableArray *passagewayArray;
/**数据设置模型*/
@property (nonatomic, weak) BD_HarmDataSettingModel *dataModel;
/**参数选择数组*/
@property (nonatomic, strong) NSArray *paramsArray;
/**修改通道后，修改参数单位*/
@property(nonatomic,strong)void(^changePassageBlock)();
//参数选择按钮
@property (weak, nonatomic) IBOutlet BD_PickerButton *firstPickerBtn;
//谐波选择按钮
@property (weak, nonatomic) IBOutlet BD_PickerButton *secondPickerBtn;

@end
