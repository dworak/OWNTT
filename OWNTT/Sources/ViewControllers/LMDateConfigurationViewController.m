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
#import "LMWebViewController.h"

#define CUSTOM_REPORT_FIELD_NAME @"Niestandardowy"

typedef enum {
    FullButtonType_Interval = 1,
    FullButtonType_DateFrom,
    FullButtonType_DateTo
} FullButtonType;

@interface LMDateConfigurationViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *shadowImage;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet LMFullButton *currentInterval;
@property (weak, nonatomic) IBOutlet UIView *dateView;
@property (weak, nonatomic) IBOutlet LMFullButton *dateToButton;
@property (weak, nonatomic) IBOutlet LMFullButton *dateFromButton;

@property (weak, nonatomic) UIButton *currentButton;

@property (strong,nonatomic) NSDateFormatter *dateFormatter;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;

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
    self.checkButton.exclusiveTouch = YES;
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
    self.shadowImage.image = [[UIImage imageNamed:@"top_shadow.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    self.dateShow = NO;
    //[self createLeftButton:YES withSelector:NULL text:@" "];
    //[self createLeftButton:NO withSelector:@selector(doneAction) text:@"zakończ"];
    
    /*UIImageView *titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 118, 36)];
    titleImage.image = [UIImage imageNamed:@"logo.png"];
    [self.parentViewController.navigationItem setTitleView:titleImage];*/
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    [self.dateFromButton setTitle:[self.dateFormatter stringFromDate:[NSDate date]] forState:UIControlStateNormal];
    [self.dateFromButton setTitle:[self.dateFormatter stringFromDate:[NSDate date]] forState:UIControlStateHighlighted];
    [self.dateToButton setTitle:[self.dateFormatter stringFromDate:[NSDate date]] forState:UIControlStateNormal];
    [self.dateToButton setTitle:[self.dateFormatter stringFromDate:[NSDate date]] forState:UIControlStateHighlighted];
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

- (IBAction)checkboxTapped:(id)sender
{
    self.checkButton.selected = !self.checkButton.selected;
    if(self.checkButton.selected)
    {
        self.dateToButton.enabled = YES;
    }
    else
    {
        self.dateToButton.enabled = NO;
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
            if([dateFrom compare:dateTo] == NSOrderedSame || [dateFrom compare:dateTo] == NSOrderedDescending)
            {
                message = @"Data do musi być większa niż data od";
            }
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

- (IBAction)buttonTapped:(id)sender
{
    BOOL isPickerData = YES;
    self.currentButton = (UIButton *)sender;
    NSArray *dataArray;
    int defaultStartValue = -1;
    switch (self.currentButton.tag) {
        case FullButtonType_Interval:
        {
            NSMutableArray *data = [NSMutableArray arrayWithArray:[LMReferenceData staticReportTimeIntervalValues]];
            [data addObject:CUSTOM_REPORT_FIELD_NAME];
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
                [selfObj.currentButton setTitle:value forState:UIControlStateNormal];
                [selfObj.currentButton setTitle:value forState:UIControlStateHighlighted];
                [selfObj.pickerViewController hide];
                if([value isEqualToString:CUSTOM_REPORT_FIELD_NAME])
                {
                    selfObj.dateShow = YES;
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
        NSString *pickerDate = [self.dateFormatter stringFromDate:[NSDate date]];
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
