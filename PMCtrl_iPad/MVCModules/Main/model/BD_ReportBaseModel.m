//
//  BD_ReportBaseModel.m
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2018/5/18.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_ReportBaseModel.h"

@implementation BD_ReportBaseModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.subTitle = @"";
        self.testResult = @"";
        self.formDataSource = @[];
        self.image = [[UIImage alloc]init];
        self.isShowImage = NO;
        self.assessmentResult = @"";
    }
    return self;
}
@end
