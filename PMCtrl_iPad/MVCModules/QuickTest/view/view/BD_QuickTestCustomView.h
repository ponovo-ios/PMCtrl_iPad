//
//  BD_QuickTestCustomView.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/11.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 自定义view view image  button  手动测试页 右侧只有两个角圆角的按钮
 */
@interface BD_QuickTestCustomView : UIView
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)void(^clickAction)();
-(instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName;

@end
