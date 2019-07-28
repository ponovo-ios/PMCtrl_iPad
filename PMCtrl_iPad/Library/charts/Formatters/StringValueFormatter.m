//
//  StringValueFormatter.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/7/12.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "StringValueFormatter.h"

@interface StringValueFormatter()
@property(nonatomic,strong)NSArray<NSString *> *titleArr;
@end

@implementation StringValueFormatter
- (id)initWithArr:(NSArray *)arr
{
    self = [super init];
    if (self)
    {
        _titleArr = arr;
    }
    return self;
}

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis
{
    
    if (value-1<axis.labelCount&&value>0) {
        NSInteger index = value-1;
        return _titleArr[index];
    }
    return @"";
}
@end
