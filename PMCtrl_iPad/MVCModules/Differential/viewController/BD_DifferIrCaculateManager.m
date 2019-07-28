//
//  BD_DifferIrCaculateManager.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/19.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_DifferIrCaculateManager.h"
#import "BD_DifferSetDataModel.h"
#import "BD_DifferentialTestItemModel.h"
@implementation BD_DifferIrCaculateManager

+(instancetype)shared{
    static BD_DifferIrCaculateManager *instence;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instence = [[BD_DifferIrCaculateManager alloc]init];
    });
    return instence;
    
}
-(BD_DifferSetDataModel *)setData{
    if (!_setData) {
        _setData = [[BD_DifferSetDataModel alloc]init];
    }
    return _setData;
}

-(void)caculateUpDownData:(BD_DifferentialTestItemParaModel*)data{
    if (_setData.KneePoint == 1) {
        data.fUp = [NSString stringWithFormat:@"%.3f",[self getCrossData_y_breakPoint1:[data.Ir floatValue]]*1.5];
        data.fDown = [NSString stringWithFormat:@"%.3f",[self getCrossData_y_breakPoint1:[data.Ir floatValue]]*0.5];
    } else if (_setData.KneePoint == 2){
        data.fUp = [NSString stringWithFormat:@"%.3f",[self getCrossData_y_breakPoint2:[data.Ir floatValue]]*1.5];
        data.fDown = [NSString stringWithFormat:@"%.3f",[self getCrossData_y_breakPoint2:[data.Ir floatValue]]*0.5];
    } else {
        data.fUp = [NSString stringWithFormat:@"%.3f",[self getCrossData_y_breakPoint3:[data.Ir floatValue]]*1.5];
        data.fDown = [NSString stringWithFormat:@"%.3f",[self getCrossData_y_breakPoint3:[data.Ir floatValue]]*0.5];
    }
}
#pragma mark - 获取交叉点y值
//一个拐点计算方式
-(float)getCrossData_y_breakPoint1:(float)xvalue{
    float x1 = self.setData.Ip1;//拐点1电流
    float b1 = self.setData.Icdqd;//电流门槛值
    float k1 = self.setData.Kid1;//启动电流斜率
    float y1 = k1*x1+b1;//拐点1之前的y值
    float k2 = self.setData.Kid2;//基波比率制动特性斜率1
    float y2 = self.setData.Isd;//速断电流定值
    float x2 = (y2-y1)/k2+x1;
    
    if (xvalue<=x1) {
        return y1;
    } else if (xvalue>=x2){
        return y2;
    } else {
        //          NSLog(@"%@", [NSString stringWithFormat:@"正常：%.5f",k2*xvalue+(y1-k2*x1)]);
        //         NSLog(@"%@", [NSString stringWithFormat:@"四舍五入：%.5f",[self roundFloat:k2*xvalue+(y1-k2*x1)]]);
        return k2*xvalue+(y1-k2*x1);//斜线的方程式，方程式应该根据设置的x1，y1，k2来确定，不能固定写死，k1是0，特性曲线中第一条横线的斜率，设置为0
        
    }
}

//二个拐点计算方式
-(float)getCrossData_y_breakPoint2:(float)xvalue{
    float x1 = (float)self.setData.Ip1;//拐点1电流
    float b1 = (float)self.setData.Icdqd;//电流门槛值
    float k1 = (float)self.setData.Kid1;//启动电流斜率
    float k2 = (float)self.setData.Kid2;//基波比率制动特性斜率1
    float k3 = (float)self.setData.Kid3;//基波比率制动特性斜率2
    float x2 = (float)self.setData.Ip2;//拐点2电流
    float y4 = (float)self.setData.Isd;//速断电流
    
    float x1_y = k1*x1+b1;
    float y1 = k1*xvalue+b1;
    float x2_y = k2*(x2-x1)+x1_y;
    float x3 = (y4-x2_y)/k3 + x2;
    
    float y2 = k2*xvalue+(x1_y-k2*x1);//第一条斜线的方程式
    float y3 = k3*xvalue+(x2_y-k3*x2); // 第二条斜线的方程式
    
    
    if (xvalue<=x1) {
        return y1;
    } else if (xvalue>=x3){
        return y4;
    } else if (xvalue>x1 && xvalue<=x2) {
        
        return y2;
    } else {
        return y3;
    }
}

//三个拐点计算方式
-(float)getCrossData_y_breakPoint3:(float)xvalue{
    float x1 = (float)self.setData.Ip1;//拐点1电流
    float b1 = (float)self.setData.Icdqd;//电流门槛值
    float k1 = (float)self.setData.Kid1;//启动电流斜率
    float k2 = (float)self.setData.Kid2;//基波比率制动特性斜率1
    float k3 = (float)self.setData.Kid3;//基波比率制动特性斜率2
    float k4 = (float)self.setData.Kid4;//速断电流斜率
    float x2 = (float)self.setData.Ip2;//拐点2电流
    float x3 = (float)self.setData.Ip3;//拐点电流
    float y5 = (float)self.setData.Isd;//速断电流
    
    float x1_y = k1*x1+b1;
    float y1 = k1*xvalue+b1;
    float x2_y = k2*(x2-x1)+x1_y;
    float x3_y = k3*(x3-x2)+x2_y;
    float x4 = (y5-x3_y)/k4 + x3;
    
    float y2 = k2*xvalue+(x1_y-k2*x1);//第一条斜线的方程式
    float y3 = k3*xvalue+(x2_y-k3*x2); // 第二条斜线的方程式
    float y4 = k4*xvalue +(x3_y-k4*x3);//第三条斜率方程式
    
    if (xvalue<=x1) {
        return y1;
    } else if (xvalue>=x4){
        return y5;
    } else if (xvalue>x1 && xvalue<=x2) {
        return y2;
    } else if(xvalue>x2 && xvalue<=x3) {
        return y3;
    } else {
        return y4;
    }
}
@end
