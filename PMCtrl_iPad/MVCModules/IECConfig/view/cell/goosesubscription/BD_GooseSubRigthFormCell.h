//
//  BD_GooseSubRigthFormCell.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/5.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_IECGooseSubscriptionModel.h"



@interface BD_GooseSubRigthFormCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *binary;
@property (weak, nonatomic) IBOutlet UIButton *mac;
@property (weak, nonatomic) IBOutlet UIButton *appid;
@property (weak, nonatomic) IBOutlet UIButton *passage;

@property(nonatomic,assign)BOOL currentPassageIsBinding;
//绑定数据回掉方法，0 单击选中 1 双击绑定 2双击解除绑定
@property(nonatomic,strong)void((^BindingPassageMapBlock)(IECGooseSubscriptionBindingType));

@property(nonatomic,assign)NSInteger cellIndex;
-(void)setCellData:(BD_IECGooseSubscriptionPassageMapModel *)cellData;
@end
