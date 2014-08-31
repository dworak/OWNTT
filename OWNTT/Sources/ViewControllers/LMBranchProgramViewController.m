//
//  LMBranchProgramViewController.m
//  OWNTT
//
//  Created by Kaszuba Maciej on 24/07/14.
//
//

#import "LMBranchProgramViewController.h"
#import "LMNavigationViewController.h"
#import "LMSummaryBaseViewController.h"
#import "LMInstance.h"
#import "LMReadOnlyObject.h"
#import "LMProgram.h"
#import "LMAdvertiser.h"
#import "LMBranchNameView.h"

@interface LMBranchProgramViewController ()

@end

@implementation LMBranchProgramViewController

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
    [self.parentViewController.navigationItem setTitle:@"Program"];
    LMBranchNameView *nameView = [[[NSBundle mainBundle] loadNibNamed:[NSString stringWithFormat:@"%@_iPhone", NSStringFromClass([LMBranchNameView class])] owner:self options:nil] objectAtIndex:0];
    [self.topView addSubview:nameView];
    LMInstance *instance = [LMInstance fetchActiveEntityOfClass:[LMInstance class] withObjectID:self.objectId.instanceId inContext:self.managedObjectContext];
    for(LMAdvertiser *advertiser in instance.advertisers.allObjects)
    {
        if(advertiser.objectId.intValue == self.objectId.advertiserId.intValue)
        {
            nameView.firstName.text = advertiser.name;
            break;
        }
    }
    nameView.SecondName.text = nil;
    nameView.ThirdName.text = nil;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)prepareChildForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:[LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_ModalWebPop]])
    {
        if([segue.destinationViewController isKindOfClass:[TTHostViewController class]])
        {
            TTHostViewController *hostController = (TTHostViewController *)segue.destinationViewController;
            if([hostController.childViewController isKindOfClass:[LMWebViewController class]])
            {
                ((LMWebViewController *)hostController.childViewController).isPop = YES;
                ((LMWebViewController *)hostController.childViewController).isInstance = NO;
                ((LMWebViewController *)hostController.childViewController).transactionData = self.objectId;
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
        else
        {
            [super prepareChildForSegue:segue sender:sender];
        }
    }
}

- (void)getTableData
{
    LMInstance *instance = [LMInstance fetchActiveEntityOfClass:[LMInstance class] withObjectID:self.objectId.instanceId inContext:self.managedObjectContext];
    if(instance) {
        NSMutableArray *programsArray = [NSMutableArray new];
        for(LMAdvertiser *advertiser in instance.advertisers.allObjects)
        {
            if(advertiser.objectId.intValue == self.objectId.advertiserId.intValue)
            {
                [programsArray addObjectsFromArray:advertiser.programs.allObjects];
            }
        }
        NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        self.tableData = [programsArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDesc]];
        [self.tableView reloadData];
    }
}

- (NSString *)nextSegueKey
{
    if([self.parentViewController.navigationController isKindOfClass:[LMNavigationViewController class]])
    {
        LMNavigationViewController *navController = (LMNavigationViewController *)self.parentViewController.navigationController;
        if(navController.controllerType.intValue == NavigationControllerType_Alert)
        {
            return [LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_PushAlertSummary];
        }
        else
        {
            return [LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_PushReport];
        }
        
    }
    return nil;
}

- (NSString *)headerbuttonTitle
{
    return [LMOWNTTHTTPClient reportTypeName:LMOWNTTReportType_Type1];
}

- (void)getAllProgramIds
{
    NSMutableArray *programIds = [NSMutableArray new];
    for(LMProgram *pr in self.tableData)
    {
        [programIds addObject:pr.objectId];
    }
    self.objectId.programIds = [NSArray arrayWithArray:programIds];
    self.objectId.reportId = [NSNumber numberWithInt:LMOWNTTReportType_Type8];
}

@end
