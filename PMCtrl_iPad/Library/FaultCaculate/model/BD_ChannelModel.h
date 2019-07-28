//
//  BD_ChannelModel.h
//  BDFaultCaculateLib
//
//  Created by ponovo on 2018/3/30.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BD_ChannelModel : NSObject
@property (nonatomic,assign)double amplitude;
@property (nonatomic,assign)double phase;
@property (nonatomic,assign)double frequency;
@end
@interface BD_ChannelStrModel : NSObject
@property (nonatomic,strong)NSString *amplitude;
@property (nonatomic,strong)NSString *phase;
@end
