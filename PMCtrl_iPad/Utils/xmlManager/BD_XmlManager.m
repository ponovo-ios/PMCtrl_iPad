//
//  BD_XmlManager.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/11/7.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_XmlManager.h"
#import "XMLDictionary.h"
@implementation BD_XmlManager

+(instancetype)manager{
    static BD_XmlManager *instence;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instence = [[self alloc]init];
    });
    return instence;
}

-(NSDictionary *)xmlToDic:(NSString *)urlPath{
    NSURL *url=[NSURL URLWithString:urlPath];
    NSData *data=[NSData dataWithContentsOfURL:url];
    XMLDictionaryParser *parser=[[XMLDictionaryParser alloc]init];
    NSDictionary *dic=[parser dictionaryWithData:data];
    return dic;
}
@end
