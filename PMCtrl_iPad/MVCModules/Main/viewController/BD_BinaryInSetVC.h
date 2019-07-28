//
//  BD_BinaryInSetVC.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/12.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BD_BinaryInSettingModel;
@interface BD_BinaryInSetVC : UIViewController
/**开入设置模型*/
@property(nonatomic,strong)BD_BinaryInSetData *binarydata;
-(void)showBinaryInView;
@end
