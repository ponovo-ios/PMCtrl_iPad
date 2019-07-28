//
//  BD_XmlManager.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/7.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BD_XmlManager : NSObject

+(instancetype)manager;

/**
 *xml文件转换为字典
 *@param urlPath  xml文件地址
 *@return 转换成的字典
 */
-(NSDictionary *)xmlToDic:(NSString *)urlPath;
@end
