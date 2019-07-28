//
//  BD_ReportBaseView.h
//  PMCtrl_iPad
//
//  Created by 张姝枫 on 2018/5/18.
//  Copyright © 2018年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BD_ReportBaseModel;

@interface BD_ReportBaseView : UIView
@property(nonatomic,assign)BOOL isShowImageView;
@property(nonatomic,strong)BD_ReportBaseModel *viewModel;
-(instancetype)initWithFrame:(CGRect)frame viewData:(BD_ReportBaseModel *)viewData isShowImageView:(BOOL)isShowImage;
-(void)setViewDatas;
@end
