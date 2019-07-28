//
//  BD_FormTBViewCell.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/21.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_FormTBViewCell.h"
#import "UILabel+Extension.h"
@interface BD_FormTBViewCell()
@property(nonatomic,strong)NSArray<UIView *> *lineViews;
@property(nonatomic,assign)UIView  *bottomLineview;
@end
@implementation BD_FormTBViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier num:(int)num{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadSubViewsWithNum:num];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = ClearColor;
    self.backgroundColor = ClearColor;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews{
      WeakSelf;
    CGFloat labelW = (self.contentView.width-self.formArr.count)/self.formArr.count;
    [_formArr enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(idx*labelW,0,labelW,weakself.contentView.height);
        if (idx!=weakself.formArr.count-1) {
             weakself.lineViews[idx].frame = CGRectMake(obj.right,0,1,weakself.contentView.height);
        }
       
    }];
    
    _bottomLineview.frame= CGRectMake(0,self.contentView.height-1,self.contentView.width, 1);
}
-(void)loadSubViewsWithNum:(int)formNum{
  
    NSMutableArray *formLabels = [[NSMutableArray alloc]init];
    NSMutableArray *lineViews = [[NSMutableArray alloc]init];
    for (int i = 0; i<formNum; i++) {
        UILabel *lab = [UILabel labelWithText:@"" textColor:White fontSize:15 alignment:NSTextAlignmentCenter sizeToFit:YES];
        lab.backgroundColor = ClearColor;
        [self.contentView addSubview:lab];
        if (i!=formNum-1) {
            UIView *lineView = [[UIView alloc]init];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [self.contentView addSubview:lineView];
            [lineViews addObject:lineView];
        }
        [formLabels addObject:lab];
    }
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:lineView];
    _bottomLineview = lineView;
    self.lineViews = [lineViews copy];
    self.formArr = [formLabels copy];
}
@end
