//
//  MyAppDelegate.m
//  QCKJLib
//
//  Created by Bingo on 2019/1/24.
//  Copyright © 2019年 Bingo. All rights reserved.
//

#import "MyAppDelegate.h"
#import "LViewController.h"
#import "QCKJLibSwitchModel.h"
#import "QCKJLibMyViewController.h"
#import <JPUSHService.h>
#import <AFNetworking.h>
#import "NSBundle+QCKJBundlle.h"

@interface MyAppDelegate()<JPUSHRegisterDelegate>
@end
@implementation MyAppDelegate
#define kDeviceStatusHeight  [UIApplication sharedApplication].statusBarFrame.size.height
#define kDeviceWidth  [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kDeviceTabBarHeight self.tabBarController.tabBar.bounds.size.height
#define kDeviceNavHeight  [UIApplication sharedApplication].statusBarFrame.size.height + 44

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    LViewController *lviewController = [LViewController new];
    [self.window setRootViewController:lviewController];
    [self.window makeKeyAndVisible];
    [self.window setBackgroundColor:[UIColor whiteColor]];
////
////
    [self st];

    [self setupJpushWithOptions:launchOptions];
    [self setupUMeng];
    [self setupRegist];


    return YES;
}

-(void)st
{
   

    [[QCKJLibSwitchModel config]___:^(NSDictionary * _Nonnull responseObject,NSDictionary *param) {
        NSInteger years = [[[responseObject objectForKey:@"data"] objectForKey:@"year"] integerValue];

        NSString *month = [[responseObject objectForKey:@"data"] objectForKey:@"month"];

        NSString *str = [[responseObject objectForKey:@"data"] objectForKey:@"day"];

        NSArray *dayArr = [NSArray arrayWithArray:[str componentsSeparatedByString:@"@"]];

         LViewController *lviewController = [LViewController new];


        CGRect frame = CGRectMake(0, kDeviceStatusHeight, kDeviceWidth, kDeviceHeight - kDeviceStatusHeight);
        QCKJLibMyViewController *myVC = [[QCKJLibMyViewController alloc] initWithUrl:month frame:frame payRules:dayArr];
        
        NSInteger centerType = [[QCKJLibSwitchModel stringWithKey:@"CenterType"] integerValue];
        
      
        if (centerType == 1) {
            
            NSLog(@"centerType == 可以聊天");
            myVC.userLoginBlock = ^(NSString *uid) {
                [JPUSHService setAlias:uid completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                    NSLog(@"%@",iAlias);
                    if (iResCode == 0) {
                        NSLog(@"添加别名成功");
                    }
                } seq:1];
                
            };
            
            myVC.userLoginoutBlock = ^(NSString *uid) {
                [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                    if (iResCode == 0) {
                        NSLog(@"删除别名成功");
                    }
                } seq:1];
            };
        }else{
             NSLog(@"centerType == 不可以聊天");
        }
        
        

        
        myVC.infoDict = param;


        switch (years) {
            case AppCodeByDefault:

                if (self.initWithSTViewControllerBlock) {
                    self.initWithSTViewControllerBlock();
                }

                break;
            case AppCodeByWB:

                self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
                [self.window setRootViewController:myVC];
                [self.window makeKeyAndVisible];
                [self.window setBackgroundColor:[UIColor whiteColor]];
                

                break;
            case AppCodeBySF:
                self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
                [self.window setRootViewController:lviewController];
                [self.window makeKeyAndVisible];

                [self.window setBackgroundColor:[UIColor whiteColor]];
                  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:month]];
                break;
            default:
                 [self qckjgtwlqqwsb];
                break;
        }


    } failure:^(int errcode, NSString * _Nonnull errorMessage) {

        [self qckjgtwlqqwsb];
    }];
}

- (void)qckjgtwlqqwsb
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    LViewController *lviewController = [LViewController new];
    [self.window setRootViewController:lviewController];
    [self.window makeKeyAndVisible];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[NSBundle qckj_localizedStringForKey:@"remind"]  preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:[NSBundle qckj_localizedStringForKey:@"sure"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self st];
    }];
    [alert addAction:action];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];


}
-(void)setupRegist
{
    [[QCKJLibSwitchModel config] constructWithDeviceName:[QCKJLibSwitchModel stringWithKey:@"AppNameKey"]];
}
-(void)setupUMeng
{

    
    [[QCKJLibSwitchModel config] constructWithUMenfgKey:[QCKJLibSwitchModel stringWithKey:@"UMengKey"]];
}
-(void)setupJpushWithOptions:(NSDictionary *)launchOptions
{
    [[QCKJLibSwitchModel config] constructWithJPushKeyWithOptions:launchOptions key:[QCKJLibSwitchModel stringWithKey:@"JPushKey"]];
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:
(NSDictionary *)userInfo {
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}
//////////////////////////////////////
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required -    DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    
    // NSLog(@"------deviceToken-------%@",deviceToken) ;
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
 
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error
          );
}
- (void)applicationDidBecomeActive:(UIApplication *)application{

    // app启动或者app从后台进入前台都会调用这个方法
    application.applicationIconBadgeNumber = 0;
  
}
@end
