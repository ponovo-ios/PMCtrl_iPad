//
//  UIView+Extension.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/1.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView(Extension)


// Retrieve and set the origin
- (CGPoint) origin
{
    return self.frame.origin;
}

- (void) setOrigin: (CGPoint) aPoint
{
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame = newframe;
}


// Retrieve and set the size
- (CGSize) size
{
    return self.frame.size;
}

- (void) setSize: (CGSize) aSize
{
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}

// Query other frame locations
- (CGPoint) bottomRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint) bottomLeft
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint) topRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}


// Retrieve and set height, width, top, bottom, left, right
- (CGFloat) height
{
    return self.frame.size.height;
}

- (void) setHeight: (CGFloat) newheight
{
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}

- (CGFloat) width
{
    return self.frame.size.width;
}

- (void) setWidth: (CGFloat) newwidth
{
    CGRect newframe = self.frame;
    newframe.size.width = newwidth;
    self.frame = newframe;
}

- (CGFloat) top
{
    return self.frame.origin.y;
}

- (void) setTop: (CGFloat) newtop
{
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat) left
{
    return self.frame.origin.x;
}

- (void) setLeft: (CGFloat) newleft
{
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat) bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void) setBottom: (CGFloat) newbottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat) right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void) setRight: (CGFloat) newright
{
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

-(NSTimeInterval *) duration{
    return self.duration;
}

-(void) setDuration:(NSTimeInterval *)duration{
    self.duration = duration;
}
-(void)setDefaultRadiuWithCorners:(UIRectCorner)corners{
    [self setRadiuWithCorners:corners radiu:5];
}

-(void)setRadiuWithCorners:(UIRectCorner)corners radiu:(CGFloat)radiu{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
}

-(void)setDefaultCornerRadiusWithColor:(UIColor *)borderColor{
    [self setCorenerRadius:6.0 borderColor:borderColor borderWidth:1.0];
}

-(void)setCorenerRadius:(CGFloat)radiu borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
   
    self.layer.cornerRadius = radiu;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
}


-(UIImage *)toImage{
    UIGraphicsBeginImageContext(CGSizeMake(self.bounds.size.width, self.bounds.size.height));
    CGContextRef currentContex = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:currentContex];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self cutImage:result size:self.bounds.size];
    return result;
    
}



//裁剪图片
/**
 *
 *
 */
- (UIImage *)cutImage:(UIImage*)originImage size:(CGSize)viewsize
{
    CGSize newImageSize;
    CGImageRef imageRef = nil;
    
    CGSize imageViewSize = viewsize;
    CGSize originImageSize = originImage.size;
    
    if ((originImageSize.width / originImageSize.height) < (imageViewSize.width / imageViewSize.height))
    {
        // imageView的宽高比 > image的宽高比
        newImageSize.width = originImageSize.width;
        newImageSize.height = imageViewSize.height * (originImageSize.width / imageViewSize.width);
        
        imageRef = CGImageCreateWithImageInRect([originImage CGImage], CGRectMake(0, fabs(originImageSize.height - newImageSize.height) / 2, newImageSize.width, newImageSize.height));
    }
    else
    {
        // image的宽高比 > imageView的宽高比   ： 也就是说原始图片比较狭长
        newImageSize.height = originImageSize.height;
        newImageSize.width = imageViewSize.width * (originImageSize.height / imageViewSize.height);
        
        imageRef = CGImageCreateWithImageInRect([originImage CGImage], CGRectMake(fabs(originImageSize.width - newImageSize.width) / 2, 0, newImageSize.width, newImageSize.height));
    }
    
    return [UIImage imageWithCGImage:imageRef];
}

- (UIViewController *)GetSubordinateControllerForSelf
{
    UIResponder *next = [self nextResponder];
    while (next != Nil)
    {
        if ([next isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    }
    return nil;
}

//设置view的阴影

-(void)setShadowColor{
    UIColor *color = [UIColor colorWithRed:0.0/255.0 green:253.0/255.0 blue:255.0/255.0 alpha:1.0];
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowRadius = 2.f;
    self.layer.shadowOpacity = 0.9f;
    self.layer.shadowOffset = CGSizeMake(0,0);
    
}
-(void)transitionWithType:(NSString *)type withSubType:(NSString *)subType withDuration:(CGFloat)duration{
    CATransition *animation = [[CATransition alloc]init];
    animation.duration = duration;
    animation.type = type;
    if (![subType isEqualToString:@""]) {
        animation.subtype = subType;
    }
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.layer addAnimation:animation forKey:@"animation"];
    
}

-(void)animationWithAnimationTransition:(UIViewAnimationTransition *)transition{
    [UIView animateWithDuration:*(self.duration) animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:*transition forView:self cache:YES];
    }];
}


-(UIButton *)viewWithTagToBtn:(NSInteger)tag{
    return [self viewWithTag:tag];
}
-(UILabel *)viewWithTagToLabel:(NSInteger)tag{
    return [self viewWithTag:tag];
}
-(UITextField *)viewWithTagToTF:(NSInteger)tag{
    return [self viewWithTag:tag];
}


-(UIImage *)saveToImage{
  
        UIGraphicsBeginImageContext(self.bounds.size);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
         return image;
  
  
    
}

-(void)saveToPDfInFileName:(NSString *)fileName{
    NSMutableData *pdfData = [NSMutableData data];
    UIGraphicsBeginPDFContextToData(pdfData, self.bounds, nil);
    UIGraphicsBeginPDFPage();
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIGraphicsEndPDFContext();
    [pdfData writeToFile:fileName atomically:YES];
}


@end
