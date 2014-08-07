//
//  LMAlertSummaryViewController.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 06/08/14.
//
//

#import "LMAlertSummaryViewController.h"
#import "LMDataPickerViewController.h"
#import "LMDatePickerViewController.h"
#import "LMButton.h"
#import "LMTextField.h"
#import "LMReferenceData.h"
#import "LMInstance.h"
#import "LMReport.h"
#import "LMAdvertiser.h"
#import "LMProgram.h"
#import "LMUserAlert.h"
#import "LMUser.h"

@interface LMAlertSummaryViewController ()
@property (weak, nonatomic) IBOutlet LMTextField *alertNameTextField;
@property (strong, nonatomic) NSDateFormatter *dateFormater;
@property (weak, nonatomic) IBOutlet LMButton *dateFrom;
@property (weak, nonatomic) IBOutlet LMButton *dateTo;
@property (weak, nonatomic) IBOutlet LMButton *monitoringType;
@property (weak, nonatomic) IBOutlet LMButton *rateType;
@property (weak, nonatomic) IBOutlet LMButton *hourOfSend;
@property (weak, nonatomic) IBOutlet LMTextField *valueTextField;

@property (weak, nonatomic) UIButton *currentButton;

@end

@implementation LMAlertSummaryViewController

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
    self.dateFormater = [[NSDateFormatter alloc] init];
    [self.dateFormater setDateFormat:@"yyyy-MM-dd"];
    self.scrollView.contentSize = CGSizeMake(320, self.view.frame.size.height-64);
    
    [self.dateFrom setTitle:[self.dateFormater stringFromDate:[NSDate date]] forState:UIControlStateNormal];
    [self.dateFrom setTitle:[self.dateFormater stringFromDate:[NSDate date]] forState:UIControlStateHighlighted];
    [self.dateTo setTitle:[self.dateFormater stringFromDate:[NSDate date]] forState:UIControlStateNormal];
    [self.dateTo setTitle:[self.dateFormater stringFromDate:[NSDate date]] forState:UIControlStateHighlighted];
    self.valueTextField.text = @"0";
    
    
    [self.alertNameTextField addValidation:LMTextFieldValidaitonType_Name];
    [self.valueTextField addValidation:LMTextFieldValidaitonType_Value];
    
    self.managedObjectContext = [[LMCoreDataManager sharedInstance] newManagedObjectContext];
    LMInstance *instance = [LMInstance fetchActiveEntityOfClass:[LMInstance class] withObjectID:self.transactionData.instanceId inContext:self.managedObjectContext];
    if(instance)
    {
        self.instanceLabel.text = instance.name;
        for(LMAdvertiser *advertiser in instance.advertisers.allObjects)
        {
            if(advertiser.objectId.intValue == self.transactionData.advertiserId.intValue)
            {
                self.advertiserLabel.text = advertiser.name;
                for(LMProgram *program in advertiser.programs.allObjects)
                {
                    if(program.objectId.intValue == self.transactionData.programId.intValue)
                    {
                        self.programLabel.text = program.name;
                    }
                }
                break;
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}

- (BOOL)shouldAutorotate
{
    return YES;
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

/*- (void)viewDidLayoutSubviews
{
    if(self.pickerViewController)
    {
        [self.pickerViewController updateFrameForOrientation:self.interfaceOrientation];
    }
    
    if(self.datePickerController)
    {
        [self.datePickerController updateFrameForOrientation:self.interfaceOrientation];
    }
}*/

- (BOOL)isValid
{
    NSString *message = [self.alertNameTextField validateField];
    if (!message)
    {
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *dateFrom = [dateFormatter dateFromString:self.dateFrom.titleLabel.text];
        NSDate *dateTo = [dateFormatter dateFromString:self.dateTo.titleLabel.text];
        if([dateFrom compare:dateTo] == NSOrderedSame || [dateFrom compare:dateTo] == NSOrderedDescending)
        {
            message = @"Data do musi być większa niż data od";
        }
        if(!message)
        {
            message = [self.valueTextField validateField];
        }
    }
    if(message)
    {
        [LMUtils showErrorAlertWithText:message];
        return NO;
    }
    else
    {
        return YES;
    }
}

- (void)saveObjectData
{
    NSManagedObjectContext *managedObjectContext = [[LMCoreDataManager sharedInstance] newManagedObjectContext];
    LMUser *user = [[LMUser fetchLMUsersInContext:managedObjectContext] objectAtIndex:0];
    LMUserAlert *userAlert = [LMUserAlert createObjectInContext:managedObjectContext];
    userAlert.name = self.alertNameTextField.text;
    userAlert.createDate = [NSDate date];
    [user.userAlertsSet addObject:userAlert];
    [LMUtils saveCoreDataContext:managedObjectContext];
}

- (IBAction)buttonTapped:(id)sender
{
    BOOL isPickerData = YES;
    self.currentButton = (UIButton *)sender;
    NSArray *dataArray;
    int defaultStartValue = -1;
    switch (self.currentButton.tag) {
        case LMAlertSummaryButtonType_DateFrom:
            isPickerData = NO;
            break;
        case LMAlertSummaryButtonType_DateTo:
            isPickerData = NO;
            break;
        case LMAlertSummaryButtonType_Hour:
            defaultStartValue = 0;
            dataArray = [LMReferenceData staticAlertHourTypes];
            break;
        case LMAlertSummaryButtonType_Monitoring:
            defaultStartValue = 0;
            dataArray = [LMReferenceData staticAlertMonitoringTypes];
            break;
        case LMAlertSummaryButtonType_Pointer:
            defaultStartValue = 1;
            dataArray = [LMReferenceData staticAlertPointerTypes];
            break;
        default:
            break;
    }
    
    if(isPickerData)
    {
        if(self.currentEditingTextField)
        {
            [self.currentEditingTextField resignFirstResponder];
        }
        if(self.datePickerController)
        {
            [self.datePickerController hide];
        }
        if(!self.pickerViewController)
        {
            self.pickerViewController = [[LMDataPickerViewController alloc] init];
            __weak LMAlertSummaryViewController *selfObj = self;
            self.pickerViewController.pickerViewCancelAction = ^()
            {
                [selfObj.pickerViewController hide];
            };
            self.pickerViewController.pickerViewDoneAction = ^(NSString *value)
            {
                [selfObj.currentButton setTitle:value forState:UIControlStateNormal];
                [selfObj.currentButton setTitle:value forState:UIControlStateHighlighted];
                [selfObj.pickerViewController hide];
            };
        }
        [self.pickerViewController addPickerData:dataArray];
        [self.pickerViewController showInView:self.view];
        int defaultVal = 0;
        BOOL check = NO;
        for(NSString *str in dataArray)
        {
            if([str isEqualToString:self.currentButton.titleLabel.text])
            {
                check = YES;
                break;
            }
            defaultVal++;
        }
        if(!check) {
            defaultVal = -1;
        }
        if(defaultVal != -1)
        {
            [self.pickerViewController selectPickerObject:defaultVal];
        }
        else
        {
            if(defaultStartValue != -1)
            {
                [self.pickerViewController selectPickerObject:defaultStartValue];
            }
            else
            {
                [self.pickerViewController selectPickerObject:-1];
            }
        }
    }
    else
    {
        if(self.currentEditingTextField)
        {
            [self.currentEditingTextField resignFirstResponder];
        }
        if(self.pickerViewController)
        {
            [self.pickerViewController hide];
        }
        if(!self.datePickerController)
        {
            self.datePickerController = [[LMDatePickerViewController alloc] init];
            __weak LMAlertSummaryViewController *selfObj = self;
            self.datePickerController.pickerViewCancelAction = ^()
            {
                [selfObj.pickerViewController hide];
            };
            self.datePickerController.pickerViewDoneAction = ^(NSDate *value)
            {
                NSString *date = [selfObj.dateFormater stringFromDate:value];
                [selfObj.currentButton setTitle:date forState:UIControlStateNormal];
                [selfObj.currentButton setTitle:date forState:UIControlStateHighlighted];
                [selfObj.datePickerController hide];
            };
        }
        [self.datePickerController showInView:self.view];
        NSString *pickerDate = [self.dateFormater stringFromDate:[NSDate date]];
        if([pickerDate isEqualToString:self.currentButton.titleLabel.text])
        {
            [self.datePickerController setPickerDate:[NSDate date]];
        }
        else
        {
            [self.datePickerController setPickerDate:nil];
        }
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
    [textField resignFirstResponder];
    return YES;
}

@end
