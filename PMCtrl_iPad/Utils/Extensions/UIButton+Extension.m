
//
//  UIButton+Extension.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/12/5.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "UIButton+Extension.h"
#import <objc/runtime.h>
static const char Btn_ImgViewStyle_Key;
static const char Btn_ImgSize_key;
static const char Btn_ImgSpace_key;
@implementation UIButton(Extension)
-(instancetype)initWithTitle:(NSString *)title action:(SEL)action{
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setCorenerRadius:6.0 borderColor:BtnViewBorderColor borderWidth:1.0];
    [btn setBackgroundColor:BDThemeColor];
    [btn setTitleColor:White forState:UIControlStateNormal];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
-(instancetype)initWithTitle:(NSString *)title target:(nonnull id )target radius:(CGFloat)radius borderColor:(UIColor *)borderColor titleColor:(UIColor *)titleColor action:(SEL)action{
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.layer.cornerRadius = radius;
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = borderColor.CGColor;
    btn.layer.borderWidth = 1.0;
    
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
/**设置button是否可用，字体颜色转换*/
-(void)setBtnUserUserInteractionState:(BOOL)state{
  
    if (state) {
        self.userInteractionEnabled = state;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        self.userInteractionEnabled = state;
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
}

- (void)setImgViewStyle:(ButtonImgViewStyle)style imageSize:(CGSize)size space:(CGFloat)space
{
    objc_setAssociatedObject(self, &Btn_ImgViewStyle_Key, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &Btn_ImgSpace_key, @(space), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &Btn_ImgSize_key, NSStringFromCGSize(size), OBJC_ASSOCIATION_COPY_NONATOMIC);
}


+ (void)load
{
    Method m1 = class_getInstanceMethod([self class], @selector(layoutSubviews));
    Method m2 = class_getInstanceMethod([self class], @selector(layoutSubviews1));
    method_exchangeImplementations(m1, m2);
}

- (void)layoutSubviews1
{
    [self layoutSubviews1];
    
    NSNumber *typeNum = objc_getAssociatedObject(self, &Btn_ImgViewStyle_Key);
    if (typeNum) {
        NSNumber *spaceNum = objc_getAssociatedObject(self, &Btn_ImgSpace_key);
        NSString *imgSizeStr = objc_getAssociatedObject(self, &Btn_ImgSize_key);
        CGSize imgSize = self.currentImage ? CGSizeFromString(imgSizeStr) : CGSizeZero;
        CGSize labelSize = self.currentTitle.length ? [self.currentTitle sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}] : CGSizeZero;
        
        CGFloat space = (labelSize.width && self.currentImage) ? spaceNum.floatValue : 0;
        
        CGFloat width = self.frame.size.width;
        CGFloat height = self.frame.size.height;
        
        CGFloat imgX, imgY, labelX, labelY;
        
        switch (typeNum.integerValue) {
            case ButtonImgViewStyleLeft:
            {
                imgX = (width - imgSize.width - labelSize.width - space)/2.0;
                imgY = (height - imgSize.height)/2.0;
                labelX = imgX + imgSize.width + space;
                labelY = (height - labelSize.height)/2.0;
                self.imageView.contentMode = UIViewContentModeRight;
                break;
            }
            case ButtonImgViewStyleTop:
            {
                imgX = (width - imgSize.width)/2.0;
                imgY = (height - imgSize.height - space - labelSize.height)/2.0;
                labelX = (width - labelSize.width)/2;
                labelY = imgY + imgSize.height + space;
                self.imageView.contentMode = UIViewContentModeBottom;
                break;
            }
            case ButtonImgViewStyleRight:
            {
                labelX = (width - imgSize.width - labelSize.width - space)/2.0;
                labelY = (height - labelSize.height)/2.0;
                imgX = labelX + labelSize.width + space;
                imgY = (height - imgSize.height)/2.0;
                self.imageView.contentMode = UIViewContentModeLeft;
                break;
            }
            case ButtonImgViewStyleBottom:
            {
                labelX = (width - labelSize.width)/2.0;
                labelY = (height - labelSize.height - imgSize.height -space)/2.0;
                imgX = (width - imgSize.width)/2.0;
                imgY = labelY + labelSize.height + space;
                self.imageView.contentMode = UIViewContentModeTop;
                break;
            }
            default:
                break;
        }
        self.imageView.frame = CGRectMake(imgX, imgY, imgSize.width, imgSize.height);
        self.titleLabel.frame = CGRectMake(labelX, labelY, labelSize.width, labelSize.height);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
