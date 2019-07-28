//
//  BD_TestInformationModel.h
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2018/1/30.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BD_TestInformationModel : NSObject<NSCopying,NSMutableCopying>
@property(nonatomic,assign)int infoindex;
@property(nonatomic,strong)NSString *currentTime;
@property(nonatomic,assign)BDActionType actionType;
@property(nonatomic,strong)NSString *binaryIn;
@property(nonatomic,strong)NSString *actionTime;
@property(nonatomic,assign)int stateIndex;

@end
