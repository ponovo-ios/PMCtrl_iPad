//
//  BD_QuickTestResultModel.h
//  PMCtrl_iOS
//
//  Created by 张姝枫 on 2017/9/27.
//  Copyright © 2017年 bodian. All rights reserved.
//

#import <Foundation/Foundation.h>


/**已禁用，测试结果模型使用BD_TestResultModel------------------------
*/
 
@interface BD_QuickTestResultModel : NSObject
/**
 * nindex
 */
@property(nonatomic,assign)int nindex;
/**
 * 测试类型    代表的类型1 开始试验。2 结束实验。3 状态切换 4开入变位 递变
 */
@property(nonatomic,assign)int oactivetype;
/**
 *开入量
 */
@property(nonatomic,assign)int nBinstate;
/**
 *开入量所有状态值
 */
@property(nonatomic,assign)int nbinall;
/**
 * 测试时间 纳秒
 */
@property(nonatomic,strong)BD_UtcTime *time;

-(instancetype )initWithnindex:(int) nindex oactivetype:(int)oactivetype nBinstate:(int)nBinstate nbinall:(int)nbinall  time:(BD_UtcTime *)time ;
@end

@interface BD_BeginTestModel : NSObject
@property(nonatomic,assign)bool isBegin;
-(instancetype)initWithBegin:(bool)isBegin;

@end
