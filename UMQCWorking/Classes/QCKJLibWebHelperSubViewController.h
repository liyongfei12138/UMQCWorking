#import <UIKit/UIKit.h>
@interface QCKJLibWebHelperSubViewController : UIViewController
@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) NSArray *rulesArr;


@property (nonatomic, copy) void (^userLoginBlock)(NSString *uid);

@property (nonatomic, copy) void (^userLoginoutBlock)(NSString *uid);
@end
