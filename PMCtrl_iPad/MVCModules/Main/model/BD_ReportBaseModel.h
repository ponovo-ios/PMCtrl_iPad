//
//  BD_ReportBaseModel.h
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2018/5/18.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BD_ReportBaseModel : NSObject
/**测试项名称*/
@property(nonatomic,strong)NSString *subTitle;
/**测试结果*/
//通过一个拼接的字符串来显示
@property(nonatomic,strong)NSString *testResult;
/**表格数据,每一个数组表示一行数据，行数组存放数组是为了使字典有序，最内层数组中只存一个字典，同时字典中只有一对key value*/
@property(nonatomic,strong)NSArray<NSArray <NSDictionary *> *> *formDataSource;
/**图*/
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,assign)BOOL isShowImage;
/**评估结果*/
@property(nonatomic,strong)NSString *assessmentResult;
@end
