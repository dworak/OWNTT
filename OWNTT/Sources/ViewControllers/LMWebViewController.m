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
#import "LMSettings.h"
#import "LMAppUtils.h"

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
        self.localContext = [[LMCoreDataManager sharedInstance] newManagedObjectContext];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if([LMAppUtils connected])
    {
        [self showReport];
    }
    else
    {
        [LMAlertManager showErrorAlertWithOkWithText:LM_LOCALIZE(@"LMAlertManager_ReportConnectionError") delegate:self];
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

- (void)showReport
{
    LMReport *report = [LMReport fetchActiveEntityOfClass:[LMReport class] withObjectID:self.transactionData.reportId inContext:self.localContext];
    LMUser *user = OWNTT_APP_DELEGATE.appUtils.currentUser;
    NSString *dateFrom;
    NSString *dateTo;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    if(user.settings.reportDefaultIsEnumValue)
    {
        NSArray *dates = [LMUtils datesForReportTimeInterval:user.settings.reportDefaultEnum.intValue];
        if(dates.count > 1)
        {
            dateFrom = [dateFormatter stringFromDate:[dates objectAtIndex:0]];
            dateTo = [dateFormatter stringFromDate:[dates objectAtIndex:1]];
        }
        else
        {
            NSLog(@"Error: dates array has only one element");
            return;
        }
    }
    else
    {
        if(user.settings.reportDefaultDateFrom)
        {
            dateFrom = [dateFormatter stringFromDate:user.settings.reportDefaultDateFrom];
        }
        if(user.settings.reportDefaultDateTo)
        {
            dateTo = [dateFormatter stringFromDate:user.settings.reportDefaultDateTo];
        }
    }
    
    //NSLog(@"Report for dates: %@ %@", dateFrom, dateTo);
    [[LMOWNTTHTTPClient sharedClient] POSTHTTPRequestOperationForServiceName:LMOWNTTHTTPClientServiceName_GetReport parameters:[LMOWNTTHTTPClient getReportParamsToken:user.httpToken reportType:[LMOWNTTHTTPClient reportTypeName:(int)report.objectIdValue] dateFrom:dateFrom dateTo:dateTo programIds:self.transactionData.programIds] succedBlock:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSString *base64String = [responseObject valueForKeyPath:@"encodedReportContentHtml"];
         NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
         //NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
         [self.webView setScalesPageToFit:YES];
         [self.webView loadData:decodedData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:[NSURL URLWithString:@""]];
     }
                                                                failureBlock:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSString *message;
         if(error.code == 403)
         {
             message = LM_LOCALIZE(@"LMAlertManager_ReportAccessError");
         }
         else if(error.code == 500)
         {
             message = LM_LOCALIZE(@"LMAlertManager_ReportServerError");
         }
         else if (error.code == 400)
         {
             message = LM_LOCALIZE(@"LMAlertManager_RepotBadRequest");
         }
         [LMAlertManager showErrorAlertWithOkWithText:message delegate:nil];
     }];
}

#pragma mark -
#pragma mark === UIAlertViewDelegate ===
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self doneAction:nil];
}

@end
