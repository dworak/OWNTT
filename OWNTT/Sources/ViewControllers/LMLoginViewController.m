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
#import "LMNavigationViewController.h"
#import "LMTextField.h"
#import "LMUser.h"
#import "LMReadOnlyObject.h"

@interface LMLoginViewController ()
@property (weak, nonatomic) IBOutlet LMTextField *loginTextField;
@property (weak, nonatomic) IBOutlet LMTextField *passwordTextField;

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
    self.navigationItem.hidesBackButton = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
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
- (IBAction)loginButtonTapped:(id)sender {
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
    
    LMUser *user = [LMUser createObjectInContext:self.managedObjectContext];
    user.name = self.loginTextField.text;
    user.password = self.passwordTextField.text;
    LMAppDelegate *appDelegate = ((LMAppDelegate *)[[UIApplication sharedApplication] delegate]);
    appDelegate.appUtils.currentUser = user;
    [self saveManagedContext];
    [LMUtils downloadAppData];
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
@end
