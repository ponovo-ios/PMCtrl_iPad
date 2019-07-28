//
//  BD_BinaryStateModel.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/24.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BD_BinaryStateModel : NSObject
@property(nonatomic,strong)NSString *binaryName;
@property(nonatomic,assign)BOOL binaryState;
@property(nonatomic,assign)CGFloat lengthData;
-(instancetype)initWithBinaryName:(NSString *)binaryName binaryState:(BOOL)binaryState lengthData:(CGFloat)lengthData;
@end

@interface BD_BinaryStateViewModel : NSObject
@property(nonatomic,strong)NSString *binaryName;
@property(nonatomic,strong)NSMutableArray *lineData;
-(instancetype)initWithbinaryName:(NSString *)binaryName lineData:(NSMutableArray *)lineData;
@end
