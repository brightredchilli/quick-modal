#import "ViewController.h"
#import "YTQuickModal.h"
#import "AnotherViewController.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:recognizer];
    
}
- (void)viewTapped:(UITapGestureRecognizer *)recognizer {
    [self cowboyDismissQuickModal];
    AnotherViewController *viewController = [[AnotherViewController alloc] initWithNibName:nil bundle:nil];
    CGRect frame = viewController.view.frame;
    frame.origin = [recognizer locationInView:self.view];
    frame.origin.x -= frame.size.width/2;
    frame.origin.y -= frame.size.height/2;
    viewController.view.frame = frame;
    [self cowboyQuickModal:viewController];
}

- (BOOL)shouldDismissQuickModalViewController {
    return YES;
}

@end
