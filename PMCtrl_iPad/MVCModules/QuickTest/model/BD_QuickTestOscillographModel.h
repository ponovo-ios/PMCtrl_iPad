//
//  BD_QuickTestOscillographModel.h
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2017/10/22.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BD_QuickTestOscillographModel_Base : NSObject
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSMutableArray *model;

-(instancetype)initWithTitle:(NSString *)title model:(NSMutableArray *)model;

@end

@interface BD_QuickTestOscillographModel : NSObject

@property(nonatomic,strong)NSMutableArray<BD_QuickTestOscillographModel_Base *> *VAmplitudeArr;
@property(nonatomic,strong)NSMutableArray<BD_QuickTestOscillographModel_Base *> *CAmplitudeArr;
-(instancetype)initWithVAmplitudeArr:(NSMutableArray *)VAmplitudeArr CAmplitudeArr:(NSMutableArray *)CAmplitudeArr;

@end
