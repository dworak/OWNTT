//
//  LMSummaryReportViewController.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 28/07/14.
//
//

#import "LMSummaryReportViewController.h"
#import "LMButton.h"
#import "LMTextField.h"
#import "LMDataPickerViewController.h"
#import "LMNavigationViewController.h"
#import "LMUserReport.h"
#import "LMReport.h"
#import "LMUser.h"

@interface LMSummaryReportViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet LMTextField *reportNameTextField;
@property (weak, nonatomic) IBOutlet LMButton *timeintervalButton;

@end

@implementation LMSummaryReportViewController

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
    self.pickerData = [LMReferenceData staticReportTimeIntervalValues];
    [self.reportNameTextField addValidation:LMTextFieldValidaitonType_Name];
    [self.timeintervalButton setTitle:[self.pickerData objectAtIndex:2] forState:UIControlStateNormal];
    [self.timeintervalButton setTitle:[self.pickerData objectAtIndex:2] forState:UIControlStateHighlighted];
    self.reportNameTextField.delegate = self;
    self.scrollView.contentSize = CGSizeMake(320, self.view.frame.size.height-64);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.reportNameTextField.delegate = nil;
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

- (BOOL)isValid
{
    NSString *validate = [self.reportNameTextField validateField];
    if(validate)
    {
        [LMUtils showErrorAlertWithText:validate];
        return NO;
    }
    return YES;
}

- (IBAction)showPickerTapped:(id)sender
{
    if(self.reportNameTextField.isFirstResponder)
    {
        [self.reportNameTextField resignFirstResponder];
    }
    if(!self.pickerViewController)
    {
        self.pickerViewController = [[LMDataPickerViewController alloc] init];
        __weak LMSummaryReportViewController *selfObj = self;
        self.pickerViewController.pickerViewCancelAction = ^()
        {
            [selfObj.pickerViewController hide];
        };
        self.pickerViewController.pickerViewDoneAction = ^(NSString *value)
        {
            [selfObj.timeintervalButton setTitle:value forState:UIControlStateNormal];
            [selfObj.timeintervalButton setTitle:value forState:UIControlStateHighlighted];
            [selfObj.pickerViewController hide];
        };
    }
    
    [self.pickerViewController addPickerData:self.pickerData];
    [self.pickerViewController showInView:self.view];
    NSString *defaultVal = [self.pickerData objectAtIndex:2];
    if([defaultVal isEqualToString:self.timeintervalButton.titleLabel.text])
    {
        [self.pickerViewController selectPickerObject:2];
    }
    else
    {
        [self.pickerViewController selectPickerObject:-1];
    }
}

- (void)saveObjectData
{
    self.managedObjectContext = [[LMCoreDataManager sharedInstance] newManagedObjectContext];
    self.managedObjectContext.stalenessInterval = 0;
    LMUser *user = [[LMUser fetchLMUsersInContext:self.managedObjectContext] objectAtIndex:0];
    LMUserReport *userReport = [LMUserReport createObjectInContext:self.managedObjectContext];
    LMReport *report = [LMReport fetchActiveEntityOfClass:[LMReport class] withObjectID:self.transactionData.reportId inContext:self.managedObjectContext];
    userReport.reportObject = report;
    userReport.createDate = [NSDate date];
    userReport.name = self.reportNameTextField.text;
    [user.userReportsSet addObject:userReport];
    [LMUtils saveCoreDataContext:self.managedObjectContext];
}

#pragma mark -
#pragma mark === UITextFieldDelegate methods ===
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.currentEditingTextField = textField;
    [self.pickerViewController hide];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.reportNameTextField resignFirstResponder];
    return YES;
}

@end
