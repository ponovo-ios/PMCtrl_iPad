//
//  ViewController.m
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/9/29.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#import "ViewController.h"
#import "BD_BinaryStateLineView.h"
#import "BD_BinaryStateModel.h"

//@interface ViewController ()
//
//@end
//
//@implementation ViewController
//
//- (void)viewDidLoad {
//
//    [super viewDidLoad];
////    pow(<#double#>, <#double#>)//x的y次幂
////    sqrt(<#double#>)//x的平方根
////    ceil(<#double#>)//大于或等于x的最小整数值
////    fabs(<#double#>)//返回x的绝对值
////    floor(<#double#>)//返回小于或等于x的最大整数值
////    fmod(<#double#>, <#double#>)//返回x除以y的余数
//    BD_BinaryStateLineView *binaryView = [[BD_BinaryStateLineView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-100)];
//    binaryView.backgroundColor = Black;
//
//    NSArray *titles = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H"];
//    binaryView.xValues = @[@(30),@(40),@(50),@(60),@(70),@(80),@(90),@(100)];
//    NSArray *states = @[@(YES),@(NO),@(YES),@(NO),@(YES),@(NO),@(YES),@(NO)];
//    NSMutableArray *modelArr = [[NSMutableArray alloc]init];
//    for (int i = 0 ;i<titles.count; i++) {
//        BD_BinaryStateModel *sm = [[BD_BinaryStateModel alloc]initWithBinaryName:titles[i] binaryState:[states[i] isEqual:@(YES)]?YES:NO lengthData:30-[binaryView.xValues[0] intValue]];
//        BD_BinaryStateModel *sm2 = [[BD_BinaryStateModel alloc]initWithBinaryName:titles[i] binaryState:NO lengthData:50-[binaryView.xValues[0] intValue]];
//        BD_BinaryStateModel *sm3 = [[BD_BinaryStateModel alloc]initWithBinaryName:titles[i] binaryState:YES lengthData:90-[binaryView.xValues[0] intValue]];
//        BD_BinaryStateViewModel *model = [[BD_BinaryStateViewModel alloc]initWithbinaryName:titles[i] lineData:@[sm,sm2,sm3]];
//        [modelArr addObject:model];
//    }
//
//    binaryView.statelineColor = [UIColor redColor];
//    binaryView.coordinateColor = [UIColor yellowColor];
//    binaryView.xValuesColor = [UIColor greenColor];
//    binaryView.binaryStateDataSource = [modelArr copy];
//    [binaryView setNeedsDisplay];
//    [self.view addSubview:binaryView];
//
//    UIButton *btn = [[UIButton alloc]init];
//    [btn setFrame:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height-50, 50,50)];
//    [btn setTitle:@"改变" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(changeState) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
//    // Do any additional setup after loading the view, typically from a nib.
//}
//
//-(void)changeState{
//
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//
//@end
@interface ViewController ()<CAAnimationDelegate>{
    CGFloat test ;
    NSMutableArray * ColoersArray;
}
@property(strong,nonatomic) CAGradientLayer * GradientLayer ;
@property(strong,nonatomic) CAGradientLayer * MoreGradientLayer ;
@property(strong,nonatomic) CAGradientLayer * AnimationGradientLayer ;
@property(strong,nonatomic) CAGradientLayer * AnimationRoundGradientLayer ;
@property(strong,nonatomic) NSTimer * GradientTimer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0f];
//#pragma mark 单色渐变
//    [self singleGradient];
//#pragma mark 多色渐变
//    [self moreGradient];
//#pragma mark 动画渐变
//    [self animationGradient];
//#pragma mark 圆圈渐变
//    ColoersArray = [NSMutableArray arrayWithCapacity:0];
//    [self roundGradient];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)click:(id)sender {
   
}

-(void)singleGradient{
    // 初始化一个 CAGradientLayer 对象
    self.GradientLayer = [CAGradientLayer layer];
    // 设置CAGradientLayer 对象的大小
    self.GradientLayer.frame =CGRectMake(0, 70, self.view.frame.size.width, 100);
    
    // 设置渐变的方向
    self.GradientLayer.startPoint = CGPointMake(0.0f, 0.0f);
    self.GradientLayer.endPoint = CGPointMake(1.0f, 0.0f);
    
    // 设置渐变的颜色数组
    /*!
     *   (__bridge <#type#>)<#expression#>) 仅仅将值的地址进行转换，并没有转移对象的所有权，如果被桥接的对象释放，则桥接后的值也无法使用。在ARC下使用__bridge，因为所有权仍然属于OC，因此归ARC管制，不必手动释放。
     */
    //    self.GradientLayer.colors = @[(__bridge id)[UIColor magentaColor].CGColor,(__bridge id)[UIColor greenColor].CGColor,(__bridge id)[UIColor yellowColor].CGColor];
    self.GradientLayer.colors = @[(__bridge id)[UIColor clearColor].CGColor,(__bridge id)[UIColor magentaColor].CGColor];
    
    // 设置渐变颜色的分割点
    //self.GradientLayer.locations = @[@(0.2f)];
    
    // 这个是使得颜色像素均匀变化（仅有一个选择）
    self.GradientLayer.type = kCAGradientLayerAxial;
    
    // 将其添加到要渐变的对象 Layer 层上
    [self.view.layer addSublayer:self.GradientLayer];
}
-(void)moreGradient{
    // 初始化一个 CAGradientLayer 对象
    self.MoreGradientLayer = [CAGradientLayer layer];
    // 设置CAGradientLayer 对象的大小
    self.MoreGradientLayer.frame =CGRectMake(0, 190, self.view.frame.size.width, 100);
    
    // 设置渐变的方向
    self.MoreGradientLayer.startPoint = CGPointMake(0.0f, 0.0f);
    self.MoreGradientLayer.endPoint = CGPointMake(1.0f, 0.0f);
    
    // 设置渐变的颜色数组
    /*!
     *   (__bridge <#type#>)<#expression#>) 仅仅将值的地址进行转换，并没有转移对象的所有权，如果被桥接的对象释放，则桥接后的值也无法使用。在ARC下使用__bridge，因为所有权仍然属于OC，因此归ARC管制，不必手动释放。
     */
    self.MoreGradientLayer.colors = @[(__bridge id)[UIColor magentaColor].CGColor,(__bridge id)[UIColor greenColor].CGColor,(__bridge id)[UIColor blueColor].CGColor,(__bridge id)[UIColor purpleColor].CGColor];
    
    // 设置渐变颜色的分割点
    self.MoreGradientLayer.locations = @[@(0.2f),@(0.4f),@(0.6f),@(0.8f)];
    
    // 这个是使得颜色像素均匀变化（仅有一个选择）
    self.MoreGradientLayer.type = kCAGradientLayerAxial;
    
    // 将其添加到要渐变的对象 Layer 层上
    [self.view.layer addSublayer:self.MoreGradientLayer];
}
-(void)animationGradient{
    // 定时器
    self.GradientTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(NextTime) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.GradientTimer forMode:NSDefaultRunLoopMode];
    
    // 初始化一个 CAGradientLayer 对象
    self.AnimationGradientLayer = [CAGradientLayer layer];
    // 设置CAGradientLayer 对象的大小
    self.AnimationGradientLayer.frame =CGRectMake(0,310, self.view.frame.size.width, 100);
    
    // 设置渐变的方向
    self.AnimationGradientLayer.startPoint = CGPointMake(0.0f, 0.0f);
    self.AnimationGradientLayer.endPoint = CGPointMake(1.0f, 0.0f);
    
    // 设置渐变的颜色数组
    /*!
     *   (__bridge <#type#>)<#expression#>) 仅仅将值的地址进行转换，并没有转移对象的所有权，如果被桥接的对象释放，则桥接后的值也无法使用。在ARC下使用__bridge，因为所有权仍然属于OC，因此归ARC管制，不必手动释放。
     */
    self.AnimationGradientLayer.colors = @[(__bridge id)[UIColor magentaColor].CGColor,(__bridge id)[UIColor greenColor].CGColor,(__bridge id)[UIColor blueColor].CGColor,(__bridge id)[UIColor purpleColor].CGColor];
    
    // self.AnimationGradientLayer.locations = @[@(0.2f),@(0.4f),@(0.6f),@(0.8f)];
    
    // 这个是使得颜色像素均匀变化（仅有一个选择）
    self.AnimationGradientLayer.type = kCAGradientLayerAxial;
    
    // 将其添加到要渐变的对象 Layer 层上
    [self.view.layer addSublayer:self.AnimationGradientLayer];
    
}
-(void)NextTime{
    // 设置渐变颜色的分割点
    test = test + 0.05;
    if (test>1.0) {
        test = 0.0f;
    }
    self.AnimationGradientLayer.locations = @[@(test),@(test + 0.01),@(test +0.04),@(test+0.06)];
}
-(void)roundGradient{
   
    // 初始化一个 CAGradientLayer 对象
    self.AnimationRoundGradientLayer = [CAGradientLayer layer];
    // 设置CAGradientLayer 对象的大小
    self.AnimationRoundGradientLayer.frame =CGRectMake(0, 430, self.view.frame.size.width, 10);
    
    // 设置渐变的方向
    self.AnimationRoundGradientLayer.startPoint = CGPointMake(0.0f, 0.0f);
    self.AnimationRoundGradientLayer.endPoint = CGPointMake(1.0f, 0.0f);
    
    CGFloat a = arc4random()%255;
    CGFloat b = arc4random()%255;
    CGFloat c = arc4random()%255;
    UIColor * Coloer = [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1];
    [ColoersArray addObject:(__bridge id)Coloer.CGColor];
    if (ColoersArray.count>6) {
        [ColoersArray removeObjectsInRange:NSMakeRange(2, 4)];
    }
    [ColoersArray addObject:(__bridge id)[UIColor whiteColor].CGColor];
    NSLog(@"AAA:%ld",ColoersArray.count);
    // 设置渐变的颜色数组
    /*!
     *   (__bridge <#type#>)<#expression#>) 仅仅将值的地址进行转换，并没有转移对象的所有权，如果被桥接的对象释放，则桥接后的值也无法使用。在ARC下使用__bridge，因为所有权仍然属于OC，因此归ARC管制，不必手动释放。
     */
    self.AnimationRoundGradientLayer.colors = ColoersArray;
    // 这个是使得颜色像素均匀变化（仅有一个选择）
    self.AnimationRoundGradientLayer.type = kCAGradientLayerAxial;
    
    // 将其添加到要渐变的对象 Layer 层上
    [self.view.layer addSublayer:self.AnimationRoundGradientLayer];
    
    CABasicAnimation *animation;
    animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    [animation setToValue:@4];
    [animation setDuration:0.5];
    [animation setRemovedOnCompletion:YES];
    [animation setFillMode:kCAFillModeForwards];
    [animation setDelegate:self];
    [self.AnimationRoundGradientLayer addAnimation:animation forKey:@"animateGradient"];
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self roundGradient];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
