//
//  BD_Constants.h
//  PMCtrl_iPad
//
//  Created by ponovo on 2017/9/30.
//  Copyright © 2017年 ponovo. All rights reserved.
//

#ifndef BD_Constants_h
#define BD_Constants_h


/*----------------------设备类---------------------------*/
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_BOUNDS [[UIScreen mainScreen] bounds]
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)//获取屏幕 宽度
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)//获取屏幕 高度
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

/*----------------------颜色类---------------------------*/
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//背景色
#define White [UIColor whiteColor]
#define Black [UIColor blackColor]
#define MainBgColor RGB(47.0, 47.0, 47.0)
#define ViewShadowColor [UIColor colorWithRed:51.0/255.0 green:89.0/255.0 blue:95.0/255.0 alpha:1.0]
#define BtnViewBorderColor [UIColor colorWithRed:0.0/255.0 green:253.0/255.0 blue:255.0/255.0 alpha:1.0]

#define FormBgColor [UIColor colorWithRed:79.0/255.0 green:79.0/255.0 blue:79.0/255.0 alpha:1.0]//半透明灰色
#define BDThemeColor_Light [UIColor colorWithRed:45.0/255.0 green:188.0/255.0 blue:202.0/255.0 alpha:1.0]
#define BDThemeColor [UIColor colorWithRed:0.0/255.0 green:118.0/255.0 blue:129.0/255.0 alpha:1.0]
#define BDTabbarItemNoramlColor [UIColor colorWithRed:72.0/255.0 green:56.0/255.0 blue:85.0/255.0 alpha:1.0]
#define BDTabbarItemSelectedColor [UIColor colorWithRed:96.0/255.0 green:11.0/255.0 blue:164.0/255.0 alpha:1.0]
#define Red [UIColor redColor]
#define Yellow [UIColor yellowColor]
#define Green [UIColor greenColor]
#define SwitchBGColor [UIColor colorWithRed:0.0/255.0 green:135.0/255.0 blue:148.0/255.0 alpha:1.0]
//随机色
#define RandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
//清除背景色
#define ClearColor [UIColor clearColor]

/*----------------------一些缩写---------------------------*/
#define kApplication        [UIApplication sharedApplication]
#define kKeyWindow          [UIApplication sharedApplication].keyWindow
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]
#define kFileManager        [NSFileManager defaultManager]
#define kSingleton          [BD_PMCtrlSingleton shared]
#define kTStrings(data)     [NSString stringWithFormat:@"%.3f",data]

#define BD_UnSelectedImage       [UIImage imageNamed:@"unselected_square"]
#define BD_SelectedImage         [UIImage imageNamed:@"selected_square"]

#define WeakSelf __weak typeof(self) weakself = self;

#ifdef DEBUG
# define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define DLog(...)
#endif


/*----------------------NSUserDefaults---------------------------*/
#define BD_KneePointCount            @"KneePoint"
#define BD_EnterBackground           @"EnterBackground"
#define BD_QuickIsBegin              @"quicktestIsBegin"
#define BD_QuickTestoriginalData     @"originalData"
#define BD_GPSTime                   @"gpsTime"

/*----------------------NSNotification---------------------------*/
#define BD_BinaryStateLineRefresh           @"refreshBinaryStateLineView"
#define BD_HarmAllSelect                    @"HarmAllCellSelect"
#define BD_HarmValueChange                  @"HarmValueChange"
#define BD_HarmDataSet                      @"HarmDataSet"
#define BD_StateTestDeviceConfigFinished    @"BD_StateTestDeviceConfigFinished"
#define BD_HarmWaveformRefresh              @"HarmWaveformRefresh"
#define BD_HarmSendData                     @"HarmSendData"
#define BD_HarmUnselectedItem               @"BD_HarmUnselectedItem"
#define BD_HarmDCSettingChanged              @"BD_HarmDCSettingChanged"

#define BD_ManualTestFromServiceDataNoti    @"BD_ManualTestFromServiceData"
#define BD_StateTestFromServiceDataNoti     @"BD_StateTestFromServiceData"
#define BD_IsCocurrentNoti                  @"BD_ManualTestIsCocurrent"
#define BD_OutPutLimitNotifi                @"OutPutLimitNotifi"
#define BD_DifferTestResultNoti             @"DifferResult"
#define BD_ReadDeviceInfoNoti               @"readDeviceInfo"
#define BD_GPSRealTimeNoti                  @"gpsRealTime"
#define BD_RealHeartStateNoti               @"realHeartState"
#define BD_DirectCurrStart                  @"BD_DirectCurrStart"
#define BD_DirectCurrStop                   @"BD_DirectCurrStop"
#define BD_DifferSettingType                @"BD_DifferSettingType"
#define BD_ManualTestBegin                  @"ManualTestBegin"
#define BD_NewWordDisconnect                @"BD_NewWordDisconnect"
//弧度转角度
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
//角度转弧度
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

//常数
#define MAX_V_Amplitude 300
#define MAX_I_Amplitude 30

#define StateTriggerTypeStrs     [NSArray arrayWithObjects:@"手动触发",@"时间触发",@"开入量",@"GPS触发",@"时间+开入量", nil]
#define Marge           10

// MainScreen Height&Width
#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

//导航栏高度
#define TopBarHeight 64
#define TabbarHeight 49

#endif /* BD_Constants_h */
