//
//  BD_GooseSubLeftFormCell.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/5.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_IECGooseTransmitModel.h"

@protocol BD_GooseSubLeftFormCellDelegate<NSObject>
@required

-(void)passageMapListShow:(UIButton *)sender cellIndex:(NSInteger)cellIndex;

-(void)passageTypeListShow:(UIButton *)sender cellIndex:(NSInteger)cellIndex;
@optional
@end

@interface BD_GooseSubLeftFormCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *describeValue;
@property (weak, nonatomic) IBOutlet UIButton *passageTypeValue;
@property (weak, nonatomic) IBOutlet UIButton *passageMapValue;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *defaultViewWidth;
@property (weak, nonatomic) IBOutlet UIButton *cellSelectedBtn;

@property (weak, nonatomic) IBOutlet UIView *firstLineView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *describeValueLeading;

@property(nonatomic,assign)NSInteger cellIndex;
@property(nonatomic,strong)void((^passageCellSelectedBlock)(NSInteger,BOOL));
@property(nonatomic,assign)id<BD_GooseSubLeftFormCellDelegate> leftDelegate;

-(void)setCellData:(BD_IECGooseTransmitPassageModel *)cellData;
@end
