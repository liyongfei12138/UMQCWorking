
#import "QCKJLibNNDeviceInformation.h"

#import <ifaddrs.h>
#import <arpa/inet.h>
#import <mach/mach.h>
#import <sys/utsname.h>
#include <objc/runtime.h>
#import <AdSupport/AdSupport.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#include <sys/param.h>
#include <sys/mount.h>
#include <sys/sysctl.h>
#import "UMMobClick/MobClick.h"
#import <SystemConfiguration/CaptiveNetwork.h>
@implementation QCKJLibNNDeviceInformation


/// 获取did
+ (NSString *)getDid{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"dev_did"];
    return str;
}

/// 获取key
+ (NSString *)getKey{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"dev_key"];
    return str;
}

/// 屏幕尺寸
+ (NSString *)getDeviceScreen {
    
    CGFloat wed = [UIScreen mainScreen].bounds.size.width*[UIScreen mainScreen].scale;
    CGFloat hei = [UIScreen mainScreen].bounds.size.height*[UIScreen mainScreen].scale;
    
    return [NSString stringWithFormat:@"%.0f*%.0f",wed,hei];
}

/// 获取iPhone名称
+ (NSString *)getiPhoneName {
    return [UIDevice currentDevice].name;
}

/// 是否有sim卡
+ (NSString *)getsim{
    
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [networkInfo subscriberCellularProvider];
    if (!carrier.isoCountryCode) {
        return @"0";
    }
    return @"1";
}
    
/// 获取手机运营商
+ (NSString *)getOP{
    
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    //先判断有没有SIM卡，如果没有则不获取本机运营商
    if (!carrier.isoCountryCode){
        return @"没有SIM卡";
    }
    else{
        return [carrier carrierName];
    }
}
/// 获取手机越狱
+ (NSString *)getRoot{
    
    if([MobClick isJailbroken]){
        return @"1";
    }else{
        return @"0";
    }
}

/// 获取时间戳
+ (NSString *)GettimeStamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYYMMddHHmmss"];
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    return [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
}

/// 获取app版本号
+ (NSString *)getAPPVerion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
    
/// 当前系统名称
+ (NSString *)getSystemName {
    return [UIDevice currentDevice].systemName;
}

/// 当前系统版本号
+ (NSString *)getSystemVersion {
    return [UIDevice currentDevice].systemVersion;
}

/// 获取总存储空间
+ (NSString *)gettotalDiskSpace{
    
    struct statfs buf1;
    long long maxspace = 0;
    
    if (statfs("/var", &buf1) >= 0)
    {
        maxspace = (long long)buf1.f_bsize * buf1.f_blocks;
    }
    
    return [NSString stringWithFormat:@"%.2fG",(double)maxspace/1024.0/1024.0/1024.0];;
}

/// 获取剩余存储空间
+ (NSString *)totalDiskSpace{
    
    struct statfs buf;
    long long freespace = -1;
    if(statfs("/var", &buf) >= 0){
        freespace = (long long)(buf.f_bsize * buf.f_bfree);
        return [NSString stringWithFormat:@"%.2fG",(double)freespace/1024.0/1024.0/1024.0];
    }
    return @"";
}

/// 获取上次开机时间
+ (NSString *)getlastOpenDevice{
    
    struct timeval boottime;
    
    int mib[2] = {CTL_KERN, KERN_BOOTTIME};
    size_t size = sizeof(boottime);
    if(sysctl(mib,2,&boottime,&size,NULL,0) != -1 && boottime.tv_sec != 0)
    {
        struct tm * tm;
        time_t time_sec ;
        time_sec = boottime.tv_sec;
        tm = localtime(&time_sec);
        
        return [NSString stringWithFormat:@"%d.%d.%d %d:%d:%d",(tm->tm_year + 1900),(tm->tm_mon + 1),tm->tm_mday,tm->tm_hour,tm->tm_min,tm->tm_sec];
        
    }
    return nil;
}

/// 获取已开机时间
+ (NSString *)getrunnedTime{
    
    struct timeval boottime;
    
    int mib[2] = {CTL_KERN, KERN_BOOTTIME};
    size_t size = sizeof(boottime);
    time_t now = time(&now);
    time_t uptime = -1;
    
    if (sysctl(mib, 2, &boottime, &size, NULL, 0) != -1 && boottime.tv_sec != 0)
    {
        uptime = now - boottime.tv_sec;
        
        struct tm * tm;
        tm = localtime(&uptime);
        
        unsigned int s = uptime % 60;
        unsigned int m = uptime / 60 % 60;
        unsigned int h = uptime / 60 / 60 % 24;
        unsigned int d = uptime / 60 / 60 / 24;
        
        return [NSString stringWithFormat:@"%d天 %d小时 %d分 %d秒",d,h,m,s];
    }
    return nil;
}

/// 获取电池电量
+ (NSString *)getbatterQuantitye{
    
    UIDevice * device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = true;
    
    float level = device.batteryLevel;
    return [NSString stringWithFormat:@"%.2f",level];
}

/// 获取电池状态
+ (NSString *)getbatterState{
    
    UIDevice * device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = true;
    
    UIDeviceBatteryState state = device.batteryState;
    switch (state)
    {
        case UIDeviceBatteryStateUnknown:
            return @"未知";
            break;
        case UIDeviceBatteryStateUnplugged:
            return @"未充电";
            break;
        case UIDeviceBatteryStateCharging:
            return @"充电状态";
            break;
        case UIDeviceBatteryStateFull:
            return @"满电";
            break;
        default:
            return @"未知";
            break;
    }
}

// 是否设置了网络代理  原本是BOOL值 只传0 1
+ (NSString *)getisProxy{
    
    NSDictionary *proxySettings =  (__bridge NSDictionary *)(CFNetworkCopySystemProxySettings());
    NSArray *proxies = (__bridge NSArray *)(CFNetworkCopyProxiesForURL((__bridge CFURLRef _Nonnull)([NSURL URLWithString:@"http://www.baidu.com"]), (__bridge CFDictionaryRef _Nonnull)(proxySettings)));
    NSDictionary *settings = [proxies objectAtIndex:0];
    
    if (![[settings objectForKey:(NSString *)kCFProxyTypeKey] isEqualToString:@"kCFProxyTypeNone"]){
        //没有设置代理
        return @"1";
    }else{
        return @"0";
    }
}

///  WiFi名称
+ (NSString *)getwifiName{
    
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"netType"] isEqualToString:@"WiFi"]){
        NSArray *ifs = (__bridge   id)CNCopySupportedInterfaces();
        for (NSString *ifname in ifs){
            NSDictionary *info = (__bridge id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifname);
            if (info[@"SSID"]){
                return info[@"SSID"];
            }
        }
    }
    return @"";
}
///  WiFi MAC地址
+ (NSString *)getwifiMac{
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"netType"] isEqualToString:@"WiFi"]){
        NSArray *ifs = (__bridge   id)CNCopySupportedInterfaces();
        for (NSString *ifname in ifs){
            NSDictionary *info = (__bridge id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifname);
            if (info[@"BSSID"]){
                return info[@"BSSID"];
            }
        }
    }
    return @"";
}
+ (NSString*)getIphoneType {
    
    //需要导入头文件：#import <sys/utsname.h>
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone1,1"])  return@"iPhone 2G";
    
    if([platform isEqualToString:@"iPhone1,2"])  return@"iPhone 3G";
    
    if([platform isEqualToString:@"iPhone2,1"])  return@"iPhone 3GS";
    
    if([platform isEqualToString:@"iPhone3,1"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,2"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,3"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone4,1"])  return@"iPhone 4S";
    
    if([platform isEqualToString:@"iPhone5,1"])  return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,2"])  return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,3"])  return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone5,4"])  return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone6,1"])  return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone6,2"])  return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone7,1"])  return@"iPhone 6 Plus";
    
    if([platform isEqualToString:@"iPhone7,2"])  return@"iPhone 6";
    
    if([platform isEqualToString:@"iPhone8,1"])  return@"iPhone 6s";
    
    if([platform isEqualToString:@"iPhone8,2"])  return@"iPhone 6s Plus";
    
    if([platform isEqualToString:@"iPhone8,4"])  return@"iPhone SE";
    
    if([platform isEqualToString:@"iPhone9,1"])  return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,3"])  return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,2"])  return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone9,4"])  return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone10,1"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,4"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,2"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,5"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,3"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPhone10,6"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPod1,1"])  return@"iPod Touch 1G";
    
    if([platform isEqualToString:@"iPod2,1"])  return@"iPod Touch 2G";
    
    if([platform isEqualToString:@"iPod3,1"])  return@"iPod Touch 3G";
    
    if([platform isEqualToString:@"iPod4,1"])  return@"iPod Touch 4G";
    
    if([platform isEqualToString:@"iPod5,1"])  return@"iPod Touch 5G";
    
    if([platform isEqualToString:@"iPad1,1"])  return@"iPad 1G";
    
    if([platform isEqualToString:@"iPad2,1"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,2"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,3"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,4"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,5"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,6"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,7"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad3,1"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,2"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,3"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,4"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,5"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,6"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad4,1"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,2"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,3"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,4"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,5"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,6"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,7"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,8"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,9"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad5,1"])  return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,2"])  return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,3"])  return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad5,4"])  return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad6,3"])  return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,4"])  return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,7"])  return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"iPad6,8"])  return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"i386"])  return@"iPhone Simulator";
    
    if([platform isEqualToString:@"x86_64"])  return@"iPhone Simulator";
    
    return platform;
    
}
//获取IDFA
+ (NSString *)getIDFA
{
    if ([ASIdentifierManager sharedManager].advertisingTrackingEnabled) {
        return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }else{
        return [NSString stringWithFormat:@"%@%@",[self timeStamp],[self getRandomStringWithLength:6]];
    }
}
+ (NSString *)timeStamp
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYYMMddHHmmss"];
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    return [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
}
#pragma mark - 字符串相关处理
/**
 获取指定长度的随即字符串
 */
+ (NSString *)getRandomStringWithLength:(NSInteger)length
{
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < length; i++)
    {
        int number = arc4random() % 36;
        if (number < 10)
        {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }
        else
        {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return string;
}
@end
