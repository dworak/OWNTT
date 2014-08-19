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
#import "LMBranchAdvertiserViewController.h"
#import "LMSegueKeys.h"

@interface LMWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSManagedObjectContext *localContext;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIImageView *shadowImageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backArrow;

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
    //[self createLeftButton:YES withSelector:@selector(doneAction) text:@"<"];
    //[self createLeftButton:NO withSelector:@selector(showDate) text:@"Date"];
    /*UIImageView *titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 118, 36)];
    titleImage.image = [UIImage imageNamed:@"logo.png"];
    [self.parentViewController.navigationItem setTitleView:titleImage];
    */
    [self.backArrow setTitleTextAttributes:@{NSForegroundColorAttributeName:TOOLBAR_ITEM_TEXT_COLOR_NORMAL,
                                             NSFontAttributeName: TOOLBAR_ITEM_FONT
                                             } forState:UIControlStateNormal];
    [self.backArrow setTitleTextAttributes:@{NSForegroundColorAttributeName:TOOLBAR_ITEM_TEXT_COLOR_HIGHLIGHTEN,
                                             NSFontAttributeName: TOOLBAR_ITEM_FONT
                                             } forState:UIControlStateHighlighted];
    
    self.toolbar.clipsToBounds = YES;
    
    if(!self.localContext)
    {
        self.localContext = [[LMCoreDataManager sharedInstance] masterManagedObjectContext];
    }
    if(self.transactionData.reportId)
    {
        LMReport *report = [LMReport fetchActiveEntityOfClass:[LMReport class] withObjectID:self.transactionData.reportId inContext:self.localContext];
        if(report && report.htmlName)
        {
            NSString *path = [[NSBundle mainBundle]
                              pathForResource:report.htmlName ofType:nil]
            ;
            NSURL *url = [NSURL fileURLWithPath:path];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [self.webView setScalesPageToFit:YES];
            [self.webView loadRequest:request];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.shadowImageView.image = [[UIImage imageNamed:@"top_shadow.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
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
        LMNavigationViewController *navcontroller = ((LMNavigationViewController *)((LMTabBarViewController*)((TTHostViewController *)self.parentViewController).presentingViewController).selectedViewController);
        if(!self.isInstance)
        {
            UIViewController *top;
            for(UIViewController *controller in navcontroller.viewControllers)
            {
                if([((TTHostViewController *)controller).childViewController isKindOfClass:[LMBranchAdvertiserViewController class]])
                {
                    top = controller;
                    break;
                }
            }
            if(top)
            {
                [navcontroller popToViewController:top animated:NO];
            }
        }
        else
        {
            [navcontroller popToRootViewControllerAnimated:NO];
        }
    }
}

- (IBAction)showDate:(id)sender
{
    [self.parentViewController performSegueWithIdentifier:[LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_ModalDate] sender:self];
}

- (void)createLeftButton:(BOOL)left withSelector:(SEL)selector text:(NSString *)text
{
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:text style:UIBarButtonItemStylePlain target:nil action:nil];
    [buttonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:NAVIGATION_ITEM_TEXT_COLOR_NORMAL,
                                             NSFontAttributeName: NAVIGATION_ITEM_FONT
                                             } forState:UIControlStateNormal];
    [buttonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:NAVIGATION_ITEM_TEXT_COLOR_HIGHLIGHTEN,
                                             NSFontAttributeName: NAVIGATION_ITEM_FONT
                                             } forState:UIControlStateHighlighted];
    [buttonItem setAction:selector];
    [buttonItem setTarget:self];
    if(left)
    {
        [self.parentViewController.navigationItem setLeftBarButtonItem:buttonItem];
    }
    else
    {
        [self.parentViewController.navigationItem setRightBarButtonItem:buttonItem];
    }
}

@end
