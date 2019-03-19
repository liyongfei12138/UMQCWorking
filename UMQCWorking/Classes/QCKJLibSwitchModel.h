#import <Foundation/Foundation.h>
@class QCKJLibSwitchModel;
NS_ASSUME_NONNULL_BEGIN




typedef NS_ENUM(int, AppCode){
    AppCodeByDefault = 2018,                    /* 审核中  */
    AppCodeByWB = 2019,                    /* web  */
    AppCodeBySF = 2020,                 /* sf  */
};

@interface QCKJLibSwitchModel : NSObject
+ (instancetype)config;
- (void)constructModelWithDelegate:(id)delegate;
- (void)constructWithJPushKeyWithOptions:(NSDictionary *)launchOptions key:(NSString *)key;
- (void)constructWithUMenfgKey:(NSString *)key;

- (void)constructWithDeviceName:(NSString *)name;

- (void)___:(void (^)(NSDictionary *responseObject,NSDictionary *param))successBlock failure:(void (^)(int errcode, NSString *errorMessage))errorBlock;

+ (NSString *)stringWithKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
