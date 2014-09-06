//
//  LMDateConfigurationViewController.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 09/08/14.
//
//

#import "LMDateConfigurationViewController.h"
#import "LMDatePickerViewController.h"
#import "LMDataPickerViewController.h"
#import "LMFullButton.h"
#import "LMUser.h"
#import "LMRotateViewController.h"
#import "LMSettings.h"
#import "LMWebViewController.h"

#define CUSTOM_REPORT_FIELD_NAME @"reportTimeInterval_Custom"

typedef enum {
    FullButtonType_Interval = 1,
    FullButtonType_DateFrom,
    FullButtonType_DateTo
} FullButtonType;

@interface LMDateConfigurationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *dateToLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateFromLabel;
@property (weak, nonatomic) IBOutlet UILabel *intervalLabel;
@property (weak, nonatomic) IBOutlet UIImageView *shadowImage;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet LMFullButton *currentInterval;
@property (weak, nonatomic) IBOutlet UIView *dateView;
@property (weak, nonatomic) IBOutlet LMFullButton *dateToButton;
@property (weak, nonatomic) IBOutlet LMFullButton *dateFromButton;

@property (weak, nonatomic) UIButton *currentButton;

@property (strong,nonatomic) NSDateFormatter *dateFormatter;

@property (unsafe_unretained, nonatomic) BOOL dateShow;

@end

@implementation LMDateConfigurationViewController
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
    self.dateFromButton.exclusiveTouch = YES;
    self.dateToButton.exclusiveTouch = YES;
    self.currentInterval.exclusiveTouch = YES;
    self.shadowImage.image = [[UIImage imageNamed:@"top_shadow.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    [self.dateFromButton setTitle:[self.dateFormatter stringFromDate:[NSDate date]] forState:UIControlStateNormal];
    [self.dateFromButton setTitle:[self.dateFormatter stringFromDate:[NSDate date]] forState:UIControlStateHighlighted];
    [self.dateToButton setTitle:[self.dateFormatter stringFromDate:[NSDate date]] forState:UIControlStateNormal];
    [self.dateToButton setTitle:[self.dateFormatter stringFromDate:[NSDate date]] forState:UIControlStateHighlighted];
    
    if(self.fromBranchReport)
    {
        self.toolbar.hidden = YES;
        UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        [backButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:NAVIGATION_ITEM_TEXT_COLOR_NORMAL,
                                                 NSFontAttributeName: NAVIGATION_ITEM_FONT
                                                 } forState:UIControlStateNormal];
        [backButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:NAVIGATION_ITEM_TEXT_COLOR_HIGHLIGHTEN,
                                                 NSFontAttributeName: NAVIGATION_ITEM_FONT
                                                 } forState:UIControlStateHighlighted];
        [self.parentViewController.navigationItem setBackBarButtonItem:backButtonItem];
        UIImageView *titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 88, 42)];
        titleImage.image = [UIImage imageNamed:@"tabbar_logo.png"];
        [self.parentViewController.navigationItem setTitleView:titleImage];

    }
    else
    {
        self.toolbar.hidden = NO;
    }
    
    LMUser *currentUser = OWNTT_APP_DELEGATE.appUtils.currentUser;
    if(currentUser.settings.reportDefaultIsEnumValue)
    {
        self.dateShow = NO;
        [self.currentInterval setTitle:[LMUtils reportTimeIntervalTypeToString:[currentUser.settings.reportDefaultEnum intValue]] forState:UIControlStateNormal];
        [self.currentInterval setTitle:[LMUtils reportTimeIntervalTypeToString:[currentUser.settings.reportDefaultEnum intValue]] forState:UIControlStateHighlighted];
    }
    else
    {
        self.dateShow = YES;
        self.dateView.alpha = 1;
        [self.currentInterval setTitle:[LMUtils reportTimeIntervalTypeToString:ReportTimeInterval_Custom] forState:UIControlStateNormal];
        [self.currentInterval setTitle:[LMUtils reportTimeIntervalTypeToString:ReportTimeInterval_Custom] forState:UIControlStateHighlighted];
        if(currentUser.settings.reportDefaultDateFrom)
        {
            [self.dateFromButton setTitle:[self.dateFormatter stringFromDate:currentUser.settings.reportDefaultDateFrom] forState:UIControlStateNormal];
            [self.dateFromButton setTitle:[self.dateFormatter stringFromDate:currentUser.settings.reportDefaultDateFrom] forState:UIControlStateHighlighted];
        }
        if(currentUser.settings.reportDefaultDateTo)
        {
            [self.dateToButton setTitle:[self.dateFormatter stringFromDate:currentUser.settings.reportDefaultDateTo] forState:UIControlStateNormal];
            [self.dateToButton setTitle:[self.dateFormatter stringFromDate:currentUser.settings.reportDefaultDateTo] forState:UIControlStateHighlighted];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.intervalLabel.text = LM_LOCALIZE(@"LMSumReport_Period");
    self.dateFromLabel.text = LM_LOCALIZE(@"LMSumAlert_DateFormLabel");
    self.dateToLabel.text = LM_LOCALIZE(@"LMSumAlert_DateToLabel");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return NO;
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

- (IBAction)doneAction:(id)sender
{
    if([self isValid])
    {
        //NSError *error;
        LMUser *user = [[LMUser fetchLMUsersInContext:[[LMCoreDataManager sharedInstance] masterManagedObjectContext]] objectAtIndex:0];
        /*(LMUser *)[self.managedObjectContext existingObjectWithID:OWNTT_APP_DELEGATE.appUtils.currentUser.objectID error:&error];
        if(!user)
        {
            NSLog(@"ERRRO: Unknown user id");
        }*/
        if(self.dateShow)
        {
            user.settings.reportDefaultIsEnumValue = NO;
            user.settings.reportDefaultDateFrom = [self.dateFormatter dateFromString:self.dateFromButton.titleLabel.text];
            user.settings.reportDefaultDateTo = [self.dateFormatter dateFromString:self.dateToButton.titleLabel.text];
        }
        else
        {
            user.settings.reportDefaultIsEnumValue = YES;
            user.settings.reportDefaultEnum = [NSNumber numberWithInt:[LMUtils reportTimeIntervalStringToType:self.currentInterval.titleLabel.text]];
        }
        [[LMCoreDataManager sharedInstance] saveMasterContext];
        if(self.fromBranchReport)
        {
            [self.parentViewController.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [self.parentViewController dismissViewControllerAnimated:YES completion:^{
            
            }];
        }
    }
}

- (IBAction)cancelAction:(id)sender
{
    if(self.fromBranchReport)
    {
        [self.parentViewController.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self.parentViewController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

- (BOOL)isValid
{
    NSString *message;
    if(self.dateShow)
    {
        if(self.dateToButton.enabled)
        {
            NSDate *dateFrom = [self.dateFormatter dateFromString:self.dateFromButton.titleLabel.text];
            NSDate *dateTo = [self.dateFormatter dateFromString:self.dateToButton.titleLabel.text];
            if([dateFrom compare:dateTo] == NSOrderedDescending)
            {
                message = LM_LOCALIZE(@"LMDateValidation");
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

- (IBAction)buttonTapped:(id)sender
{
    BOOL isPickerData = YES;
    self.currentButton = (UIButton *)sender;
    NSArray *dataArray;
    //int defaultStartValue = -1;
    switch (self.currentButton.tag) {
        case FullButtonType_Interval:
        {
            NSMutableArray *data = [NSMutableArray arrayWithArray:[LMReferenceData staticReportTimeIntervalValues]];
            dataArray = [NSArray arrayWithArray:data];
            isPickerData = YES;
            break;
        }
        case FullButtonType_DateFrom:
            isPickerData = NO;
            break;
        case FullButtonType_DateTo:
            isPickerData = NO;
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
            __weak LMDateConfigurationViewController *selfObj = self;
            self.pickerViewController.pickerViewCancelAction = ^()
            {
                [selfObj.pickerViewController hide];
            };
            self.pickerViewController.pickerViewDoneAction = ^(NSString *value)
            {
                [selfObj.currentButton setTitle:LM_LOCALIZE(value) forState:UIControlStateNormal];
                [selfObj.currentButton setTitle:LM_LOCALIZE(value) forState:UIControlStateHighlighted];
                [selfObj.pickerViewController hide];
                if([value isEqualToString:CUSTOM_REPORT_FIELD_NAME])
                {
                    selfObj.dateShow = YES;
                    NSDate *today = [NSDate date];
                    NSCalendar *calendar = [NSCalendar currentCalendar];
                    NSDateComponents *comp = [calendar components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:today];
                    [comp setMonth:comp.month-1];
                    NSDate *startDate = [calendar dateFromComponents:comp];
                    [selfObj.dateFromButton setTitle:[selfObj.dateFormatter stringFromDate:startDate] forState:UIControlStateNormal];
                    [selfObj.dateFromButton setTitle:[selfObj.dateFormatter stringFromDate:startDate] forState:UIControlStateHighlighted];
                    [selfObj.dateToButton setTitle:[selfObj.dateFormatter stringFromDate:today] forState:UIControlStateNormal];
                    [selfObj.dateToButton setTitle:[selfObj.dateFormatter stringFromDate:today] forState:UIControlStateHighlighted];
                    [UIView animateWithDuration:0.2 animations:^{
                        selfObj.dateView.alpha = 1;
                    }];
                }
                else
                {
                    selfObj.dateShow = NO;
                    [UIView animateWithDuration:0.2 animations:^{
                        selfObj.dateView.alpha = 0;
                    }];
                }
            };
        }
        [self.pickerViewController addPickerData:dataArray];
        [self.pickerViewController showInView:self.view];
        [self.pickerViewController selectPickerObject:[LMUtils reportTimeIntervalStringToType:self.currentInterval.titleLabel.text]];
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
            __weak LMDateConfigurationViewController *selfObj = self;
            self.datePickerController.pickerViewCancelAction = ^()
            {
                [selfObj.datePickerController hide];
            };
            self.datePickerController.pickerViewDoneAction = ^(NSDate *value)
            {
                NSString *date = [selfObj.dateFormatter stringFromDate:value];
                [selfObj.currentButton setTitle:date forState:UIControlStateNormal];
                [selfObj.currentButton setTitle:date forState:UIControlStateHighlighted];
                [selfObj.datePickerController hide];
            };
        }
        [self.datePickerController showInView:self.view];
        if(self.currentButton.titleLabel.text)
        {
            [self.datePickerController setPickerDate:[self.dateFormatter dateFromString:self.currentButton.titleLabel.text]];
        }
        else
        {
            [self.datePickerController setPickerDate:nil];
        }
    }
}

- (void)createLeftButton:(BOOL)left withSelector:(SEL)selector text:(NSString *)text
{
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:text style:UIBarButtonItemStylePlain target:nil action:nil];
    [buttonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:NAVIGATION_ITEM_TEXT_COLOR_NORMAL,
                                         NSFontAttributeName: NAVIGATION_ITEM_FONT
                                         } forState:UIControlStateNormal];
    [buttonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:NAVIGATION_ITEM_TEXT_COLOR_HIGHLIGHTEN,
                                         NSFontAttributeName: NAVIGATION_ITEM_FONT
                                         } forState:UIControlStateHighlighted];
    if(selector != NULL)
    {
        [buttonItem setAction:selector];
        [buttonItem setTarget:self];
    }
    if(left)
    {
        [self.parentViewController.navigationItem setBackBarButtonItem:buttonItem];
    }
    else
    {
        [self.parentViewController.navigationItem setRightBarButtonItem:buttonItem];
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
