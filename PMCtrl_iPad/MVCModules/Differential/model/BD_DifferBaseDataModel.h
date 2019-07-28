//
//  BD_DifferBaseDataModel.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/16.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BD_DifferBaseDataModel : NSObject
@property(nonatomic,assign)float m_QDIr;
@property(nonatomic,assign)float m_ZD1Ir;
@property(nonatomic,assign)float m_ZD1_2Ir;
@property(nonatomic,assign)float m_ZD2Ir;
@property(nonatomic,assign)float m_ZD2_2Ir;
@property(nonatomic,assign)float m_ZD3Ir;
@property(nonatomic,assign)float m_ZD3_2Ir;
@property(nonatomic,assign)float m_ZD4Ir;
@property(nonatomic,assign)float m_ZD4_2Ir;
@property(nonatomic,assign)float m_SDIr;
@property(nonatomic,assign)float m_HarmId;
@property(nonatomic,assign)float m_ActionIr;
@property(nonatomic,assign)float m_ActionId;
@property(nonatomic,strong)NSString *testPhasorType;
@property(nonatomic,assign)float frequency;
@property(nonatomic,assign)float testAccuracy;
@end
