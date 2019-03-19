//
//  LXTestObject.h
//  TestFramework
//
//  Created by 刘宣 on 2019/3/7.
//  Copyright © 2019 刘宣. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^TextBlock)(NSInteger count);

@interface LXTestObject : NSObject

- (void)putInCountWithAdd:(NSInteger )count testBlock:(TextBlock)test;

@end

NS_ASSUME_NONNULL_END
