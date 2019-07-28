//
//  BD_SMV618502DetailSetInterchangerQualityVC.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/14.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/**smv 61850详细设置 交换机品质model*/
@interface BD_SMV618502DetailSetInterchangerQualityDataModel:NSObject
@property(nonatomic,strong)NSString *title;
@property(nonatomic,assign)BOOL value1State;
@property(nonatomic,strong)NSString *value1;
@property(nonatomic,assign)BOOL value2State;
@property(nonatomic,strong)NSString *value2;
-(instancetype)initWithTitle:(NSString *)title value1State:(BOOL)value1State value1:(NSString *)value1 value2State:(BOOL)value2State value2:(NSString *)value2;

@end
/**smv 61850详细设置 交换机品质pop view */
@interface BD_SMV618502DetailSetInterchangerQualityVC : UIViewController

@property(nonatomic,strong)NSMutableArray<BD_SMV618502DetailSetInterchangerQualityDataModel *> *tbdatas;

@property(nonatomic,strong)UITableView *tableView;

@end
