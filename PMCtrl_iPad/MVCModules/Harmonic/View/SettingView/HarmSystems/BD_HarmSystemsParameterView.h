//
//  BD_HarmSystemsParameterView.h
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/11/29.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_HarmParamsSettingModel.h"

@protocol BD_HarmSystemsParameterViewDelegate <NSObject>

-(void)changedType:(NSString *)type passageway:(NSString *)passageway;

@end

@interface BD_HarmSystemsParameterView : UIView

/**参数设置模型*/
@property (nonatomic, weak) BD_HarmParamsSettingModel *paramsModel;

/**代理*/
@property (nonatomic, weak) id<BD_HarmSystemsParameterViewDelegate> delegate;

@end
