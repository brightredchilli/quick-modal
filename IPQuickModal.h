#import <Foundation/Foundation.h>
#import "UIViewController+IPQuickModal.h"

typedef void (^IPQuickModalAnimation)(UIViewController *presentedViewController, UIViewController *presentingViewController);

@interface IPQuickModal : NSObject

@property (nonatomic, weak) UIViewController <IPQuickModalPresenter>*presenter;
@property (nonatomic, strong) UIViewController *presented;

@property (nonatomic, copy) IPQuickModalAnimation showAnimationBlock;
@property (nonatomic, copy) IPQuickModalAnimation hideAnimationBlock;

- (void)present;
- (void)dismiss;


@end
