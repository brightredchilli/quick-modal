#import <Foundation/Foundation.h>
#import "UIViewController+QuickModal.h"

@interface YTQuickModal : NSObject

@property (nonatomic, weak) UIViewController <QuickModal>*presenter;
@property (nonatomic, strong) UIViewController *presented;

@property (nonatomic, copy) void (^showAnimationBlock)(UIViewController *presentedViewController);
@property (nonatomic, copy) void (^hideAnimationBlock)(UIViewController *presentedViewController);

- (void)present;
- (void)dismiss;


@end
