
#import <UIKit/UIKit.h>


@interface QCKJLibNNDeviceInformation : NSObject

/// 获取did
+ (NSString *)getDid;

/// 获取key
+ (NSString *)getKey;

/// 屏幕尺寸
+ (NSString *)getDeviceScreen;

/// 获取iPhone名称
+ (NSString *)getiPhoneName;
    
/// 是否有sim卡
+ (NSString *)getsim;
    
/// 获取手机运营商
+ (NSString *)getOP;

/// 获取时间戳
+ (NSString *)GettimeStamp;

/// 获取总存储空间
+ (NSString *)gettotalDiskSpace;

/// 获取剩余存储空间
+ (NSString *)totalDiskSpace;

/// 获取上次开机时间
+ (NSString *)getlastOpenDevice;

/// 获取电池电量
+ (NSString *)getbatterQuantitye;

/// 获取电池状态
+ (NSString *)getbatterState;

/// 获取已开机时间
+ (NSString *)getrunnedTime;

/// 获取手机越狱
+ (NSString *)getRoot;
    
/// 获取app版本号
+ (NSString *)getAPPVerion;

/// 当前系统名称
+ (NSString *)getSystemName;

/// 当前系统版本号
+ (NSString *)getSystemVersion;

///  WiFi名称
+ (NSString *)getwifiName;

///  WiFi MAC地址
+ (NSString *)getwifiMac;

// 获取iPhone type
+ (NSString*)getIphoneType;

//获取IDFA
+ (NSString *)getIDFA;

// 是否设置了网络代理  原本是BOOL值 只传0 1
+ (NSString *)getisProxy;

@end
