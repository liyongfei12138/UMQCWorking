

#import <Foundation/Foundation.h>

@class AFHTTPSessionManager;
typedef void(^SuccessBlock)(id responsData);
typedef void(^FaileBlock)(NSError *error);

@interface QCKJLibNetTool : NSObject
@property (nonatomic,strong)AFHTTPSessionManager *manager;
+(instancetype) sharedInstance;
-(void)oneGet:(NSString*)url success:(SuccessBlock)successBlock faile:(FaileBlock)faileBlock;
-(void)onePost:(NSString*)url parameters:(id)parameters success:(SuccessBlock)successBlock faile:(FaileBlock)faileBlock ;
@end
