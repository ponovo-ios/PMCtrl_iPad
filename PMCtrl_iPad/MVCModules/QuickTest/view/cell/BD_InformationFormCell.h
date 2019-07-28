//
//  BD_InformationFormCell.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/2/6.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BD_TestInformationModel.h"

@interface BD_InformationFormCell : UITableViewCell
/**存放label*/
@property(nonatomic,strong)NSMutableArray *cellLabelArr;
/**cell数据模型*/
@property(nonatomic,strong)BD_TestInformationModel *cellData;

/**label的个数，即信息表中列的个数*/
@property(nonatomic,assign)NSInteger itemCount ;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier itemCount:(NSInteger)itemCount;
/**设置cell中显示数据*/
-(void)setLabelDataWithDataModel:(BD_TestInformationModel *)infomodel;
-(void)loadViews;
@end
