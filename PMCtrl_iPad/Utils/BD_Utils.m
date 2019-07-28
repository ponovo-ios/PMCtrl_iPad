//
//  BD_Utils.m
//  PMCtrl_iOS
//
//  Created by ponovo on 2017/9/5.
//  Copyright © 2017年 bodian. All rights reserved.
//

#import "BD_Utils.h"
@interface BD_Utils()


@end
@implementation BD_Utils

+(instancetype)shared{
    static BD_Utils *instence;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instence = [[BD_Utils alloc]init];
        
    });
    return instence;
}

-(void)setLabelTexts:(NSArray *)labels withTexts:(NSArray *)texts{
    
    for (NSInteger i=0; i<labels.count; i++) {
        UILabel *label = (UILabel *)[labels objectAtIndex:i];
        label.text = texts[i];
    }
}


-(void)setLabelColors:(NSArray *)labels withColor:(UIColor *)color{
    for (UILabel *label in labels) {
        label.textColor = color;
    }
}

#pragma mark - 设置只允许输入数字
- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789.-"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}


+ (NSString *)getCurrentDate{
    
    //获取时间
    NSDate *date = [NSDate date];
    //创建格式化时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //传入时间格式
    formatter.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    
    //把时间转换成字符串
    NSString *dateString = [formatter stringFromDate:date];
    
    return dateString;
}

+ (NSString *)getCurrentDateToms{
    
    //获取时间
    NSDate *date = [NSDate date];
    //创建格式化时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //传入时间格式
    formatter.dateFormat = @"HH:mm:ss.sss";
    
    //把时间转换成字符串
    NSString *dateString = [formatter stringFromDate:date];
    
    return dateString;
}

+ (NSString *)getCurrentDateWithFormat:(NSString *)string{
    
    //获取时间
    NSDate *date = [NSDate date];
    
    //创建格式化时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //传入时间格式
    formatter.dateFormat = string;
    
    //把时间转换成字符串
    NSString *dateString = [formatter stringFromDate:date];
    
    return dateString;
    
}


-(NSString *)testActionTypeChangeToString:(BDActionType)type{
    //1：开始实验    2：实验结束    3：状态切换    4：开入变位 5: 递变
    switch (type) {
        case BDActionType_Start:
            return @"开始实验";
            break;
        case BDActionType_Stop:
            return @"实验结束";
            break;
        case BDActionType_StateChanged:
//            return @"状态切换";
            return @"参数变化";//禅道bug
            break;
        case BDActionType_Binary:
            return @"开入变位";
            break;
        case BDActionType_Gradient:
            return @"递变";
            break;
        case BDActionType_Default:
            return @"";
            break;
        default:
            break;
    }
    return @"";
}


-(void)setViewState:(BOOL)state view:(UIView *)view{
    if ([view isKindOfClass:[UITextField class]]) {
        UITextField *tf = (UITextField *)view;
        if (state) {
            tf.userInteractionEnabled = YES;
            tf.layer.borderColor = White.CGColor;
            tf.textColor = White;
        } else {
            tf.userInteractionEnabled = NO;
            tf.layer.borderColor = [UIColor darkGrayColor].CGColor;
            tf.textColor = [UIColor lightGrayColor];
        }
    }
    
    if ([view isKindOfClass:[UIButton class]]) {
        UIButton *btn = (UIButton *)view;
        if (state) {
            btn.userInteractionEnabled = YES;
            btn.layer.borderColor = White.CGColor;
            [btn setTitleColor:White forState:UIControlStateNormal];
        } else {
            btn.userInteractionEnabled = NO;
            btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
    }
    if([view isKindOfClass:[UILabel class]]){
        UILabel *label = (UILabel *)view;
        if (state) {
            label.layer.borderColor = White.CGColor;
            label.textColor = White;
        } else {
            label.layer.borderColor = [UIColor darkGrayColor].CGColor;
            label.textColor = [UIColor lightGrayColor];
        }
    }
    if([view isKindOfClass:[UISwitch class]]){
        UISwitch *ss = (UISwitch *)view;
        if (state) {
            ss.userInteractionEnabled = YES;
            ss.thumbTintColor = White;
        } else {
            ss.userInteractionEnabled = NO;
             ss.thumbTintColor = [UIColor lightGrayColor];
        }
    }
    
    if ([view isMemberOfClass:[UIView class]]) {
     
       
        if (state) {
            view.userInteractionEnabled = YES;
            if (view.subviews.lastObject.tag == 100) {
                [view.subviews.lastObject removeFromSuperview];
            }

        } else {
            view.userInteractionEnabled = NO;
            if (view.subviews.lastObject.tag != 100) {
                UIView *mark = [[UIView alloc]init];
                [mark setFrame:view.bounds];
                mark.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
                mark.tag =100;
                [view  addSubview:mark];
            }

        }
    }
    
    if ([view isMemberOfClass:[UIScrollView class]]) {
        
        UIScrollView *scroView = (UIScrollView *)view;
        if (state) {
            scroView.userInteractionEnabled = YES;
            if (scroView.subviews.lastObject.tag == 111) {
                [scroView.subviews.lastObject removeFromSuperview];
            }
            
        } else {
            scroView.userInteractionEnabled = NO;
            if (scroView.subviews.lastObject.tag != 111) {
                UIView *mark = [[UIView alloc]init];
                [mark setFrame:CGRectMake(0, 0,scroView.contentSize.width, scroView.contentSize.height)];
                mark.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
                mark.tag =111;
                [scroView  addSubview:mark];
            }
            
        }
    }
    
    
}
-(void)setBtnWithImageState:(BOOL)state btn:(UIButton *)btn{
  
    if (state) {
        btn.userInteractionEnabled = YES;
        if (btn.imageView.subviews.lastObject.tag == 100) {
            [btn.imageView.subviews.lastObject removeFromSuperview];
        }
        
    } else {
        btn.userInteractionEnabled = NO;
        if (btn.imageView.subviews.lastObject.tag != 100) {
            UIView *mark = [[UIView alloc]init];
            [mark setFrame:btn.imageView.bounds];
            mark.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
            [mark setCorenerRadius:8 borderColor:[UIColor lightGrayColor] borderWidth:1];
            mark.tag =100;
            [btn.imageView addSubview:mark];
        }
        
    }
    
}

-(void)setControlState:(BOOL)state control:(UISegmentedControl *)control{
    if (state) {
        [control setTintColor:SwitchBGColor];
        [control setTitleTextAttributes:@{NSForegroundColorAttributeName:White,NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} forState:UIControlStateSelected];
        [control setTitleTextAttributes:@{NSForegroundColorAttributeName:Black,NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} forState:UIControlStateNormal];
        control.userInteractionEnabled = YES;
    } else {
        [control setTintColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5]];
        [control setTitleTextAttributes:@{NSForegroundColorAttributeName:White,NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} forState:UIControlStateSelected];
        [control setTitleTextAttributes:@{NSForegroundColorAttributeName:Black,NSFontAttributeName:[UIFont boldSystemFontOfSize:14]} forState:UIControlStateNormal];
        control.userInteractionEnabled = NO;
    }
    
}

-(const NSString *)enumIEDTypeToString:(BD_IEDInfoType)iedType{
    switch (iedType) {
            
        case BD_IEDInfoType_GOSub:
            return IEDType_GooseSubStr;
            break;
        case BD_IEDInfoType_GOSend:
             return IEDType_GooseSendStr;
            break;
        case BD_IEDInfoType_SMVSub:
            return IEDType_SMVSubStr;
            break;
        case BD_IEDInfoType_SMVSend:
            return IEDType_SMVSendStr;
            break;
        
        default:
            break;
    }
    return @"";
}

-(NSMutableData *)saveToPDFData:(UIScrollView *)scrollView{
    NSMutableData *pdfData = [NSMutableData data];
    UIGraphicsBeginPDFContextToData(pdfData, (CGRect){0,0,scrollView.contentSize}, nil);
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height), nil);
    CGContextRef pdfContext = UIGraphicsGetCurrentContext();//获取上下文
    CGRect origsize  = scrollView.frame;
    CGRect newSIze = origsize;
    newSIze.size = scrollView.contentSize;
    [scrollView setFrame:newSIze];
    [scrollView.layer renderInContext:pdfContext];
    [scrollView setFrame:origsize];
    
    UIGraphicsEndPDFContext();
    //    [pdfData writeToFile:@"" atomically:YES];//将data写入文件
    return pdfData;
}


#pragma mark - 报告中开入量int转通道
+(NSString *)reportSwitchStatusByBinaryIn:(int)binaryIn {
    NSString *str = @"";
    int ch[32];
    for (int k=0;k<32;k++)
    {
        ch[k] = -1;
    }
    
    for ( int k=31; k>=0; k-- )
    {
        ch[k] = (binaryIn&0x80000000)==0?0:1;
        binaryIn = binaryIn<<1;
    }
    if (ch[0] == 1)
    {
        str = [str stringByAppendingString:@"A,"];
    }
    
    if (ch[1] == 1)
    {
        str = [str stringByAppendingString:@"B,"];
    }
    
    if (ch[2] == 1)
    {
        str = [str stringByAppendingString:@"C,"];
    }
    
    if (ch[3] == 1)
    {
        str = [str stringByAppendingString:@"D,"];
        
    }
    
    if (ch[4] == 1)
    {
        str = [str stringByAppendingString:@"E,"];
    }
    
    if (ch[5] == 1)
    {
        str = [str stringByAppendingString:@"F,"];
    }
    
    if (ch[6] == 1)
    {
        str = [str stringByAppendingString:@"G,"];
    }
    
    if (ch[7] == 1)
    {
        str = [str stringByAppendingString:@"H,"];
    }
    
    if (ch[8] == 1)
    {
        str = [str stringByAppendingString:@"I,"];
    }
    
    if (ch[9] == 1)
    {
        str = [str stringByAppendingString:@"J,"];
    }
    
    return str;
}
#pragma mark - 报告中开出量int转通道
+(NSString *)reportSwitchStatusByBinaryOut:(int)binaryOut {
    NSString *str = @"";
    int ch[32];
    for (int k=0;k<32;k++)
    {
        ch[k] = -1;
    }
    
    for ( int k=31; k>=0; k-- )
    {
        ch[k] = (binaryOut&0x80000000)==0?0:1;
        binaryOut = binaryOut<<1;
    }
    if (ch[0] == 1)
    {
        str = [str stringByAppendingString:@"1,"];
    }
    
    if (ch[1] == 1)
    {
        str = [str stringByAppendingString:@"2,"];
    }
    
    if (ch[2] == 1)
    {
        str = [str stringByAppendingString:@"3,"];
    }
    
    if (ch[3] == 1)
    {
        str = [str stringByAppendingString:@"4,"];
        
    }
    
    if (ch[4] == 1)
    {
        str = [str stringByAppendingString:@"5,"];
    }
    
    if (ch[5] == 1)
    {
        str = [str stringByAppendingString:@"6,"];
    }
    
    if (ch[6] == 1)
    {
        str = [str stringByAppendingString:@"7,"];
    }
    
    if (ch[7] == 1)
    {
        str = [str stringByAppendingString:@"8,"];
    }
    
    return str;
}

-(NSString *)diffTestTypeToStr:(DifferTestItemType)differTestType{
    switch (differTestType) {
        case DifferTestItemType_QDCurrent:
            return  @"启动电流";
            break;
        case DifferTestItemType_ZDRatio:
            return  @"比率制动系数";
            break;
        case DifferTestItemType_SDCurrent:
            return  @"速断电流";
            break;
        case DifferTestItemType_HarmonicRation:
            return @"谐波制动系数";
            break;
        case DifferTestItemType_ActionTime:
            return @"动作时间";
            break;
        case DifferTestItemType_Characteristic:
            return @"动作特性曲线测试";
            break;
        case DifferTestItemType_Other:
            return @"无";
            break;
        default:
            break;
    }
}

//两个有序数组合并
- (NSArray *)insertSort:(NSArray *)firstArray secondArray:(NSArray *)secondArray{
    
    NSMutableArray * resuleArray = [NSMutableArray arrayWithCapacity:[firstArray count] + [secondArray count]];
    
    NSInteger i = 0;
    NSInteger j = 0;
    
    while (i < [firstArray count] && j < [secondArray count] ) {
        
        if (firstArray[i] <= secondArray[j]) {
            resuleArray[i + j] = firstArray[i ++];
        }else{
            resuleArray[i + j] = secondArray[j ++];
        }
    }
    
    //保证数组剩余的部分加入合并后的数组中
    while (i < [firstArray count]) {
        resuleArray[i + j] = firstArray[i ++];
    }
    
    while (j < [secondArray count]) {
        resuleArray[i + j] = secondArray[j ++];
    }
    
    
    return resuleArray;
}


//冒泡排序 从小到大
- (NSArray *)buddleSort:(NSArray *)dataArray{
    
    NSMutableArray * resultArray = [NSMutableArray arrayWithArray:dataArray];
    
    for (int i = 0; i < [dataArray count] - 1; i ++) {
        
        for (int j = 0; j < [dataArray count] - 1 - i; j ++) {
            
            if (resultArray[j] > resultArray[j + 1]) {
                
                [resultArray exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
                
            }
        }
    }
    
    return resultArray;
}




@end
