//
//  BD_HarmDataHeaderView.m
//  PMCtrl_iPad
//
//  Created by wanggx on 2017/12/1.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_HarmDataHeaderView.h"

@interface BD_HarmDataHeaderView()
@property (weak, nonatomic) IBOutlet UILabel *firstTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *fourthTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *vaildValue;
@property (weak, nonatomic) IBOutlet UILabel *vaildValue2;
@property (weak, nonatomic) IBOutlet UILabel *vaildValue3;
@property (weak, nonatomic) IBOutlet UILabel *vaildValue4;


@end

@implementation BD_HarmDataHeaderView

-(void)awakeFromNib
{
    [super awakeFromNib];

}

-(void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    if (titleArray.count!=0) {
        self.firstTitleLabel.text = titleArray.firstObject;
        self.secondTitleLabel.text = titleArray[1];
        self.thirdTitleLabel.text = titleArray[2];
        self.fourthTitleLabel.text = titleArray.lastObject;
        if ([titleArray.firstObject hasPrefix:@"U"]) {
            self.vaildValue.text = @"有效值(V)";
        } else {
            self.vaildValue.text = @"有效值(A)";
        }
        if ([titleArray[1] hasPrefix:@"U"]) {
            self.vaildValue2.text = @"有效值(V)";
        } else {
            self.vaildValue2.text = @"有效值(A)";
        }
        if ([titleArray[2] hasPrefix:@"U"]) {
            self.vaildValue3.text = @"有效值(V)";
        } else {
            self.vaildValue3.text = @"有效值(A)";
        }
        if ([titleArray.lastObject hasPrefix:@"U"]) {
            self.vaildValue4.text = @"有效值(V)";
        } else {
            self.vaildValue4.text = @"有效值(A)";
        }
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
