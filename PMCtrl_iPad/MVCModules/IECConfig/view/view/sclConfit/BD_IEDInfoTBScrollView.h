//
//  BD_IEDInfoTBScrollView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2018/4/8.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^selectedIndexWithViewTypeBlock)(NSInteger index,BD_IEDInfoType viewType);
typedef void (^checkedIndexWithViewTypeBlock)(NSInteger index,BD_IEDInfoType viewType,BOOL state);

@interface BD_IEDInfoTBScrollView : UIView
@property(nonatomic,strong)UITableView *tbView;
@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)NSArray *iedInfoArr;
@property(nonatomic,strong)NSArray *headerTitles;
@property(nonatomic,assign)BD_IEDInfoType viewtype;

-(instancetype)initWithData:(NSArray *)datainfo;
-(void)reloadTBData;
-(void)selectedFirstItem;
@property(nonatomic,strong)selectedIndexWithViewTypeBlock selectedBlock;
@property(nonatomic,strong)checkedIndexWithViewTypeBlock checkedBlock;
@end
