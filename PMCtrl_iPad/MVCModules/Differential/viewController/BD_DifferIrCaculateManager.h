//
//  BD_DifferIrCaculateManager.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/19.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BD_DifferentialTestItemParaModel;
@interface BD_DifferIrCaculateManager : NSObject
+(instancetype)shared;
@property(nonatomic,strong)BD_DifferSetDataModel *setData;
@property(nonatomic,assign)DifferTestItemType currentTestItemType;
-(void)caculateUpDownData:(BD_DifferentialTestItemParaModel*)data;
@end
