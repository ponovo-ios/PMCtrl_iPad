//
//  BD_SCLConfigCell.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/4.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BD_SCLConfigCell : UITableViewCell
-(instancetype)initWithData:(NSArray *)cellData viewWidth:(CGFloat)viewWidth reuseIdentifier:(NSString *)reuseIdentifier;
-(instancetype)initSelCellWithData:(NSArray *)cellData reuseIdentifier:(NSString *)reuseIdentifier;
@property(nonatomic,strong)UIButton *selectedBtn;
@property(nonatomic,strong)UIButton *IEDTypeChangeBtn;
@property(nonatomic,assign)NSInteger cellIndex;
@property(nonatomic,strong)void(^checkIEDItemBlock)(NSInteger iedIndex,BOOL state);
@property(nonatomic,strong)void(^changeIEDType)(NSInteger cellIndex,UIButton *iedTypeChangedBtn);
@end
