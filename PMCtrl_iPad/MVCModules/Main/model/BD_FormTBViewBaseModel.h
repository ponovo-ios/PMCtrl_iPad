//
//  BD_FormTBViewBaseModel.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/21.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BD_FormTBViewBaseModel : NSObject
@property(nonatomic,strong)NSArray<NSString *> *modelDatas;
-(instancetype)initWithNum:(int)num;
@end
