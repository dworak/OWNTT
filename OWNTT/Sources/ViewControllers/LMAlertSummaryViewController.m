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
#import "LMBranchSiteViewController.h"
#import "LMButton.h"
#import "LMTextField.h"
#import "LMReferenceData.h"
#import "LMInstance.h"
#import "LMReport.h"
#import "LMAdvertiser.h"
#import "LMProgram.h"
#import "LMSettings.h"
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
@property (weak, nonatomic) IBOutlet UIView *notAvailableView;

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
    self.hourOfSend.hidden = NO;
    self.notAvailableView.hidden = YES;
    self.dateFormater = [[NSDateFormatter alloc] init];
    [self.dateFormater setDateFormat:@"yyyy-MM-dd"];
    self.scrollView.contentSize = CGSizeMake(320, self.view.frame.size.height-64);
    if(!self.readOnly)
    {
        self.nameView.pageButton.hidden = NO;
        self.nameView.pageButton.exclusiveTouch = YES;
        [self.nameView.pageButton addTarget:self action:@selector(pageButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.borderType setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.borderType setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 1)];
    self.valueTextField.text = @"";
    
    if(self.readOnly)
    {
        for(UIView *view in self.contentScrollView.subviews)
        {
            if([view isKindOfClass:[UIButton class]] || [view isKindOfClass:[UITextField class]])
            {
                view.userInteractionEnabled = NO;
            }
        }
    }
    if(self.readOnly)
    {
        self.parentViewController.navigationItem.rightBarButtonItem = nil;
    }
    
    [self.alertNameTextField addValidation:LMTextFieldValidaitonType_Name];
    [self.valueTextField addValidation:LMTextFieldValidaitonType_Value];

}

- (void)prepareChildForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:[LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_PushSiteList]])
    {
        if([segue.destinationViewController isKindOfClass:[TTHostViewController class]])
        {
            TTHostViewController *hostController = (TTHostViewController *)segue.destinationViewController;
            if([hostController.childViewController isKindOfClass:[LMBranchSiteViewController class]])
            {
                self.transactionData.pageAddName = nil;
                self.transactionData.pageName = nil;
                self.transactionData.siteAdvertiserId = nil;
                self.transactionData.siteId = nil;
                ((LMBranchSiteViewController *)hostController.childViewController).objectId = [self.transactionData copy];
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
    for(UILabel *notAvailableLabel in self.notAvailableView.subviews)
    {
        notAvailableLabel.text = LM_LOCALIZE(@"LMSumAlert_NotAvailableLabel");
    }
    LMUser *user = OWNTT_APP_DELEGATE.appUtils.currentUser;
    if(self.readOnly)
    {
        LMAdvertiser *advertiser = [LMAdvertiser fetchEntityOfClass:[LMAdvertiser class] withObjectID:self.userAlert.advertiserId inContext:self.managedObjectContext];
        LMProgram *program = [LMProgram fetchEntityOfClass:[LMProgram class] withObjectID:self.userAlert.programId inContext:self.managedObjectContext];
        self.nameView.firstName.text = advertiser.name;
        self.nameView.SecondName.text = program.name;
        NSMutableString *thirdText = [NSMutableString new];
        if(self.userAlert.pageName && ![self.userAlert.pageName isEqualToString:@""])
        {
            [thirdText appendString:self.userAlert.pageName];
        }
        if(self.userAlert.pageAddName && ![self.userAlert.pageAddName isEqualToString:@""])
        {
            if(thirdText.length > 0)
            {
                [thirdText appendFormat:@", %@", self.userAlert.pageAddName];
            }
            else
            {
                [thirdText appendString:self.userAlert.pageAddName];
            }
        }
        if(self.userAlert.monitorTypeValue == AlertMonitoringTypes_Continuous)
        {
            self.hourOfSend.hidden = YES;
            self.notAvailableView.hidden = NO;
            self.valueTextField.hidden = YES;
            self.borderType.hidden = YES;
        }
        self.nameView.ThirdName.text = thirdText;
        [self.alertNameTextField setText:self.userAlert.name];
        [self.monitoringType setTitle:[LMUtils alertMonitoringTypeToString:self.userAlert.monitorType.intValue] forState:UIControlStateNormal];
        [self.monitoringType setTitle:[LMUtils alertMonitoringTypeToString:self.userAlert.monitorType.intValue] forState:UIControlStateHighlighted];
        [self.borderType setTitle:[LMUtils alertBorderTypeToString:self.userAlert.borderType.intValue] forState:UIControlStateNormal];
        [self.borderType setTitle:[LMUtils alertBorderTypeToString:self.userAlert.borderType.intValue] forState:UIControlStateHighlighted];
        [self.rateType setTitle:[LMUtils alertPointerTypeToString:self.userAlert.paramType.intValue] forState:UIControlStateNormal];
        [self.rateType setTitle:[LMUtils alertPointerTypeToString:self.userAlert.paramType.intValue] forState:UIControlStateHighlighted];
        [self.hourOfSend setTitle:[NSString stringWithFormat:@"%d",self.userAlert.hourValue] forState:UIControlStateNormal];
        [self.hourOfSend setTitle:[NSString stringWithFormat:@"%d",self.userAlert.hourValue] forState:UIControlStateHighlighted];
        [self.valueTextField setText:self.userAlert.value];
        [self.dateFrom setTitle:[self.dateFormater stringFromDate:self.userAlert.dateFrom] forState:UIControlStateNormal];
        [self.dateFrom setTitle:[self.dateFormater stringFromDate:self.userAlert.dateFrom] forState:UIControlStateHighlighted];
        if(self.userAlert.dateTo)
        {
            [self checkboxTapped:self.checkButton];
            [self.dateTo setTitle:[self.dateFormater stringFromDate:self.userAlert.dateTo] forState:UIControlStateNormal];
            [self.dateTo setTitle:[self.dateFormater stringFromDate:self.userAlert.dateTo] forState:UIControlStateHighlighted];
        }
    }
    else
    {
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
        NSMutableString *thirdText = [NSMutableString new];
        if(self.transactionData.pageName && ![self.transactionData.pageName isEqualToString:@""])
        {
            [thirdText appendString:self.transactionData.pageName];
        }
        if(self.transactionData.pageAddName && ![self.transactionData.pageAddName isEqualToString:@""])
        {
            if(thirdText.length > 0)
            {
                [thirdText appendFormat:@", %@", self.transactionData.pageAddName];
            }
            else
            {
                [thirdText appendString:self.transactionData.pageAddName];
            }
        }
        self.nameView.ThirdName.text = thirdText;
        [self.dateFrom setTitle:[self.dateFormater stringFromDate:[NSDate date]] forState:UIControlStateNormal];
        [self.dateFrom setTitle:[self.dateFormater stringFromDate:[NSDate date]] forState:UIControlStateHighlighted];
        [self.dateTo setTitle:[self.dateFormater stringFromDate:[NSDate date]] forState:UIControlStateNormal];
        [self.dateTo setTitle:[self.dateFormater stringFromDate:[NSDate date]] forState:UIControlStateHighlighted];
        [self.monitoringType setTitle:[LMUtils alertMonitoringTypeToString:user.settings.alertDefaultMonitorTypeValue] forState:UIControlStateNormal];
        [self.monitoringType setTitle:[LMUtils alertMonitoringTypeToString:user.settings.alertDefaultMonitorTypeValue] forState:UIControlStateHighlighted];
        [self.borderType setTitle:[LMUtils alertBorderTypeToString:user.settings.alertDefaultBorderTypeValue] forState:UIControlStateNormal];
        [self.borderType setTitle:[LMUtils alertBorderTypeToString:user.settings.alertDefaultBorderTypeValue] forState:UIControlStateHighlighted];
        [self.rateType setTitle:[LMUtils alertPointerTypeToString:user.settings.alertDefaultPointerValue] forState:UIControlStateNormal];
        [self.rateType setTitle:[LMUtils alertPointerTypeToString:user.settings.alertDefaultPointerValue] forState:UIControlStateHighlighted];
        [self.hourOfSend setTitle:[NSString stringWithFormat:@"%d",user.settings.alertDefaultHourValue] forState:UIControlStateNormal];
        [self.hourOfSend setTitle:[NSString stringWithFormat:@"%d",user.settings.alertDefaultHourValue] forState:UIControlStateHighlighted];
    }
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
        if([dateFrom compare:[NSDate date]] == NSOrderedDescending)
        {
            message = LM_LOCALIZE(@"LMDateFromFutureValidation");
        }
        if(self.checkButton.selected && !message)
        {
            NSDate *dateTo = [dateFormatter dateFromString:self.dateTo.titleLabel.text];            
            if(!message && ([dateFrom compare:dateTo] == NSOrderedSame || [dateFrom compare:dateTo] == NSOrderedDescending))
            {
                message = LM_LOCALIZE(@"LMDateValidation");
            }
        }
        if(!message)
        {
            if([LMUtils alertMonitoringStringToType:self.monitoringType.titleLabel.text] != AlertMonitoringTypes_Continuous) {
                message = [self.valueTextField validateField];
            }
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
    if(self.readOnly)
    {
        return;
    }
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
    if(userAlert.monitorTypeValue == AlertMonitoringTypes_Continuous)
    {
        userAlert.hour = [NSNumber numberWithInt:-1];
        userAlert.value = @"0";
        userAlert.borderTypeValue = AlertBorderTypes_GreaterThan;
    }
    else
    {
        userAlert.hour = [decimalFormater numberFromString:self.hourOfSend.titleLabel.text];
        userAlert.value = self.valueTextField.text;
        userAlert.borderTypeValue = [LMUtils alertBorderStringToType:self.borderType.titleLabel.text];
    }
    userAlert.programId = [self.transactionData.programIds objectAtIndex:0];
    userAlert.advertiserId = self.transactionData.advertiserId;
    userAlert.dateFrom = [self.dateFormater dateFromString:self.dateFrom.titleLabel.text];
    if(self.checkButton.selected)
    {
        userAlert.dateTo = [self.dateFormater dateFromString:self.dateTo.titleLabel.text];
    }
    
    userAlert.objectIdValue = user.alertsCountValue+1;
    user.alertsCount = [NSNumber numberWithInt:userAlert.objectId.intValue];
    userAlert.createDate = [NSDate date];
    userAlert.siteId = self.transactionData.siteId;
    userAlert.siteAdvetiserId = self.transactionData.siteAdvertiserId;
    userAlert.pageAddName = self.transactionData.pageAddName;
    userAlert.pageName = self.transactionData.pageName;
    
    //Send alert
    __weak LMAlertSummaryViewController *selfObj = self;
    [[LMOWNTTHTTPClient sharedClient] POSTHTTPRequestOperationForServiceName:LMOWNTTHTTPClientServiceName_RegisterAlertPush parameters:[LMOWNTTHTTPClient registerAlertPushParams:userAlert] succedBlock:^(AFHTTPRequestOperation *operation, id responseObject) {
        //[selfObj endAction];
        [user.userAlertsSet addObject:userAlert];
        [LMUtils saveCoreDataContext:selfObj.managedObjectContext];
        [selfObj endAction];
        } failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        [selfObj.managedObjectContext rollback];
        NSString *message;
        if(operation.response.statusCode == 403)
        {
            message = LM_LOCALIZE(@"LMAlertManager_AlertAccessError");
        }
        else if(operation.response.statusCode == 500)
        {
            message = LM_LOCALIZE(@"LMAlertManager_AlertServerError");
        }
        else if (operation.response.statusCode == 400)
        {
            message = LM_LOCALIZE(@"LMAlertManager_AlertSummaryBadRequest");
        }
        else
        {
            message = LM_LOCALIZE(@"LMAlertManager_AlertAuthorizationError");
        }
        [self.managedObjectContext rollback];
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
            defaultStartValue = 1;
            dataArray = [LMReferenceData staticAlertHourTypes];
            break;
        case LMAlertSummaryButtonType_Monitoring:
            defaultStartValue = 1;
            dataArray = [LMReferenceData staticAlertMonitoringTypes];
            break;
        case LMAlertSummaryButtonType_Pointer:
            defaultStartValue = 1;
            dataArray = [LMReferenceData staticAlertPointerTypes];
            break;
        case LMAlertSummaryButtonType_Border:
            defaultStartValue = 2;
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
                if([selfObj.currentButton isEqual:selfObj.monitoringType])
                {
                    if([LMUtils alertMonitoringStringToType:LM_LOCALIZE(value)] == AlertMonitoringTypes_Continuous)
                    {
                        selfObj.hourOfSend.hidden = YES;
                        selfObj.notAvailableView.hidden = NO;
                        selfObj.borderType.hidden = YES;
                        selfObj.valueTextField.hidden = YES;
                    }
                    else
                    {
                        selfObj.hourOfSend.hidden = NO;
                        selfObj.notAvailableView.hidden = YES;
                        selfObj.borderType.hidden = NO;
                        selfObj.valueTextField.hidden = NO;
                    }
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
            [self.pickerViewController selectPickerObject:defaultVal+1];
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

- (IBAction)pageButtonTapped:(id)sender
{
    if(self.currentEditingTextField)
    {
        [self.currentEditingTextField resignFirstResponder];
    }
    [self.pickerViewController hide];
    if([LMAppUtils connected])
    {
        //Get sites and advertisers
        [[LMOWNTTHTTPClient sharedClient] POSTHTTPRequestOperationForServiceName:LMOWNTTHTTPClientServiceName_GetSites parameters:[LMOWNTTHTTPClient getSitesListParams:(OWNTT_APP_DELEGATE).appUtils.currentUser.httpToken programId:[self.transactionData.programIds objectAtIndex:0]] succedBlock:^(AFHTTPRequestOperation *operation, id responseObject)
        {
            //save file
            NSError *error = [(OWNTT_APP_DELEGATE).appUtils createCurrentSitesForDictionary:responseObject];
            if(!error)
            {
                if(OWNTT_APP_DELEGATE.appUtils.currentSites.count > 0)
                {
                    [self.parentViewController performSegueWithIdentifier:[LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_PushSiteList] sender:self];
                }
                else
                {
                    [LMAlertManager showInfoAlertWithOkWithText:@"Brak stron" delegate:nil];
                }
            }
            else
            {
                [LMAlertManager showErrorAlertWithOkWithText:LM_LOCALIZE(@"LMAlertManager_AlertSummarySite") delegate:self];
            }
        }
        failureBlock:^(AFHTTPRequestOperation *operation, NSError *error)
        {
            NSString *message;
            NSLog(@"%ld", (long)operation.response.statusCode);
            if(operation.response.statusCode == 500)
            {
                message = LM_LOCALIZE(@"LMAlertManager_AlertSummarySiteConnectionError");
            }
            else if (operation.response.statusCode == 400)
            {
                message = LM_LOCALIZE(@"LMAlertManager_AlertSummarySitesBadRequest");
            }
            else
            {
                message = LM_LOCALIZE(@"LMAlertManager_AlertSummarySitesAuthorizationError");
            }
            [LMAlertManager showErrorAlertWithOkWithText:message delegate:nil];
        }];
    }
    else
    {
        [LMAlertManager showErrorAlertWithOkWithText:LM_LOCALIZE(@"LMLogin_WarningLabel") delegate:self];
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
