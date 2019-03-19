
#import "QCKJLibNetTool.h"
#import "AFNetworking.h"

@implementation QCKJLibNetTool

+(instancetype) sharedInstance {
    static QCKJLibNetTool *networking = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networking = [[self alloc]init];
    });
    return networking;
}
-(instancetype)init {
    if (self = [super init]) {
      _manager = [[AFHTTPSessionManager alloc]init];
      _manager.responseSerializer.acceptableContentTypes = [_manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
           
    }
    return self;
}
-(void)oneGet:(NSString*)url success:(SuccessBlock)successBlock faile:(FaileBlock)faileBlock {
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (faileBlock) {
            faileBlock(error);
        }
        
    }];

}
-(void)onePost:(NSString*)url parameters:(id)parameters success:(SuccessBlock)successBlock faile:(FaileBlock)faileBlock {
    
    [self.manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (faileBlock) {
            faileBlock(error);
        }
        
    }];
}



@end
