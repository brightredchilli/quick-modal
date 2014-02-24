#import <Foundation/Foundation.h>
#import "UIViewController+IPQuickModal.h"

@interface IPQuickModal : NSObject

@property (nonatomic, weak) UIViewController <IPQuickModalPresenter>*presenter;
@property (nonatomic, strong) UIViewController *presented;

@property (nonatomic, copy) void (^showAnimationBlock)(UIViewController *presentedViewController);
@property (nonatomic, copy) void (^hideAnimationBlock)(UIViewController *presentedViewController);

- (void)present;
- (void)dismiss;


@end
