//
//  BD_VectorgraphDrawView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/17.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BD_TestDataParamModel;
@interface BD_VectorgraphDrawView : UIView

@property(nonatomic,assign)CGFloat MAX_UAmplitude;
@property(nonatomic,assign)CGFloat MAX_IAmplitude;
@property(nonatomic,strong)NSArray *viewSelectedArr;
@property(nonatomic,strong)NSArray<BD_TestDataParamModel *> *viewDatas;
@end
