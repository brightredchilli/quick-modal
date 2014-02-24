#import "UIViewController+QuickModal.h"
#import <objc/runtime.h>

NSString * const kQuickModalBackground = @"com.yingquantan.quickmodal.backgroundImageKey";
NSString * const kQuickModalController = @"com.yingquantan.quickmodal.controllerKey";
NSString * const kQuickModalPresentingController = @"com.yingquantan.quickmodal.presentingControllerKey";
NSString * const kQuickModalControllerModalType = @"com.yingquantan.quickmodal.modalType";

#define BackgroundAnimationDuration 0.3
#define ModalAnimationDuration 0.3

@implementation UIViewController (QuickModal)

- (void)presentQuickModal:(UIViewController *)controller
            animationType:(QuickModalType)type {
    
    //associate the presented controller with the presenting controller
    objc_setAssociatedObject(self, &kQuickModalController, controller, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(controller, &kQuickModalPresentingController, self, OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self,
                             &kQuickModalControllerModalType,
                             [NSNumber numberWithInteger:type],
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    //first associate image with this controller
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundImageView.userInteractionEnabled = YES;
    backgroundImageView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    objc_setAssociatedObject(self, &kQuickModalBackground, backgroundImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    //set a tap gesture recognizer on the imageview to call imageviewdidgetpressed on presenting view contorller
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(quickModalBackgroundImageViewClicked:)];
    [backgroundImageView addGestureRecognizer:recognizer];
    
    [self.view addSubview:backgroundImageView];
    //animate the background showing
    backgroundImageView.alpha = 0;
    [UIView animateWithDuration:BackgroundAnimationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         backgroundImageView.alpha = 1;
                     } completion:^(BOOL finished) {
                     }];
    
    //make the new controller show depending on the type of animation
    [self.view addSubview:controller.view];
    if (type == QuickModalTypeSlideUp) {
        __block CGRect modalFrame = controller.view.frame;
        modalFrame.origin.y = CGRectGetHeight(self.view.bounds);
        controller.view.frame = modalFrame;
        
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             modalFrame.origin.y = CGRectGetHeight(self.view.frame) - CGRectGetHeight(modalFrame);
                             controller.view.frame = modalFrame;
                         } completion:^(BOOL finished) {
                         }];
    }
    
    
}

- (void)dismissQuickModal {
    //figure out which one we are. presenting, or being presented.
    
    id presented = objc_getAssociatedObject(self, &kQuickModalController);
    id presenting = objc_getAssociatedObject(self, &kQuickModalPresentingController);
    
    if (presented) {
        //this means we must be the one presenting.
        [self quickModalBackgroundImageViewClicked:nil];
    } else if (presenting) {
        //we must be the one being presented, ask that view controller to dismiss instead;
        [presenting quickModalBackgroundImageViewClicked:nil];
    } else {
        //do nothing
    }
}

- (void)quickModalBackgroundImageViewClicked:(UITapGestureRecognizer *)tapRecognizer {
    
    BOOL shouldDismiss = YES;
    
    id modalController = objc_getAssociatedObject(self, &kQuickModalController);
    UIImageView *backgroundImageView = objc_getAssociatedObject(self, &kQuickModalBackground);
    QuickModalType type = [objc_getAssociatedObject(self, &kQuickModalControllerModalType) integerValue];
    
    if ([modalController respondsToSelector:@selector(shouldDismissQuickModalViewController)]) {
        shouldDismiss = [modalController shouldDismissQuickModalViewController];
    }
    
    if (shouldDismiss) {
        //dismiss and remove image view
        objc_setAssociatedObject(self, &kQuickModalBackground, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [UIView animateWithDuration:BackgroundAnimationDuration
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             backgroundImageView.alpha = 0;
                         } completion:^(BOOL finished) {
                             [backgroundImageView removeFromSuperview];
                         }];
        
        if (type == QuickModalTypeSlideUp) {
            
            [UIView animateWithDuration:0.3
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 CGRect modalFrame = [[modalController view] frame];
                                 modalFrame.origin.y = CGRectGetHeight(self.view.bounds);
                                 [[modalController view] setFrame:modalFrame];
                             } completion:^(BOOL finished) {
                                 if ([self respondsToSelector:@selector(didDismissQuickModalViewController:)]) {
                                     [self performSelector:@selector(didDismissQuickModalViewController:)
                                                withObject:modalController
                                                afterDelay:0];
                                 }
                                 [[modalController view] removeFromSuperview];
                                 objc_setAssociatedObject(self,
                                                          &kQuickModalController,
                                                          nil,
                                                          OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                                 objc_setAssociatedObject(self,
                                                          &kQuickModalControllerModalType,
                                                          nil,
                                                          OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                             }];
        }
    }
    
}


@end
