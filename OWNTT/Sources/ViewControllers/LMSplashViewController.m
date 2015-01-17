//
//  MLSplashViewController.m
//  OWNTT
//
//  Created by Kaszuba Maciej on 24/07/14.
//
//

#import "LMSplashViewController.h"
#import "LMLoginViewController.h"
#import "LMReport.h"
#import "SSKeychain.h"

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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.indicatorTextLabel.text = LM_LOCALIZE(@"LMSplash_LoadingData");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //TODO: add tree download mechanism
    [self.activityIndicator startAnimating];
    if(OWNTT_APP_DELEGATE.appUtils.currentUser)
    {
        [self downloadJsonData];
    }
    else
    {
        [self createStaticData];
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
    [[LMNotificationService instance] removeObserver:self forNotification:LMNotification_AlertOperationFinished];
    [[LMNotificationService instance] removeObserver:self forNotification:LMNotification_AlertOperationCancel];
    [self.activityIndicator stopAnimating];
    self.indicatorTextLabel.hidden = YES;
    if(!(OWNTT_APP_DELEGATE.appUtils.currentUser)) {
        [self.parentViewController performSegueWithIdentifier:[LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_PushLogin] sender:self.parentViewController];
    } else {
        [self.parentViewController performSegueWithIdentifier:[LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_PushTabBar] sender:self.parentViewController];
    }
}

- (void)downloadJsonData
{
    if([LMAppUtils connected])
    {
        [[LMNotificationService instance] addObserver:self forNotification:LMNotification_AlertOperationFinished withSelector:@selector(synchronizationEnd)];
        [[LMNotificationService instance] addObserver:self forNotification:LMNotification_AlertOperationCancel withSelector:@selector(synchronizationCancel)];
        [LMUtils performSynchronization:NO];
    }
    else
    {
        [self splashViewControllerDidFinish];
    }
}

- (void)synchronizationEnd
{
    [self splashViewControllerDidFinish];
}

- (void)synchronizationCancel
{
    [self splashViewControllerDidFinish];
}

- (void)createStaticData
{
    NSManagedObjectContext *context = [[LMCoreDataManager sharedInstance] newManagedObjectContext];
    //Create default settings
    //Create reports
    for(int i=0; i<4; i++)
    {
        LMReport *report = [LMReport fetchActiveEntityOfClass:[LMReport class] withObjectID:[NSNumber numberWithInt:i+1] inContext:context];
        if(!report)
        {
            report = [LMReport createObjectInContext:context];
            report.objectId = [NSNumber numberWithInt:i+1];
            report.activeValue = YES;
            switch (i+1) {
                case 1:
                    report.name = @"LMAppReportType_1";
                    report.htmlName = @"1.html";
                    break;
                case 2:
                    report.name = @"LMAppReportType_5";
                    report.htmlName = @"2.html";
                    break;
                case 3:
                    report.name = @"LMAppReportType_6";
                    report.htmlName = @"3.html";
                    break;
                case 4:
                    report.name = @"LMAppReportType_8";
                    report.htmlName = @"3.html";
                    break;
                default:
                    break;
            }
        }
    }
    [LMUtils saveCoreDataContext:context];
}

@end
