//
//  BD_SCLConfigHeaderView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/4.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_SCLConfigHeaderView.h"
#import "UILabel+Extension.h"

@implementation BD_SCLConfigHeaderView
static const CGFloat labelFont = 15;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(instancetype)initWithData:(NSArray *)data viewWidth:(CGFloat)viewWidth{
    if (self = [super init]) {
//        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        self.backgroundColor = MainBgColor;
        CGFloat contentWidth = 0;
        for (int i = 0;i<data.count;i++) {
            NSString *str = (NSString *)data[i];
            CGFloat labelWidth = viewWidth;
            CGFloat labelHeight = 35;
            UILabel *label = [UILabel labelWithText:str textColor:White fontSize:labelFont alignment:NSTextAlignmentCenter sizeToFit:NO];
            if (i==0) {
                [label setFrame:CGRectMake(20,5/2,50, labelHeight)];
            } else {
                [label setFrame:CGRectMake(90+(i-1)*labelWidth+i*3,5/2,labelWidth, labelHeight)];
            }
            [label setCorenerRadius:0 borderColor:[UIColor lightGrayColor] borderWidth:0.0];
            [self addSubview:label];
        }
    }
    return self;
}

@end
