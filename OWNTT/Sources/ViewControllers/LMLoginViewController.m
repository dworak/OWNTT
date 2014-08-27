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

@interface LMLoginViewController ()
@property (weak, nonatomic) IBOutlet LMTextField *loginTextField;
@property (weak, nonatomic) IBOutlet LMTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelItem;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIImageView *shadowImage;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

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
        [LMUtils downloadAppData];
        if(selfObj.isPresentModal)
        {
            if([selfObj.presentingViewController isKindOfClass:[UITabBarController class]])
            {
                //[((UITabBarController *)self.presentingViewController).presentingViewController
            }
            [selfObj.parentViewController dismissViewControllerAnimated:YES completion:^{
            }];
        }
        else
        {
            [selfObj.parentViewController performSegueWithIdentifier:[LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_PushTabBar] sender:selfObj];
        }
    } failureBlock:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        nil;
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
@end
