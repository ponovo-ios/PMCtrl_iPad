//
//  BD_QuickTestVactorgraphCell.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/17.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BD_QuickTestVactorgraphModel;
@class BD_VectorMaxValueModel;
@interface BD_QuickTestVactorgraphCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UITableView *cellTableView;

@property (weak, nonatomic) IBOutlet UIView *btnContainerView;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property(nonatomic,strong)BD_VectorMaxValueModel *MAXAmplitudeModel;
@property(nonatomic,strong)NSMutableArray *voltageSelectedArr;
@property(nonatomic,strong)NSMutableArray *currentSelectedArr;



@property (nonatomic,strong)NSArray<NSString *> *titleArr;
@property (nonatomic,strong)BD_QuickTestVactorgraphModel *vactorgraphData;
@property(nonatomic,assign)NSInteger cellIndex;
@property(nonatomic,copy)void(^selectedArrBlock)(NSInteger,NSArray *,NSArray *);
-(void)setCellData;

@end
