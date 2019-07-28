//
//  BD_Utils.h
//  PMCtrl_iOS
//
//  Created by ponovo on 2017/9/5.
//  Copyright © 2017年 bodian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BD_EnumCollection.h"
@interface BD_Utils : NSObject
+(instancetype)shared;

/**
 * label集体赋值
 */
-(void)setLabelTexts:(NSArray *)labels withTexts:(NSArray *)texts;

/**
 *label集体设置字体颜色
 */
-(void)setLabelColors:(NSArray *)labels withColor:(UIColor *)color;


/**
 *label集体设置字体颜色
 @param number  要输入的内容
 */
- (BOOL)validateNumber:(NSString*)number;

/**获取当前日期时间*/
+ (NSString *)getCurrentDate;
/**获取当前时间,精确到毫秒*/
+ (NSString *)getCurrentDateToms;
/**转换当前时间
 @param string 时间结构formate
 @return 当前时间
 */
+ (NSString *)getCurrentDateWithFormat:(NSString *)string;

/**
 @param type 动作时间类型
 @return 动作时间string
 */
-(NSString *)testActionTypeChangeToString:(BDActionType)type;
/**
 设置控件是否可用
 @param state 控件状体 true为可用 false 为不可用
 @param view 控件本身
 */
-(void)setViewState:(BOOL)state view:(UIView *)view;
/**
 设置segment是否可用
 @param state 控件状体 true为可用 false 为不可用
 @param control Segment本身
 */
-(void)setControlState:(BOOL)state control:(UISegmentedControl *)control;
/**设置带图片的button是否可用*/
-(void)setBtnWithImageState:(BOOL)state btn:(UIButton *)btn;

/**
 根据ied类型转换为文字
 @param iedType 保护ied的类型
 @return 测试仪ied类型，保护是发送，测试仪就是订阅，保护是订阅，测试仪就是发送
 */
-(NSString *)enumIEDTypeToString:(BD_IEDInfoType)iedType;
/**将scrollView转换为pdfData，将data写入文件即可*/
-(NSMutableData *)saveToPDFData:(UIScrollView *)scrollView;


/**报告中开入量int转通道*/
+(NSString *)reportSwitchStatusByBinaryIn:(int)binaryIn;
/**报告中开出量int转通道*/
+(NSString *)reportSwitchStatusByBinaryOut:(int)binaryOut;
/**差动试验类型转str*/
-(NSString *)diffTestTypeToStr:(DifferTestItemType)differTestType;

/**
 两个有序数组合并
 
 @param firstArray 第一个数组
 @param secondArray 第二个数组
 @return 合并的数组
 */
- (NSArray *)insertSort:(NSArray *)firstArray secondArray:(NSArray *)secondArray;
/**
 冒泡排序实现,从小到大
 
 @param dataArray 需要排序的数组
 @return 排序完成的数组
 */
- (NSArray *)buddleSort:(NSArray *)dataArray;
@end
