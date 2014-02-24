#import <UIKit/UIKit.h>

@protocol QuickModal<NSObject>

- (BOOL)shouldDismissQuickModalViewController;

@end

typedef enum {
    QuickModalTypeAppear,
    QuickModalTypeSlideUp
} QuickModalType;

@interface UIViewController (QuickModal)

- (void)presentQuickModal:(UIViewController *)controller
            animationType:(QuickModalType)type;

- (void)dismissQuickModal;

@end
