//
//  BD_InformationHeaderView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/2/6.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_InformationHeaderView.h"

@interface BD_InformationHeaderView ()
@property(nonatomic,strong)NSArray *titleArr;
@end

@implementation BD_InformationHeaderView

-(instancetype)initWithTitles:(NSArray *)titles{
    self = [super init];
    if (self) {
        _titleArr = titles;
 
    }
    return self;
}

-(void)loadViews{
    CGFloat width  = (self.width-(_titleArr.count-1))/_titleArr.count;
    CGFloat height = self.height;
    for (NSInteger i = 0; i<_titleArr.count; i++) {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(i*width,0, width,height)];;
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = (NSString *)_titleArr[i];
        label.backgroundColor = ClearColor;
        label.textColor = BtnViewBorderColor;
        
        [self addSubview:label];
        if (i!=_titleArr.count-1) {
            UIView *lineView  = [[UIView alloc]initWithFrame:CGRectMake(i*width+width,0,1,height)];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [self addSubview:lineView];
        }
       
    }
    UIView *bottomlineView  = [[UIView alloc]initWithFrame:CGRectMake(0,self.height-1,self.width,1)];
    bottomlineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:bottomlineView];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
