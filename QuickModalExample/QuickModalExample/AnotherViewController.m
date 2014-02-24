#import "AnotherViewController.h"
#import "UIViewController+QuickModal.h"

@interface AnotherViewController ()

@end

@implementation AnotherViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)cancelButtonTapped:(id)sender {
    [self cowboyDismissQuickModal];
}

@end
