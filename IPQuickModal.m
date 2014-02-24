#import "IPQuickModal.h"

@interface YTDismissButton : UIButton
@end

@implementation YTDismissButton
@end

@interface IPQuickModal ()

@property (nonatomic, strong) UIButton *backgroundViewDismissButton;

@end

@implementation IPQuickModal

+ (IPQuickModalAnimation)defaultShowAnimationBlock {
    IPQuickModalAnimation showAnimationBlock = ^(UIViewController *presentingViewController, UIViewController *presentedViewController) {
        [presentingViewController.view addSubview:presentedViewController.view];
        presentedViewController.view.alpha = 0;
        presentedViewController.view.transform = CGAffineTransformMakeScale(0.5, 0.5);
        [UIView animateWithDuration:0.3
                              delay:0
             usingSpringWithDamping:0.7
              initialSpringVelocity:0.5
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             presentedViewController.view.alpha = 1;
                             presentedViewController.view.transform = CGAffineTransformMakeScale(1, 1);
                             
                         } completion:^(BOOL finished) {
                             
                         }];
    };
    return showAnimationBlock;
}

+ (IPQuickModalAnimation)defaultHideAnimationBlock {
    IPQuickModalAnimation hideAnimationBlock = ^(UIViewController *presentingViewController, UIViewController *presentedViewController) {
        [UIView animateKeyframesWithDuration:0.4
                                       delay:0
                                     options:UIViewKeyframeAnimationOptionCalculationModeLinear
                                  animations:^{
                                      [UIView addKeyframeWithRelativeStartTime:0
                                                              relativeDuration:0.2
                                                                    animations:^{
                                                                        presentedViewController.view.transform = CGAffineTransformMakeScale(1.1, 1.1);
                                                                    }];
                                      [UIView addKeyframeWithRelativeStartTime:0.2
                                                              relativeDuration:0.2
                                                                    animations:^{
                                                                        presentedViewController.view.transform = CGAffineTransformMakeScale(0.5, 0.5);
                                                                        presentedViewController.view.alpha = 0;
                                                                    }];
                                      
                                  } completion:^(BOOL finished) {
                                      [presentedViewController.view removeFromSuperview];
                                  }];
    };
    return hideAnimationBlock;
    
}

- (id)init {
    self = [super init];
    if (self) {
        self.showAnimationBlock = [IPQuickModal defaultShowAnimationBlock];
        self.hideAnimationBlock = [IPQuickModal defaultHideAnimationBlock];
    }
    return self;
}

- (void)dealloc {
    [self dismiss];
}

- (void)present {
    if (self.showAnimationBlock) {
        [self addDismissButtonToPresenterView];
        self.showAnimationBlock(self.presenter, self.presented);
        self.showAnimationBlock = nil;
    }
}

- (void)dismiss {
    if (self.hideAnimationBlock) {
        [self removeDismissButton];
        self.hideAnimationBlock(self.presenter, self.presented);
        self.hideAnimationBlock = nil;
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
    [self.presented dismissQuickModal];
}

@end