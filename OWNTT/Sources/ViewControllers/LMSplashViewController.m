//
//  MLSplashViewController.m
//  OWNTT
//
//  Created by Kaszuba Maciej on 24/07/14.
//
//

#import "LMSplashViewController.h"
#import "LMLoginViewController.h"

@interface LMSplashViewController ()
@property (weak, nonatomic) IBOutlet UILabel *indicatorTextLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
- (void)splashViewControllerDidFinish;
@end

@implementation LMSplashViewController

- (void)prepareChildForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.destinationViewController isKindOfClass:[TTHostViewController class]])
    {
        TTHostViewController *hostController = (TTHostViewController *)segue.destinationViewController;
        if([hostController.childViewController isKindOfClass:[LMLoginViewController class]])
        {
            LMLoginViewController *loginController = (LMLoginViewController *)hostController.childViewController;
            loginController.showToolbar = NO;
        }
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[LMNotificationService instance] addObserver:self forNotification:LMNotification_TreeOperationFinished withSelector:@selector(synchronizationEnd)];

    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //TODO: add tree download mechanism
    [self.activityIndicator startAnimating];
    if([LMUtils userExist])
    {
        [self downloadJsonData];
    }
    else
    {
        [self performSelector:@selector(splashViewControllerDidFinish) withObject:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

#pragma mark -
#pragma mark === Private methods ===
- (void)splashViewControllerDidFinish
{
    [self.activityIndicator stopAnimating];
    self.indicatorTextLabel.hidden = YES;
    if(![LMUtils userExist]) {
        [self.parentViewController performSegueWithIdentifier:[LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_PushLogin] sender:self.parentViewController];
    } else {
        [self.parentViewController performSegueWithIdentifier:[LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_PushTabBar] sender:self.parentViewController];
    }
}

- (void)downloadJsonData
{
    //[LMUtils downloadAppData];
    [self performSynchronization:NO];
    //[self performSelector:@selector(splashViewControllerDidFinish) withObject:nil afterDelay:3];
}

- (void) performSynchronization: (BOOL) initial
{
    LMSynchronizationService *synchInstance = [LMSynchronizationService instance];
    
    BOOL running = [synchInstance isSynchronizationRunning];
    
    if(!running)
    {
        [synchInstance downloadTree:NO];
    }
}

- (void)synchronizationEnd
{
    
}

@end
