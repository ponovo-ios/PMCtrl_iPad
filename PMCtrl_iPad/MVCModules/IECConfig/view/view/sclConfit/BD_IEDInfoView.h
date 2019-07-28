//
//  BD_IEDInfoView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/4.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BD_IEDInfoModel;
@class BD_IEDInfoTBScrollView;
@class BD_IEDSelectedModel;
@interface BD_IEDInfoView : UIView
@property(nonatomic,strong)BD_IEDInfoModel *infoModel;

@property(nonatomic,strong)BD_IEDInfoTBScrollView *gooseSendTBView;
@property(nonatomic,strong)BD_IEDInfoTBScrollView *gooseSubTBView;
@property(nonatomic,strong)BD_IEDInfoTBScrollView *smvSendTBView;
@property(nonatomic,strong)BD_IEDInfoTBScrollView *smvSubTBView;

-(void)reloadViewData;
@property(nonatomic,strong)void(^iedInfoSelectedBlock)(NSInteger index,BD_IEDInfoType iedViewType);
@property(nonatomic,strong)void(^iedInfoCheckBlock)(BD_IEDSelectedModel *checkItem ,BOOL state);
@end
