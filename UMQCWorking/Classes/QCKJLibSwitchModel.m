#import "QCKJLibSwitchModel.h"
#import "AFNetworking.h"
#import "JPUSHService.h"
#import "QCKJLibMyViewController.h"
#import "UMMobClick/MobClick.h"
#import "QCKJLibDeviceRegisterManager.h"
@interface QCKJLibSwitchModel ()
//请求管理者
@property (nonatomic, strong) AFHTTPSessionManager *mgr;
/**  url*/
@property (nonatomic, strong) NSString *requestUrl;
/**  param*/
@property (nonatomic, strong) NSDictionary *requestParam;
@end
static QCKJLibSwitchModel *constructor;

#define kDeviceStatusHeight  [UIApplication sharedApplication].statusBarFrame.size.height
#define kDeviceWidth  [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kSmallGray [UIColor colorWithRed:241.0/255.0 green:242.0/255.0 blue:243.0/255.0 alpha:1.0f]
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@implementation QCKJLibSwitchModel
- (AFHTTPSessionManager *)mgr{
    if (!_mgr) {
        _mgr = [AFHTTPSessionManager manager];
    }
    return _mgr;
}

+ (instancetype)config
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        constructor = [[QCKJLibSwitchModel alloc] init];
        
    });
    
    return constructor;
}


-(void)constructWithJPushKeyWithOptions:(NSDictionary *)launchOptions key:(nonnull NSString *)key
{
    [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                     UIUserNotificationTypeSound |
                                                     UIUserNotificationTypeAlert) categories:nil];
    [JPUSHService setupWithOption:launchOptions appKey:key
                          channel:@"appstore"
                 apsForProduction:1
            advertisingIdentifier:nil];
}

-(void)constructWithUMenfgKey:(NSString *)key
{
    UMAnalyticsConfig *umConfig = [UMAnalyticsConfig sharedInstance];
    umConfig.appKey = key;
    umConfig.channelId = @"App Store";
    [MobClick startWithConfigure:umConfig];
}
- (void)constructWithDeviceName:(NSString *)name
{
    [QCKJLibDeviceRegisterManager getDeviceRegisterName:name];
}


- (void)___:(void (^)(NSDictionary *responseObject,NSDictionary *param))successBlock failure:(void (^)(int errcode, NSString *errorMessage))errorBlock
{
    NSString *strDev = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"dev_key"]];
    
    
    
    NSLog(@"strDevstrDevstrDev ---%@",strDev);
    NSDictionary *param = @{
             @"app":[QCKJLibSwitchModel stringWithKey:@"AppNameKey"],
             @"version":[QCKJLibSwitchModel stringWithKey:@"CFBundleShortVersionString"],
             @"channel":@"AppStore",
             @"t_channel":[QCKJLibSwitchModel stringWithKey:@"AppNameKey"],
             @"device_id":[strDev isEqualToString:@"(null)"] ? @"0": strDev,
             @"user_key":[QCKJLibNNDeviceInformation getIDFA]
             };

    [self.mgr POST:@"https://api.zhuanqianhome.com/v1/getInfo" parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if(responseObject)
        {
            successBlock(responseObject,param);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         errorBlock((int)error.code , @"似乎没有网络");
    }];
}

+ (NSString *)stringWithKey:(NSString *)key
{
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSMutableDictionary *infoDict = [NSMutableDictionary dictionaryWithContentsOfFile:bundlePath];
    NSString *keyName = [infoDict objectForKey:key];
    
    return keyName;
}

@end
