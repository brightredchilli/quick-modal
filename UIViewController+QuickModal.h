#import <UIKit/UIKit.h>

@protocol QuickModal<NSObject>

@optional
- (BOOL)shouldDismissQuickModalViewController;

@end

@interface UIViewController (QuickModal)

- (void)cowboyQuickModal:(UIViewController *)controller;
- (void)cowboyDismissQuickModal;

@end
