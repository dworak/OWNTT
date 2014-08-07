//
//  LMBranchReportViewController.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 04/08/14.
//
//

#import "LMBranchReportViewController.h"
#import "LMAlertSummaryViewController.h"
#import "LMNavigationViewController.h"
#import "LMReport.h"
#import "LMInstance.h"

@interface LMBranchReportViewController ()

@end

@implementation LMBranchReportViewController

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
    self.parentViewController.title = @"Raport";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareChildForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"LMSegueKeyType_PushWebPop"])
    {
        if([segue.destinationViewController isKindOfClass:[TTHostViewController class]])
        {
            TTHostViewController *hostController = (TTHostViewController *)segue.destinationViewController;
            if([hostController.childViewController isKindOfClass:[LMWebViewController class]])
            {
                ((LMWebViewController *)hostController.childViewController).isPop = YES;
            }
        }
    }
    else if([segue.destinationViewController isKindOfClass:[TTHostViewController class]])
    {
        TTHostViewController *hostController = segue.destinationViewController;
        if([hostController.childViewController isKindOfClass:[LMSummaryBaseViewController class]])
        {
            ((LMSummaryBaseViewController *)hostController.childViewController).transactionData = self.objectId;
        }
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

- (void)getTableData
{
    self.managedObjectContext = [[LMCoreDataManager sharedInstance] newManagedObjectContext];
    LMInstance *instance = [LMInstance fetchActiveEntityOfClass:[LMInstance class] withObjectID:self.objectId.instanceId inContext:self.managedObjectContext];
    self.tableData = instance.reports.allObjects;
    NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    self.tableData = [self.tableData sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDesc]];
}

- (NSString *)nextSegueKey
{
    if([self.parentViewController.navigationController isKindOfClass:[LMNavigationViewController class]])
    {
        LMNavigationViewController *navController = (LMNavigationViewController *)self.parentViewController.navigationController;
        if(navController.controllerType.intValue == NavigationControllerType_ReportTemplate)
        {
            return [LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_PushReportSummary];
        }
        else
        {
            return [LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_PushWeb];
        }
        
    }
    return nil;
}

@end
