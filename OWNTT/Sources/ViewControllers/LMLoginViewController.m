//
//  MLLoginViewController.m
//  OWNTT
//
//  Created by Kaszuba Maciej on 24/07/14.
//
//

#import "LMLoginViewController.h"
#import "LMTextField.h"
#import "LMUser.h"

#define BACKGROUND_IMAGE_VIEW_TAG 99
#define BACKGROUND_STATUS_BAR_TAG 100

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
    self.contentScrollView.backgroundColor = [UIColor redColor];
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
        [self showErrorAlertWithText:text];
        return;
    }
    text = [self.passwordTextField validateField];
    if(text != nil)
    {
        [self showErrorAlertWithText:text];
        return;
    }
    LMUser *user = [LMUser createObjectInContext:self.managedObjectContext];
    user.name = self.loginTextField.text;
    user.password = self.passwordTextField.text;
    [self saveManagedContext];
    [self.parentViewController performSegueWithIdentifier:[LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_PushTabBar] sender:self];
}

#pragma mark -
#pragma mark === Private methods ===
- (void)showErrorAlertWithText:(NSString *)text
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Błąd" message:text delegate:self cancelButtonTitle:@"Popraw" otherButtonTitles:nil];
    [alertView show];
}

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
