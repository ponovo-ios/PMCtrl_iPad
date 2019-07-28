//
//  BD_InformationFormCell.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/2/6.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import "BD_InformationFormCell.h"

@implementation BD_InformationFormCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier itemCount:(NSInteger)itemCount{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _itemCount = itemCount;
        self.contentView.backgroundColor = FormBgColor;
    }
    return self;
}
-(void)loadViews{
    CGFloat width  = (self.width-(_itemCount-1))/_itemCount;
    CGFloat height = self.height;
    for (NSInteger i = 0 ; i<_itemCount; i++) {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(i*width,0, width,height)];;
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = White;
        [self.cellLabelArr addObject:label];
        
        [self addSubview:label];
        if (i!=_itemCount-1) {
            UIView *lineView  = [[UIView alloc]initWithFrame:CGRectMake(i*width+width,0,1,height)];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [self addSubview:lineView];
        }
    }
    UIView *bottomlineView  = [[UIView alloc]initWithFrame:CGRectMake(0,height-1,self.width,1)];
    bottomlineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:bottomlineView];
}

-(void)setLabelDataWithDataModel:(BD_TestInformationModel *)infomodel{
    
    NSArray *titles = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%d",infomodel.infoindex],infomodel.currentTime,[[BD_Utils shared] testActionTypeChangeToString:infomodel.actionType],infomodel.binaryIn,infomodel.actionTime,[NSString stringWithFormat:@"%d",infomodel.stateIndex],nil];
    [self.cellLabelArr enumerateObjectsUsingBlock:^(UILabel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.text = (NSString *)titles[idx];
    }];
    
}
-(NSMutableArray *)cellLabelArr{
    if (!_cellLabelArr) {
        _cellLabelArr = [[NSMutableArray alloc]init];
    }
    return _cellLabelArr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
