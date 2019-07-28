//
//  BD_SMVDetailSettingMessageParamSetBaseView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/12.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_SMVDetailSettingMessageParamSetBaseView.h"
#import "UITextField+Extension.h"
@interface BD_SMVDetailSettingMessageParamSetBaseView()
@property(nonatomic,strong)NSArray *viewTitleArr;
@property(nonatomic,strong)NSMutableArray<UIView *> *subViewsArr1;
@property(nonatomic,strong)NSMutableArray<UIView *> *subViewsArr2;
@end

@implementation BD_SMVDetailSettingMessageParamSetBaseView


-(instancetype)initWithArrs:(NSArray *)strArrs{
    if (self = [super init]) {
        _viewTitleArr = strArrs;
    }
    return self;
}

-(NSArray *)viewTitleArr{
    if (!_viewTitleArr) {
        _viewTitleArr = [[NSArray alloc]init];
    }
    return _viewTitleArr;
}

-(NSMutableArray *)subViewsArr1{
    if (!_subViewsArr1) {
        _subViewsArr1 = [[NSMutableArray alloc]init];
    }
    return _subViewsArr1;
}

-(NSMutableArray *)subViewsArr2{
    if (!_subViewsArr2) {
        _subViewsArr2 = [[NSMutableArray alloc]init];
    }
    return _subViewsArr2;
}
-(void)createSubView{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.subViewsArr1 removeAllObjects];
    [self.subViewsArr2 removeAllObjects];
    WeakSelf;
    UILabel *viewTitle = [[UILabel alloc]init];
    viewTitle.text = @"报文参数设置";
    viewTitle.textColor = White;
    [self addSubview:viewTitle];
    [viewTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.mas_left).offset(5);
        make.top.mas_equalTo(weakself.mas_top).offset(5);
        make.width.mas_equalTo(weakself).multipliedBy(0.85);
        make.height.mas_equalTo(30);
    }];
    
    for (NSInteger i = 0; i<_viewTitleArr.count; i++) {
        NSArray *columns = _viewTitleArr[i];
      
        if (i == 0) {
            for (NSInteger n = 0;n<columns.count;n++) {
                UILabel *label = [[UILabel alloc]init];
                label.text = columns[n];
                label.textAlignment = NSTextAlignmentLeft;
                label.font = [UIFont systemFontOfSize:13];
                label.textColor = White;
                [self addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(weakself.mas_left).offset(5);
                    make.top.mas_equalTo(weakself.subViewsArr1.count==0?viewTitle.mas_bottom:weakself.subViewsArr1[n-1].mas_bottom).offset(10);
                    make.height.mas_equalTo(30);
                }];
                
                UITextField *tf = [[UITextField alloc]init];
                tf.borderStyle = UITextBorderStyleRoundedRect;
                [tf setDefaultSetting];
                [self addSubview:tf];
                
                if (_viewTitleArr.count == 1) {
                    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(label.mas_right).offset(2);
                        make.centerY.mas_equalTo(label);
                        make.right.mas_equalTo(weakself.mas_right).offset(-2);
                        make.width.mas_equalTo(130);
                        make.height.mas_equalTo(30);
                    }];
                } else{
                    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(label.mas_right).offset(2);
                        make.centerY.mas_equalTo(label);
                        make.width.mas_equalTo(130);
                        make.height.mas_equalTo(30);
                    }];
                }
                
                
                [self.subViewsArr1 addObject:tf];
            }
            
        } else if (i == 1) {
            for (NSInteger n = 0;n<columns.count;n++) {
               
                UITextField *tf = [[UITextField alloc]init];
                tf.borderStyle = UITextBorderStyleRoundedRect;
                [tf setDefaultSetting];
                [self addSubview:tf];
                [tf mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(weakself.mas_right).offset(-5);
                    make.top.mas_equalTo(weakself.subViewsArr2.count==0?viewTitle.mas_bottom:weakself.subViewsArr2[n-1].mas_bottom).offset(10);
                    make.width.mas_equalTo(130);
                    make.height.mas_equalTo(30);
                }];
                
                
                
                UILabel *label = [[UILabel alloc]init];
                label.text = columns[n];
                label.textAlignment = NSTextAlignmentRight;
                label.font = [UIFont systemFontOfSize:13];
                label.textColor = White;
                [self addSubview:label];
                [label mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(tf.mas_left).offset(-2);
                    make.centerY.mas_equalTo(tf);
                    
                    make.height.mas_equalTo(30);
                }];
                [self.subViewsArr2 addObject:tf];
                 
            }
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
