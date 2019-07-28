//
//  BD_ProtobufStructCommonManager.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/5/3.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "stateTest.pb.h"
@interface BD_ProtobufStructCommonManager : NSObject
+(OutPutCommon::para_type )varTypeStringToProbuf:(NSString *)vartype;
+(void)messageData:(NSArray *)sourceArr object:(OutPutCommon::acanalogpara*)para;
+(NSString *)protobufTypeToStrvarType:(OutPutCommon::para_type)vartype;
@end
