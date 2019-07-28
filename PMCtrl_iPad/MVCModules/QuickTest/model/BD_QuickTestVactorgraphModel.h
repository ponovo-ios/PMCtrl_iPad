//
//  BD_QuickTestVactorgraphModel.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/17.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BD_TestDataParamModel;
@interface BD_QuickTestVactorgraphModel : NSObject

@property (nonatomic,strong)NSMutableArray<BD_TestDataParamModel *> *voltageArr;
@property (nonatomic,strong)NSMutableArray<BD_TestDataParamModel *> *currentArr;

-(instancetype)initWithvoltageArr:(NSMutableArray<BD_TestDataParamModel *> *)voltageArr currentArr:(NSMutableArray<BD_TestDataParamModel *> *)currentArr;
@end
@interface BD_QuickTestVactorgrapViewModel : NSObject

@property (nonatomic,assign)bool state;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)UIColor *lineColor;

@end
