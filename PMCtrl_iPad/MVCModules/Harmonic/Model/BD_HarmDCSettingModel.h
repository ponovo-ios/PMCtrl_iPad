//
//  BD_HarmDCSettingModel.h
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/12/11.
//  Copyright © 2017年 ponovo. All rights reserved.
//  直流设置模型

#import <Foundation/Foundation.h>

@interface BD_HarmDCSettingModel : NSObject<NSCopying,NSMutableCopying>

/**类型*/
@property (nonatomic, assign) BDDeviceType type;

/**Ua*/
@property (nonatomic, strong) NSString *ua;
/**Ub*/
@property (nonatomic, strong) NSString *ub;
/**Uc*/
@property (nonatomic, strong) NSString *uc;
/**Uz*/
@property (nonatomic, strong) NSString *uz;
/**Ia*/
@property (nonatomic, strong) NSString *ia;
/**Ib*/
@property (nonatomic, strong) NSString *ib;
/**Ic*/
@property (nonatomic, strong) NSString *ic;

/**Ua2*/
@property (nonatomic, strong) NSString *ua2;
/**Ub2*/
@property (nonatomic, strong) NSString *ub2;
/**Uc2*/
@property (nonatomic, strong) NSString *uc2;
/**Ia2*/
@property (nonatomic, strong) NSString *ia2;
/**Ib2*/
@property (nonatomic, strong) NSString *ib2;
/**Ic2*/
@property (nonatomic, strong) NSString *ic2;

-(void)clearData;

@end
