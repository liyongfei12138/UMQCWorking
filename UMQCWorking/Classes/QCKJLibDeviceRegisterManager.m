//
//  DeviceRegisterManager.m
//  LoanApp
//
//  Created by Apple on 2018/12/14.
//  Copyright © 2018年 QiCaiShiKong. All rights reserved.
//

#import "QCKJLibDeviceRegisterManager.h"
#import "QCKJLibNNDeviceInformation.h"
#import "QCKJLibNetTool.h"

#define STRINGNOTNULL(string)  [string isEqualToString:@"(null)"]?@"":string
@implementation QCKJLibDeviceRegisterManager
+ (void)getDeviceRegisterName:(NSString *)deviceName{
    NSString *strDev = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"dev_key"]];
    NSLog(@"%@",strDev);
    NSString *notNullString = STRINGNOTNULL(strDev);
    if(notNullString.length>0){
        
    }else{
        AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
        [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            if (status == AFNetworkReachabilityStatusNotReachable) {
                
            }else {
                if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
                    [[NSUserDefaults standardUserDefaults] setValue:@"4G" forKey:@"netType"];
                }else{
                    [[NSUserDefaults standardUserDefaults] setValue:@"WIFI" forKey:@"netType"];
                }
                
                NSDictionary *dic = @{
                                      @"user_key":[QCKJLibNNDeviceInformation getIDFA],
                                      @"mac_address":@"",
                                      @"platform":@"iOS",
                                      @"os_version":[QCKJLibNNDeviceInformation getSystemVersion],
                                      @"app":deviceName,
                                      @"version":[QCKJLibNNDeviceInformation getAPPVerion],
                                      @"channel":@"AppStore",
                                      @"t_channel":deviceName,
                                      @"name":[QCKJLibNNDeviceInformation getiPhoneName],
                                      @"mod":[QCKJLibNNDeviceInformation getIphoneType],
                                      @"is_sim":[QCKJLibNNDeviceInformation getsim],
                                      @"is_root":[QCKJLibNNDeviceInformation getRoot],
                                      @"rp":[QCKJLibNNDeviceInformation getDeviceScreen],
                                      @"network":[[NSUserDefaults standardUserDefaults] valueForKey:@"netType"],
                                      @"operator":[QCKJLibNNDeviceInformation getOP],
                                      @"device_id":@"0"
                                      };
                [[QCKJLibNetTool sharedInstance] onePost:@"https://api.zhuanqianhome.com/v1/device" parameters:dic success:^(id responsData) {
                    NSLog(@"%@",responsData);
                    if([responsData[@"code"] integerValue]==200){
                        NSString *key = [NSString stringWithFormat:@"%@",responsData[@"device_id"]];
                        [[NSUserDefaults standardUserDefaults] setObject:key forKey:@"dev_key"];
                    }
                } faile:^(NSError *error) {
                    NSLog(@"%@",error);
                }];
            }
        }];
        [mgr startMonitoring];
    }
}
@end
