//
//  BD_ReportPDFMainVC.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/5/17.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BD_ReportPDFMainVC : UIViewController
@property (nonatomic,strong)NSString *fileName; //文件路径
//刷新页面
-(void)refreshView;
@end
