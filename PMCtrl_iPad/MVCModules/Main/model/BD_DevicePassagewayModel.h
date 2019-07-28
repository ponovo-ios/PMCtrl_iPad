//
//  BD_DevicePassagewayModel.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/21.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BD_DevicePassagewayModel : NSObject
/**通道编号*/
@property (nonatomic,strong)NSString *passagewayNum;
/** 通道名称*/
@property (nonatomic,strong)NSString *passagewayName;

-(instancetype)initWithpassagewayNum:(NSString *)passagewayNum passagewayName:(NSString *)passagewayName;
@end
