//
//  BD_SCLConfigCell.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/4.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_SCLConfigCell.h"
#import "UILabel+Extension.h"
@interface BD_SCLConfigCell()

@end
@implementation BD_SCLConfigCell
static const CGFloat labelFont = 13;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithData:(NSArray *)cellData viewWidth:(CGFloat)viewWidth reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        [self loadViewsWithStrArr:cellData viewWidth:viewWidth];
    }
    return self;
}

-(instancetype)initSelCellWithData:(NSArray *)cellData reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
        [self loadViewsWithStrArr:cellData];
    }
    return self;
}

-(void)loadViewsWithStrArr:(NSArray *)data viewWidth:(CGFloat)viewWidth{
//    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.backgroundColor = ClearColor;
    self.contentView.backgroundColor = FormBgColor;
    
    CGFloat contentWidth = 0;
    _selectedBtn = [[UIButton alloc]init];
    _selectedBtn.frame = CGRectMake(10,45/2, 25, 25);
    _selectedBtn.selected = NO;
    [_selectedBtn addTarget:self
                     action:@selector(selectedIedItem:) forControlEvents:UIControlEventTouchUpInside];
    [_selectedBtn setImage:BD_SelectedImage forState:UIControlStateSelected];
    [_selectedBtn setImage:BD_UnSelectedImage forState:UIControlStateNormal];
    [self.contentView addSubview:_selectedBtn];
    
    for (int i = 0;i<data.count;i++) {
        NSString *str = (NSString *)data[i];
        CGFloat labelWidth = viewWidth;
        CGFloat labelHeight = 35;
        
        UILabel *label;
        
        label = [UILabel labelWithText:str textColor:White fontSize:labelFont alignment:NSTextAlignmentCenter sizeToFit:NO];
       
        if (i == 0) {
            [label setFrame:CGRectMake(_selectedBtn.right+5,35/2,40, labelHeight)];
            label.layer.borderWidth = 0.0;
        } else {
           [label setFrame:CGRectMake(90+(i-1)*labelWidth+i*3,35/2,labelWidth, labelHeight)];
        }
        [label setCorenerRadius:6 borderColor:[UIColor lightGrayColor] borderWidth:1.0];
        [self.contentView addSubview:label];
        
    }
    
}


-(void)loadViewsWithStrArr:(NSArray *)data{
    //    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.backgroundColor = ClearColor;
    self.contentView.backgroundColor = FormBgColor;

    
    for (int i = 0;i<data.count;i++) {
        NSString *str = (NSString *)data[i];
        CGFloat labelWidth = 200;
        CGFloat labelHeight = 35;
        
        UILabel *label;
        
        label = [UILabel labelWithText:str textColor:White fontSize:labelFont alignment:NSTextAlignmentCenter sizeToFit:NO];
        
        if (i == 0) {
            [label setFrame:CGRectMake(20,35/2,40, labelHeight)];
            label.layer.borderWidth = 0.0;
        } else if (i == 1) {
            _IEDTypeChangeBtn = [[UIButton alloc]init];
            _IEDTypeChangeBtn.titleLabel.font = [UIFont systemFontOfSize:labelFont];
            [_IEDTypeChangeBtn setCorenerRadius:6 borderColor:[UIColor lightGrayColor] borderWidth:1.0];
            [_IEDTypeChangeBtn setFrame:CGRectMake(90+(i-1)*labelWidth+i*3,35/2,labelWidth, labelHeight)];
            [self.contentView addSubview:_IEDTypeChangeBtn];
            [_IEDTypeChangeBtn setTitle:str forState:UIControlStateNormal];
            [_IEDTypeChangeBtn addTarget:self action:@selector(changeIEDTypeAction:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [label setFrame:CGRectMake(90+(i-1)*labelWidth+i*3,35/2,labelWidth, labelHeight)];
        }
        [label setCorenerRadius:6 borderColor:[UIColor lightGrayColor] borderWidth:1.0];
        [self.contentView addSubview:label];
        
    }
    
}


-(CGFloat)strTolabelLenght:(NSString *)cellStr{
    return [cellStr widthWithFont:[UIFont systemFontOfSize:labelFont]];
}

-(void)selectedIedItem:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (self.checkIEDItemBlock) {
        self.checkIEDItemBlock(_cellIndex,sender.selected);
    }
}
-(void)changeIEDTypeAction:(UIButton *)sender{
    if (self.changeIEDType) {
        self.changeIEDType(_cellIndex,_IEDTypeChangeBtn);
    }
}
@end
