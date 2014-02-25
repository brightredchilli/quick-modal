#import "UIViewController+IPQuickModal.h"
#import "IPQuickModal.h"
#import <objc/runtime.h>

NSString * const kQuickModalController = @"com.yingquantan.quickmodal.controllerKey";

@implementation UIViewController (IPQuickModal)

- (void)presentQuickModal:(UIViewController *)controller {
    IPQuickModal *quickModal = [[IPQuickModal alloc] init];
    quickModal.presenter = (UIViewController <IPQuickModalPresenter>*)self;
    quickModal.presented = controller;
    [quickModal present];
    [self setAssociatedQuickModal:quickModal];
    [controller setAssociatedQuickModal:quickModal];
}

- (void)dismissQuickModal {
    IPQuickModal *quickModal = [self associatedQuickModal];
    BOOL shouldDismiss = [self shouldDismissQuickModal];
    if (shouldDismiss) {
        [quickModal dismiss];
        [quickModal.presenter setAssociatedQuickModal:nil];
        [quickModal.presented setAssociatedQuickModal:nil];
    }
}

- (BOOL)shouldDismissQuickModal {
    IPQuickModal *quickModal = [self associatedQuickModal];
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

- (IPQuickModal *)associatedQuickModal {
    return objc_getAssociatedObject(self, &kQuickModalController);
}

- (void)setAssociatedQuickModal:(IPQuickModal *)quickModal {
    objc_setAssociatedObject(self, &kQuickModalController, quickModal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
