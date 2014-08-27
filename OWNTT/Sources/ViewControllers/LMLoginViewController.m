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

@interface LMLoginViewController ()
@property (weak, nonatomic) IBOutlet LMTextField *loginTextField;
@property (weak, nonatomic) IBOutlet LMTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelItem;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIImageView *shadowImage;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *loadingDataTextField;

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
    self.loginTextField.text = OWNTT_TEST_USER_NAME;
    self.loadingView.alpha = 0;
    
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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
    NSString *text = [self.loginTextField validateField];
    if(text != nil)
    {
        [self shakeAnimation:[NSArray arrayWithObjects:self.loginTextField, nil]];
        [LMUtils showErrorAlertWithText:text];
        return;
    }
    text = [self.passwordTextField validateField];
    if(text != nil)
    {
        [self shakeAnimation:[NSArray arrayWithObjects:self.passwordTextField, nil]];
        [LMUtils showErrorAlertWithText:text];
        return;
    }
    
    NSArray *users = [LMUser fetchLMUsersInContext:self.managedObjectContext];
    if(users.count > 2)
    {
        NSLog(@"Error: tow users in database");
    }
    if(users.count > 0)
    {
        [self.managedObjectContext deleteObject:[users objectAtIndex:0]];
    }
    users = [LMReadOnlyObject fetchActiveEntityOfClass:[LMReadOnlyObject class] inContext:self.managedObjectContext];
    for(LMReadOnlyObject *obj in users)
    {
        [self.managedObjectContext deleteObject:obj];
    }
    
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
             [selfObj saveManagedContext];
             
             [[LMNotificationService instance] addObserver:selfObj forNotification:LMNotification_TreeOperationFinished withSelector:@selector(synchronizationEnd)];
             [[LMNotificationService instance] addObserver:selfObj forNotification:LMNotification_TreeOperationCancel withSelector:@selector(synchronizationCancel)];
             [LMUtils performSynchronization:YES];
         } failureBlock:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             [UIView animateWithDuration:0.2 animations:^{
                 self.loadingView.alpha = 0;
                 [self.activityIndicator stopAnimating];
             } completion:^(BOOL finished) {
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Błąd" message:@"Nie można zarejestrować użytkownika." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                 [alert show];
             }];
         }];
    }];
}

#pragma mark -
#pragma mark === Private methods ===
- (void)checkDependingTreeAndShowBranch {
    
}

- (void)saveManagedContext{
    if(!self.managedObjectContext) {
        NSLog(@"Null context");
        return;
    }
    if(self.managedObjectContext == [[LMCoreDataManager sharedInstance] masterManagedObjectContext]) {
        [[LMCoreDataManager sharedInstance] saveMasterContext];
    } else {
        [self.managedObjectContext performBlockAndWait:^{
            NSError *error = nil;
            BOOL saved = [self.managedObjectContext save:&error];
            if (!saved) {
                // do some real error handling
                NSLog(@"Could not save background context due to %@", error);
            } else {
                [[LMCoreDataManager sharedInstance] saveMasterContext];
            }
        }];
    }
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
    [[LMNotificationService instance] removeObserver:self forNotification:LMNotification_TreeOperationFinished];
    [[LMNotificationService instance] removeObserver:self forNotification:LMNotification_TreeOperationCancel];
    [UIView animateWithDuration:0.2 animations:^{
        self.loadingView.alpha = 0;
        [self.activityIndicator stopAnimating];
    } completion:^(BOOL finished) {
        [self synchronizationEndAction];
    }];
}

- (void)synchronizationCancel
{
    [[LMNotificationService instance] removeObserver:self forNotification:LMNotification_TreeOperationFinished];
    [[LMNotificationService instance] removeObserver:self forNotification:LMNotification_TreeOperationCancel];
    [UIView animateWithDuration:0.2 animations:^{
        self.loadingView.alpha = 0;
        [self.activityIndicator stopAnimating];
    } completion:^(BOOL finished) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Błąd" message:@"Pobieranie danych aplikacji nie powiodło się, spróbuj ponownie." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }];
}


- (void)createReportObjects
{
    for(int i=0; i<3; i++)
    {
        LMReport *report = [LMReport fetchActiveEntityOfClass:[LMReport class] withObjectID:[NSNumber numberWithInt:i+1] inContext:self.managedObjectContext];
        if(!report)
        {
            report = [LMReport createObjectInContext:self.managedObjectContext];
            report.objectId = [NSNumber numberWithInt:i+1];
        }
        report.activeValue = YES;
        switch (i+1) {
            case 1:
                report.name = @"Raport łączny kampanii";
                report.htmlName = @"1.html";
                break;
            case 2:
                report.name = @"Raport wszystkich wydawców";
                report.htmlName = @"2.html";
                break;
            case 3:
                report.name = @"Raport form reklamowych";
                report.htmlName = @"3.html";
            default:
                break;
        }
    }
}


@end
