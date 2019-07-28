//
//  BD_StateTestParamTabVC.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/26.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_StateTestParamModel.h"

@interface BD_StateTestParamTabVC : UITabBarController
@property (nonatomic,strong)NSString *naviTitle;
@property (nonatomic,strong)BD_StateTestParamModel *dataModel;
//@property (nonatomic,strong)void(^blockData)(BD_StateTestParamModel *);
@end
