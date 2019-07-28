//
//  BD_HarmDataChangeCell.h
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/30.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BD_HarmDataSettingModel;
@interface BD_HarmDataChangeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *stepLengthTF;


@property(nonatomic,strong)NSArray *limitValueArr;
@property(nonatomic,assign)CGFloat voltageMax;
/**数据设置模型*/
@property (nonatomic, weak) BD_HarmDataSettingModel *dataModel;
/**自动按钮点击回调*/
@property (nonatomic, copy) void(^autoBtnClick)(BOOL isOn);
/**修改单位*/
-(void)changePassageWay:(NSString *)passageWay;
/**通道改变，自动递变设置范围自动变化*/
-(void)limitValueChangedSetViewData;
@end
