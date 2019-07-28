//
//  BD_BinarySwitchSetVC.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/11.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BD_TestBinarySwitchSetModel;
@interface BD_BinarySwitchSetVC : UIViewController
@property(nonatomic,strong)BD_TestBinarySwitchSetModel *binaryData;
@property(nonatomic,strong)void(^okActionBlock)();
-(void)showBinaryView;
@end
