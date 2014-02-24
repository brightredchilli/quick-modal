#import "YTQuickModal.h"

@interface YTDismissButton : UIButton
@end

@implementation YTDismissButton
@end

@interface YTQuickModal ()

@property (nonatomic, strong) UIButton *backgroundViewDismissButton;

@end

@implementation YTQuickModal

+ (void (^)(UIViewController *))defaultShowAnimationBlock {
    void (^showAnimationBlock) (UIViewController *) = ^(UIViewController *presentedViewController) {
        presentedViewController.view.alpha = 0;
        [UIView animateWithDuration:0.2
                         animations:^{
                             presentedViewController.view.alpha = 1;
                         }];
    };
    return showAnimationBlock;
}

+ (void (^)(UIViewController *))defaultHideAnimationBlock {
    void (^hideAnimationBlock) (UIViewController *) = ^(UIViewController *presentedViewController) {
        [UIView animateWithDuration:0.2
                         animations:^{
                             presentedViewController.view.alpha = 0;
                         }];
    };
    return hideAnimationBlock;
    
}

- (id)init {
    self = [super init];
    if (self) {
        self.showAnimationBlock = [YTQuickModal defaultShowAnimationBlock];
        self.hideAnimationBlock = [YTQuickModal defaultHideAnimationBlock];
    }
    return self;
}

- (void)dealloc {
    [self dismiss];
}

- (void)present {
    if (self.showAnimationBlock) {
        [self addDismissButtonToPresenterView];
        [self.presenter.view addSubview:self.presented.view];
        self.showAnimationBlock(self.presented);
        self.showAnimationBlock = nil;
    }
}

- (void)dismiss {
    if (self.hideAnimationBlock) {
        [self removeDismissButton];
        self.hideAnimationBlock(self.presented);
        self.hideAnimationBlock = nil;
        [self.presented.view removeFromSuperview];
    }
}

- (void)addDismissButtonToPresenterView {
    [self removeDismissButton];
    
    YTDismissButton *dismissButton = [YTDismissButton buttonWithType:UIButtonTypeCustom];
    [dismissButton addTarget:self action:@selector(dismissButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    dismissButton.frame = self.presenter.view.bounds;
    [self.presenter.view addSubview:dismissButton];
}

- (void)removeDismissButton {
    for (UIView *subview in self.presenter.view.subviews) {
        if ([subview isKindOfClass:[YTDismissButton class]]) {
            [subview removeFromSuperview];
        }
    }
}

- (void)dismissButtonClicked:(id)sender {
    [self.presented cowboyDismissQuickModal];
}

@end