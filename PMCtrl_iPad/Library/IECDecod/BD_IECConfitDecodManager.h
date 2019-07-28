//
//  BD_IECConfitDecodManager.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/3/28.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>
/**包装一个自己定义的model*/
@interface BD_IECConfitDecodManager : NSObject
/**判断沙盒中是否有scd文件*/
-(void)showIECViewInVC:(UIViewController *)VC sourceView:(UIView *)sourceView;
@end
