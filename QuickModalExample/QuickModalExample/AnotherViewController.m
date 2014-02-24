#import "AnotherViewController.h"
#import "UIViewController+IPQuickModal.h"

@interface AnotherViewController ()

@end

@implementation AnotherViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)cancelButtonTapped:(id)sender {
    [self dismissQuickModal];
}

@end
