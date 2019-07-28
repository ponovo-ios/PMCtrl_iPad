//
//  BD_QuickTestCustomView.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/10/11.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "BD_QuickTestCustomView.h"

@implementation BD_QuickTestCustomView

-(instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName{
    if (self = [super initWithFrame:frame]) {
        [self loadView:imageName];
    }
    return self;
}

-(void)loadView:(NSString *)imageName{
    
    _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    [_imageView setCorenerRadius:0 borderColor:ClearColor borderWidth:2.0];
   [self addSubview:_imageView];
    [_imageView setShadowColor];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make centerXWithinMargins];
        [make centerYWithinMargins];
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_btn];
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(0);
        make.right.top.mas_equalTo(0);
        
    }];
    [_btn addTarget:self action:@selector(senderAction:) forControlEvents:UIControlEventTouchUpInside];


}



-(void)senderAction:(UIButton *)sender{
    
    self.clickAction();
  
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
