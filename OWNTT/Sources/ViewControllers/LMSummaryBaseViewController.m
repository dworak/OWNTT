//
//  LMSummaryBaseViewController.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 06/08/14.
//
//

#import "LMSummaryBaseViewController.h"
#import "LMDataPickerViewController.h"
#import "LMDatePickerViewController.h"
#import "LMSummaryReportViewController.h"
#import "LMAlertSummaryViewController.h"
#import <LM/LMViewControllerBase.h>
#import "LMUserAlert.h"
#import "LMBranchNameView.h"

@interface LMSummaryBaseViewController ()

@end

@implementation LMSummaryBaseViewController

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
    self.nameView = [[[NSBundle mainBundle] loadNibNamed:[NSString stringWithFormat:@"%@_iPhone", NSStringFromClass([LMBranchNameView class])] owner:self options:nil] objectAtIndex:0];
    [self.topImage addSubview:self.nameView];
    
    self.shadowImage.image = [[UIImage imageNamed:@"top_shadow.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    
    UIImageView *titleImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 88, 42)];
    titleImage.image = [UIImage imageNamed:@"tabbar_logo.png"];
    [self.parentViewController.navigationItem setTitleView:titleImage];
    
    [self.parentViewController.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction:)]];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // Firstly for purpouse of storing all of the fields we remove all of the items from view
    NSArray *subviews = self.view.subviews;
    
    for (UIView *v in subviews)
    {
        if ((v!=self.contentScrollView) && (![v conformsToProtocol:@protocol(UILayoutSupport)]) && v!=self.shadowImage)
        {
            if (v.tag!=BACKGROUND_IMAGE_VIEW_TAG && v.tag!=BACKGROUND_STATUS_BAR_TAG)
            {
                [v removeFromSuperview];
            }
        }
    }
    
    // Now  we add them directly to our scrolled one
    [subviews enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        
        if((obj!=self.contentScrollView) && (![obj conformsToProtocol:@protocol(UILayoutSupport)]) && obj!=self.shadowImage)
        {
            if (obj.tag!=BACKGROUND_IMAGE_VIEW_TAG && obj.tag!=BACKGROUND_STATUS_BAR_TAG)
            {
                [self addContentSubview:obj];
            }
        }
    }];
    [self.view bringSubviewToFront:self.shadowImage];
}

- (void)viewDidLayoutSubviews
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectionNotificationChange) name:LM_CONNECTION_NOTIFICATION_CHANGE object:nil];
    [self connectionNotificationChange];
    [self setLocalizationStrings];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareChildForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
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

- (NSManagedObjectContext *)managedObjectContext
{
    if(!_managedObjectContext)
    {
        _managedObjectContext = [[LMCoreDataManager sharedInstance] masterManagedObjectContext];
    }
    return _managedObjectContext;
}

- (IBAction)doneAction:(id)sender
{
    if(self.currentEditingTextField)
    {
        [self.currentEditingTextField resignFirstResponder];
    }
    if(self.pickerViewController)
    {
        [self.pickerViewController hide];
    }
    if(self.datePickerController)
    {
        [self.datePickerController hide];
    }
    //SaveData
    if([self isValid])
    {
        [self saveObjectData];
        [self endAction];
    }
}

- (void)saveSummaryData
{
    
}

- (void)endAction
{
    [self.parentViewController.navigationController popToRootViewControllerAnimated:YES];
}

- (void)saveObjectData
{
}

- (void)setLocalizationStrings
{
    
}

- (void)connectionNotificationChange
{
    
}

- (BOOL)isValid
{
    return YES;
}

- (void)pickerShow
{
    self.contentScrollView.contentSize = CGSizeMake(self.view.frame.size.width, [self.pickerViewController pickerHeight]);
}

- (void)pickerHide
{
    self.contentScrollView.contentSize = self.view.frame.size;
}

- (void)pickerWillShow
{
    
}

- (void)pickerWillHide
{
   
}

@end
