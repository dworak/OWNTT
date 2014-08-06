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

@interface LMSummaryReportViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *subMenuImage;
@property (weak, nonatomic) IBOutlet UILabel *instanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *advertiserLabel;
@property (weak, nonatomic) IBOutlet UILabel *programLabel;

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
    [self.timeintervalButton setTitle:[self.pickerData objectAtIndex:2] forState:UIControlStateNormal];
    [self.timeintervalButton setTitle:[self.pickerData objectAtIndex:2] forState:UIControlStateHighlighted];
    self.reportNameTextField.delegate = self;
}

- (void)viewDidLayoutSubviews
{
    /*CGRect frame = self.pickerView.frame;
    if(self.pickerViewShow)
    {
        frame.origin.y = self.view.frame.size.height - frame.size.height;
    }
    else
    {
        frame.origin.y = self.view.frame.size.height;
    }
    self.pickerView.frame = frame;*/
    
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

- (IBAction)doneAction:(id)sender
{
    NSString *validate = [self.reportNameTextField validateField];
    if(validate)
    {
        [LMUtils showErrorAlertWithText:validate];
    }
    else
    {
        //[self.parentViewController performSegueWithIdentifier:[LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_PushReportSummary] sender:self];
    }
}

- (IBAction)showPickerTapped:(id)sender
{
    if(self.reportNameTextField.isFirstResponder)
    {
        [self.reportNameTextField resignFirstResponder];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:PICKER_VIEW_WILL_SHOW_NOTIFICATION object:self userInfo:nil];
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

#pragma mark -
#pragma mark === UITextFieldDelegate methods ===
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.pickerViewController hide];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.reportNameTextField resignFirstResponder];
    return YES;
}

@end
