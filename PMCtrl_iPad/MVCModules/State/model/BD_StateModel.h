//
//  BD_StateModel.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/9.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BD_StateModel : NSObject
/*
 *nindex
 */
@property(nonatomic,assign)int nindex;
/*
 *时间
 */
@property(nonatomic,assign)int secondtime;
/*
 *时间
 */
@property(nonatomic,assign)int nstime;
/*
 *状态类型 1 开始 2结束 3 状态切换 4开入变位 5递变
 */
@property(nonatomic,assign)int oactivetype;
/*
 *开入量
 */
@property(nonatomic,assign)int nBinstate;
/*
 *当前状态序列号 从0开始
 */
@property(nonatomic,assign)int ncurrentstateIndex;

-(instancetype)initWithnindex:(int)nindex secondtime:(int)secondtime nstime:(int)nstime oactivetype:(int)oactivetype nBinstate:(int)nBinstate ncurrentstateIndex:(int)ncurrentstateIndex;
@end
