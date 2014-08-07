//
//  LMWebViewController.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 06/08/14.
//
//

#import "LMData.h"
#import "LMReport.h"
#import "LMWebViewController.h"
#import "LMNavigationViewController.h"
#import "LMTabBarViewController.h"

@interface LMWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation LMWebViewController

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
    NSManagedObjectContext *mOC = [[LMCoreDataManager sharedInstance] newManagedObjectContext];
    if(self.transactionData.reportId)
    {
        LMReport *report = [LMReport fetchActiveEntityOfClass:[LMReport class] withObjectID:self.transactionData.reportId inContext:mOC];
        NSString *path = [[NSBundle mainBundle]
                          pathForResource:report.htmlName ofType:@"html"];
        NSURL *url = [NSURL fileURLWithPath:path];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView setScalesPageToFit:YES];
        [self.webView loadRequest:request];
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
    return UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight | UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (IBAction)doneAction:(id)sender
{
    [self.parentViewController dismissViewControllerAnimated:YES completion:^{
    }];
    if(!self.isPop)
    {
    [((LMNavigationViewController *)((LMTabBarViewController*)((TTHostViewController *)self.parentViewController).presentingViewController).selectedViewController) popToRootViewControllerAnimated:NO];
    }
}

@end
