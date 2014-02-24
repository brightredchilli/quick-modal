#import <UIKit/UIKit.h>

@protocol IPQuickModalPresenter<NSObject>

@optional
- (BOOL)shouldDismissQuickModalViewController;

@end

@interface UIViewController (IPQuickModal)

- (void)presentQuickModal:(UIViewController *)controller;
- (void)dismissQuickModal;

@end
