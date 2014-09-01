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
#import "LMBranchNameView.h"
#import "LMUtils.h"

@interface LMAlertSummaryViewController ()
@property (weak, nonatomic) IBOutlet LMTextField *alertNameTextField;
@property (strong, nonatomic) NSDateFormatter *dateFormater;
@property (weak, nonatomic) IBOutlet LMButton *dateFrom;
@property (weak, nonatomic) IBOutlet LMButton *dateTo;
@property (weak, nonatomic) IBOutlet LMButton *monitoringType;
@property (weak, nonatomic) IBOutlet LMButton *rateType;
@property (weak, nonatomic) IBOutlet LMButton *hourOfSend;
@property (weak, nonatomic) IBOutlet LMButton *borderType;
@property (weak, nonatomic) IBOutlet LMTextField *valueTextField;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;

@property (weak, nonatomic) UIButton *currentButton;
@property (weak, nonatomic) IBOutlet UILabel *dateFromLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateToLabel;
@property (weak, nonatomic) IBOutlet UILabel *monitorTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointerLabel;
@property (weak, nonatomic) IBOutlet UILabel *hourLabel;
@property (weak, nonatomic) IBOutlet UILabel *alertNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

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
    self.checkButton.exclusiveTouch = YES;
    self.dateFormater = [[NSDateFormatter alloc] init];
    [self.dateFormater setDateFormat:@"yyyy-MM-dd"];
    self.scrollView.contentSize = CGSizeMake(320, self.view.frame.size.height-64);
    
    [self.dateFrom setTitle:[self.dateFormater stringFromDate:[NSDate date]] forState:UIControlStateNormal];
    [self.dateFrom setTitle:[self.dateFormater stringFromDate:[NSDate date]] forState:UIControlStateHighlighted];
    [self.dateTo setTitle:[self.dateFormater stringFromDate:[NSDate date]] forState:UIControlStateNormal];
    [self.dateTo setTitle:[self.dateFormater stringFromDate:[NSDate date]] forState:UIControlStateHighlighted];
    
    [self.borderType setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.borderType setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 1)];
    
    self.valueTextField.text = @"";
    
    
    [self.alertNameTextField addValidation:LMTextFieldValidaitonType_Name];
    [self.valueTextField addValidation:LMTextFieldValidaitonType_Value];
    
    LMInstance *instance = [LMInstance fetchActiveEntityOfClass:[LMInstance class] withObjectID:self.transactionData.instanceId inContext:self.managedObjectContext];
    if(instance)
    {
        for(LMAdvertiser *advertiser in instance.advertisers.allObjects)
        {
            if(advertiser.objectId.intValue == self.transactionData.advertiserId.intValue)
            {
                self.nameView.firstName.text = advertiser.name;
                for(LMProgram *program in advertiser.programs.allObjects)
                {
                    NSNumber *selectedProgram = [self.transactionData.programIds objectAtIndex:0];
                    if(program.objectId.intValue == selectedProgram.intValue)
                    {
                        self.nameView.SecondName.text = program.name;
                    }
                }
                break;
            }
        }
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(![LMAppUtils connected])
    {
        [LMAlertManager showErrorAlertWithOkWithText:LM_LOCALIZE(@"LMAlertManager_AlertConnectionError") delegate:self];
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

- (void)setLocalizationStrings
{
    self.dateFromLabel.text = LM_LOCALIZE(@"LMSumAlert_DateFormLabel");
    self.dateToLabel.text = LM_LOCALIZE(@"LMSumAlert_DateToLabel");
    self.monitorTypeLabel.text = LM_LOCALIZE(@"LMSumAlert_MonitorType");
    self.pointerLabel.text = LM_LOCALIZE(@"LMSumAlert_PointerLabel");
    self.hourLabel.text = LM_LOCALIZE(@"LMSumAlert_HourLabel");
    self.alertNameLabel.text = LM_LOCALIZE(@"LMSumAlert_AlertNameLabel");
    self.valueLabel.text = LM_LOCALIZE(@"LMSumAlert_ValueLabel");
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
        if(self.checkButton.selected)
        {
            NSDateFormatter *dateFormatter = [NSDateFormatter new];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *dateFrom = [dateFormatter dateFromString:self.dateFrom.titleLabel.text];
            NSDate *dateTo = [dateFormatter dateFromString:self.dateTo.titleLabel.text];
            if([dateFrom compare:dateTo] == NSOrderedSame || [dateFrom compare:dateTo] == NSOrderedDescending)
            {
                message = @"Data do musi być większa niż data od";
            }
        }
        if(!message)
        {
            message = [self.valueTextField validateField];
        }
    }
    if(message)
    {
        [LMAlertManager showErrorAlertWithOkWithText:message delegate:nil];
        return NO;
    }
    else
    {
        return YES;
    }
}

- (void)saveObjectData
{
    [[[LMCoreDataManager sharedInstance] masterManagedObjectContext] refreshObject:OWNTT_APP_DELEGATE.appUtils.currentUser mergeChanges:YES];
    if(![LMAppUtils connected])
    {
        [LMAlertManager showErrorAlertWithOkWithText:LM_LOCALIZE(@"LMAlertManager_AlertConnectionError") delegate:nil];
        return;
    }
    NSNumberFormatter *decimalFormater = [NSNumberFormatter new];
    [decimalFormater setNumberStyle:NSNumberFormatterDecimalStyle];
    LMUser *user = [[LMUser fetchLMUsersInContext:self.managedObjectContext] objectAtIndex:0];
    LMUserAlert *userAlert = [LMUserAlert createObjectInContext:self.managedObjectContext];
    userAlert.name = self.alertNameTextField.text;
    userAlert.paramTypeValue = [LMUtils alertPointerStringToType:self.rateType.titleLabel.text];
    userAlert.monitorTypeValue = [LMUtils alertMonitoringStringToType:self.monitoringType.titleLabel.text];
    userAlert.borderTypeValue = [LMUtils alertBorderStringToType:self.borderType.titleLabel.text];
    userAlert.hour = [decimalFormater numberFromString:self.hourOfSend.titleLabel.text];
    userAlert.programId = [self.transactionData.programIds objectAtIndex:0];
    userAlert.dateFrom = [self.dateFormater dateFromString:self.dateFrom.titleLabel.text];
    userAlert.dateTo = [self.dateFormater dateFromString:self.dateTo.titleLabel.text];
    userAlert.value = self.valueTextField.text;
    userAlert.objectIdValue = OWNTT_APP_DELEGATE.appUtils.currentUser.alertsCountValue+1;
    OWNTT_APP_DELEGATE.appUtils.currentUser.alertsCount = [NSNumber numberWithInt:userAlert.objectId.intValue];
    userAlert.createDate = [NSDate date];
    [user.userAlertsSet addObject:userAlert];
    [LMUtils saveCoreDataContext:self.managedObjectContext];
    
    //Send alert
    [[LMOWNTTHTTPClient sharedClient] POSTHTTPRequestOperationForServiceName:LMOWNTTHTTPClientServiceName_RegisterAlertPush parameters:[LMOWNTTHTTPClient registerAlertPushParams:userAlert] succedBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self endAction];
    } failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *message;
        if(error.code == 403)
        {
            message = LM_LOCALIZE(@"LMAlertManager_AlertAccessError");
        }
        else if(error.code == 500)
        {
            message = LM_LOCALIZE(@"LMAlertManager_AlertServerError");
        }
        else if (error.code == 400)
        {
            message = LM_LOCALIZE(@"LMAlertManager_AlertBadRequest");
        }
        else
        {
            message = LM_LOCALIZE(@"LMAlertManager_AlertAuthorizationError");
        }
        [LMAlertManager showErrorAlertWithOkWithText:message delegate:nil];
    }];
}

- (IBAction)checkboxTapped:(id)sender
{
    self.checkButton.selected = !self.checkButton.selected;
    if(self.checkButton.selected)
    {
        self.dateTo.enabled = YES;
    }
    else
    {
        self.dateTo.enabled = NO;
    }
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
        case LMAlertSummaryButtonType_Border:
            defaultStartValue = 0;
            dataArray = [LMReferenceData staticAlertBorderTypes];
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
                if([selfObj.currentButton isEqual:selfObj.hourOfSend])
                {
                    [selfObj.currentButton setTitle:value forState:UIControlStateNormal];
                    [selfObj.currentButton setTitle:value forState:UIControlStateHighlighted];
                }
                else
                {
                    [selfObj.currentButton setTitle:LM_LOCALIZE(value) forState:UIControlStateNormal];
                    [selfObj.currentButton setTitle:LM_LOCALIZE(value) forState:UIControlStateHighlighted];
                }
                [selfObj.pickerViewController hide];
            };
        }
        [self.pickerViewController addPickerData:dataArray];
        if([self.currentButton isEqual:self.hourOfSend])
        {
            self.pickerViewController.isLocalizable = NO;
        }
        [self.pickerViewController showInView:self.view];
        int defaultVal = 0;
        BOOL check = NO;
        for(NSString *str in dataArray)
        {
            if([self.currentButton isEqual:self.hourOfSend])
            {
                if([str isEqualToString:self.currentButton.titleLabel.text])
                {
                    check = YES;
                    break;
                }
            }
            else
            {
                if([LM_LOCALIZE(str) isEqualToString:self.currentButton.titleLabel.text])
                {
                    check = YES;
                    break;
                }
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
                [selfObj.datePickerController hide];
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self endAction];
}

@end
