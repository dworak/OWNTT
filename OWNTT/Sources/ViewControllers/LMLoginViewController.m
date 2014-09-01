//
//  MLLoginViewController.m
//  OWNTT
//
//  Created by Kaszuba Maciej on 24/07/14.
//
//

#import "LMAppDelegate.h"
#import "LMBranchInstanceViewController.h"
#import "LMLoginViewController.h"
#import "LMSettingsViewController.h"
#import "LMNavigationViewController.h"
#import "LMTabBarViewController.h"
#import "LMTextField.h"
#import "LMUser.h"
#import "LMReadOnlyObject.h"
#import "LMReport.h"
#import "LMSettings.h"

@interface LMLoginViewController ()
@property (weak, nonatomic) IBOutlet LMTextField *loginTextField;
@property (weak, nonatomic) IBOutlet LMTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelItem;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIImageView *shadowImage;
@property (weak, nonatomic) IBOutlet LMFullButton *loginButton;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *loadingDataTextField;
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;

- (void)setLocalizationStrings;
@end

@implementation LMLoginViewController 

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
    self.toolbar.clipsToBounds = YES;
    self.navigationItem.hidesBackButton = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    //self.loginTextField.text = OWNTT_TEST_USER_NAME;
    self.shadowImage.image = [[UIImage imageNamed:@"top_shadow.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    
    // Firstly for purpouse of storing all of the fields we remove all of the items from view
    NSArray *subviews = self.view.subviews;
    
    for (UIView *v in subviews)
    {
        if ((v!=self.contentScrollView) && (![v conformsToProtocol:@protocol(UILayoutSupport)]))
        {
            if (v.tag!=BACKGROUND_IMAGE_VIEW_TAG && v.tag!=BACKGROUND_STATUS_BAR_TAG)
            {
                [v removeFromSuperview];
            }
        }
    }
    
    // Now  we add them directly to our scrolled one
    [subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        
        if((obj!=self.contentScrollView) && (![obj conformsToProtocol:@protocol(UILayoutSupport)]))
        {
            if (obj.tag!=BACKGROUND_IMAGE_VIEW_TAG && obj.tag!=BACKGROUND_STATUS_BAR_TAG)
            {
                [self addContentSubview:obj];
            }
        }
    }];
    self.managedObjectContext = [[LMCoreDataManager sharedInstance] newManagedObjectContext];
    
    [self.loginTextField addValidation:LMTextFieldValidaitonType_Login];
    [self.passwordTextField addValidation:LMTextFieldValidaitonType_Password];
    self.toolbar.hidden = !self.showToolbar;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.loadingView.alpha = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectionNotificationChange) name:LM_CONNECTION_NOTIFICATION_CHANGE object:nil];
    [self connectionNotificationChange];
    [self setLocalizationStrings];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareChildForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

#pragma mark -
#pragma mark === IBAction methods ===
- (IBAction)cancelTapped:(id)sender
{
    for(UIViewController *controller in ((LMTabBarViewController *)self.presentingViewController).viewControllers)
    {
        if([controller isKindOfClass:[TTHostViewController class]])
        {
            TTHostViewController *hostController = (TTHostViewController *)controller;
            if([hostController.childViewController isKindOfClass:[LMSettingsViewController class]])
            {
                ((LMTabBarViewController *)self.presentingViewController).selectedViewController = hostController;
            }
        }
    }
    [self.parentViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)loginButtonTapped:(id)sender
{
    //Add fields validation
    __weak LMLoginViewController *selfObj = self;
    [self.currentEditingTextField resignFirstResponder];
    NSString *text = [self.loginTextField validateField];
    if(text != nil)
    {
        [self shakeAnimation:[NSArray arrayWithObjects:self.loginTextField, nil]];
        [LMAlertManager showErrorAlertWithOkWithText:text];
        return;
    }
    text = [self.passwordTextField validateField];
    if(text != nil)
    {
        [self shakeAnimation:[NSArray arrayWithObjects:self.passwordTextField, nil]];
        [LMAlertManager showErrorAlertWithOkWithText:text];
        return;
    }
    
    if(OWNTT_APP_DELEGATE.appUtils.currentUser)
    {
        LMUser *user = OWNTT_APP_DELEGATE.appUtils.currentUser;
        [[LMOWNTTHTTPClient sharedClient] POSTHTTPRequestOperationForServiceName:LMOWNTTHTTPClientServiceName_UnregisterDevice parameters:[LMOWNTTHTTPClient unregisterDeviceParamsToken:user.httpToken] succedBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
            [[[LMCoreDataManager sharedInstance] masterManagedObjectContext] deleteObject:user];
            [selfObj successAction];
            [[LMCoreDataManager sharedInstance] saveMasterContext];
        } failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
            [LMAlertManager showErrorAlertWithOkWithText:LM_LOCALIZE(@"LMAlertManager_LoginRemoveUser")];
        }];
    } else{
        [self successAction];
    }
}

- (void)successAction
{
    __weak LMLoginViewController *selfObj = self;
    [UIView animateWithDuration:0.2 animations:^{
        [self.activityIndicator startAnimating];
        self.loadingView.alpha = 1;
    } completion:^(BOOL finished) {
        [[LMOWNTTHTTPClient sharedClient] POSTHTTPRequestOperationForServiceName:LMOWNTTHTTPClientServiceName_RegisterDevice parameters:[LMOWNTTHTTPClient registerDeviceParamsLogin:self.loginTextField.text password:self.passwordTextField.text pushKey:OWNTT_APP_DELEGATE.appUtils.notSaveDeviceKey os:OWNTT_HTTP_CLIENT_OS_PARAM] succedBlock:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSDictionary *response = (NSDictionary *)responseObject;
             LMUser *user = [LMUser createObjectInContext:selfObj.managedObjectContext];
             user.email = selfObj.loginTextField.text;
             user.password = selfObj.passwordTextField.text;
             user.name = [response valueForKey:@"name"];
             user.surname = [response valueForKey:@"surname"];
             user.httpToken = [response valueForKey:@"token"];
             LMAppDelegate *appDelegate = ((LMAppDelegate *)[[UIApplication sharedApplication] delegate]);
             appDelegate.appUtils.currentUser = user;
             if(appDelegate.appUtils.currentUser)
             {
                 //Configure default setting
                 LMUser *user = appDelegate.appUtils.currentUser;
                 LMSettings *settings = [LMSettings createObjectInContext:selfObj.managedObjectContext];
                 settings.reportDefaultEnum = [NSNumber numberWithInt:ReportTimeInterval_Today];
                 settings.reportDefaultIsEnum = [NSNumber numberWithBool:YES];
                 [user setSettings:settings];
             }
             [LMUtils saveCoreDataContext:selfObj.managedObjectContext];
             
             //Change current user
             [LMUtils getCurrentUser];
             
             [[LMNotificationService instance] addObserver:selfObj forNotification:LMNotification_AlertOperationFinished withSelector:@selector(synchronizationEnd)];
             [[LMNotificationService instance] addObserver:selfObj forNotification:LMNotification_AlertOperationCancel withSelector:@selector(synchronizationCancel)];
             [LMUtils performSynchronization:YES];
         } failureBlock:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             [UIView animateWithDuration:0.2 animations:^{
                 selfObj.loadingView.alpha = 0;
                 [selfObj.activityIndicator stopAnimating];
             } completion:^(BOOL finished) {
                 [LMAlertManager showErrorAlertWithOkWithText:LM_LOCALIZE(@"LMAlertManager_LoginRegisterDevice")];
             }];
         }];
    }];
}

#pragma mark -
#pragma mark === Private methods ===
- (void)setLocalizationStrings
{
    self.warningLabel.text = LM_LOCALIZE(@"LMLogin_WarningLabel");
    [self.loginButton setTitle:LM_LOCALIZE(@"LMLogin_LoginButton") forState:UIControlStateNormal];
    [self.loginButton setTitle:LM_LOCALIZE(@"LMLogin_LoginButton") forState:UIControlStateHighlighted];
    self.loadingDataTextField.text = LM_LOCALIZE(@"LMLogin_LoadingDataLabel");
    self.loginTextField.placeholder = LM_LOCALIZE(@"LMLogin_LoginPlaceholder");
    self.passwordTextField.placeholder = LM_LOCALIZE(@"LMLogin_PasswordPlaceholder");
}

- (void)connectionNotificationChange
{
    if(![LMAppUtils connected])
    {
        self.warningLabel.hidden = NO;
        self.loginButton.enabled = NO;
        self.loginTextField.enabled = NO;
        self.passwordTextField.enabled = NO;
    }
    else
    {
        self.warningLabel.hidden = YES;
        self.loginButton.enabled = YES;
        self.loginTextField.enabled = YES;
        self.passwordTextField.enabled = YES;
    }
}

- (void)checkDependingTreeAndShowBranch {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.currentEditingTextField resignFirstResponder];
    [self loginButtonTapped:nil];
    return YES;
}

- (void)synchronizationEndAction
{
    if(self.isPresentModal)
    {
        if([self.presentingViewController isKindOfClass:[UITabBarController class]])
        {
            //[((UITabBarController *)self.presentingViewController).presentingViewController
        }
        [self.parentViewController dismissViewControllerAnimated:YES completion:^{
        }];
    }
    else
    {
        [self.parentViewController performSegueWithIdentifier:[LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_PushTabBar] sender:self];
    }
}

- (void)synchronizationEnd
{
    [[LMNotificationService instance] removeObserver:self forNotification:LMNotification_AlertOperationFinished];
    [[LMNotificationService instance] removeObserver:self forNotification:LMNotification_AlertOperationCancel];
    [UIView animateWithDuration:0.2 animations:^{
        self.loadingView.alpha = 0;
        [self.activityIndicator stopAnimating];
    } completion:^(BOOL finished) {
        [self synchronizationEndAction];
    }];
}

- (void)synchronizationCancel
{
    [[LMNotificationService instance] removeObserver:self forNotification:LMNotification_AlertOperationCancel];
    [[LMNotificationService instance] removeObserver:self forNotification:LMNotification_AlertOperationFinished];
    [UIView animateWithDuration:0.2 animations:^{
        self.loadingView.alpha = 0;
        [self.activityIndicator stopAnimating];
    } completion:^(BOOL finished) {
        [LMAlertManager showErrorAlertWithOkWithText:LM_LOCALIZE(@"LMAlertManager_LoginSynchronizationError")];
    }];
}


@end
