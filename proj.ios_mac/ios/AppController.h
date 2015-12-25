#import <UIKit/UIKit.h>

@class RootViewController;
#define  UMKEY @"556fdd2c67e58e959d0046d4"
@interface AppController : NSObject <UIApplicationDelegate> {
    UIWindow *window;
}

@property(nonatomic, readonly) RootViewController* viewController;

@end

