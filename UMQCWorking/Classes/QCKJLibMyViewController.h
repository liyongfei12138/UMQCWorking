#import <UIKit/UIKit.h>
@interface QCKJLibMyViewController : UIViewController
-(instancetype)initWithUrl:(NSString*)url frame:(CGRect)frame payRules:(NSArray *)arr;
@property (nonatomic, strong)NSDictionary *infoDict;


@property (nonatomic, copy) void (^userLoginBlock)(NSString *uid);

@property (nonatomic, copy) void (^userLoginoutBlock)(NSString *uid);

@end
