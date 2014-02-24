#import "UIViewController+QuickModal.h"
#import "YTQuickModal.h"
#import <objc/runtime.h>

NSString * const kQuickModalController = @"com.yingquantan.quickmodal.controllerKey";

@implementation UIViewController (QuickModal)

- (void)cowboyQuickModal:(UIViewController *)controller {
    YTQuickModal *quickModal = [[YTQuickModal alloc] init];
    quickModal.presenter = (UIViewController <QuickModal>*)self;
    quickModal.presented = controller;
    [quickModal present];
    [self setAssociatedQuickModal:quickModal];
    [controller setAssociatedQuickModal:quickModal];
}

- (void)cowboyDismissQuickModal {
    YTQuickModal *quickModal = [self associatedQuickModal];
    BOOL shouldDismiss = [self shouldDismissQuickModal];
    if (shouldDismiss) {
        [quickModal dismiss];
        [quickModal.presenter setAssociatedQuickModal:nil];
        [quickModal.presented setAssociatedQuickModal:nil];
    }
}

- (BOOL)shouldDismissQuickModal {
    YTQuickModal *quickModal = [self associatedQuickModal];
    BOOL shouldDismiss = YES;
    if (quickModal.presenter == self) {
        shouldDismiss = YES;
    } else if (quickModal.presented ==  self) {
        if ([quickModal.presenter respondsToSelector:@selector(shouldDismissQuickModalViewController)]) {
            shouldDismiss = [quickModal.presenter shouldDismissQuickModalViewController];
        }
    } else {
        shouldDismiss = NO;
    }
    return shouldDismiss;
}

- (YTQuickModal *)associatedQuickModal {
    return objc_getAssociatedObject(self, &kQuickModalController);
}

- (void)setAssociatedQuickModal:(YTQuickModal *)quickModal {
    objc_setAssociatedObject(self, &kQuickModalController, quickModal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
