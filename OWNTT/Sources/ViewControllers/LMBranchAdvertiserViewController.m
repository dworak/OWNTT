//
//  LMBranchAdvertiserViewController.m
//  OWNTT
//
//  Created by Kaszuba Maciej on 24/07/14.
//
//

#import "LMReadOnlyObject.h"
#import "LMAdvertiser.h"
#import "LMInstance.h"
#import "LMBranchAdvertiserViewController.h"
#import "LMBranchProgramViewController.h"
#import "LMNameHeaderView.h"
#import "LMProgram.h"

@interface LMBranchAdvertiserViewController ()
@end

@implementation LMBranchAdvertiserViewController

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
    [self.parentViewController.navigationItem setTitle:@"Reklamodawca"];
    LMNameHeaderView *nameView = [[[NSBundle mainBundle] loadNibNamed:[NSString stringWithFormat:@"%@_iPhone", NSStringFromClass([LMNameHeaderView class])] owner:self options:nil] objectAtIndex:0];
    [self.topView addSubview:nameView];
    if(self.headerView)
    {
        [self hideBackButtonItem:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
        TTHostViewController *hostController = (TTHostViewController *)segue.destinationViewController;
        if([hostController.childViewController isKindOfClass:[LMBranchProgramViewController class]])
        {
            [((LMBranchProgramViewController *)hostController.childViewController) currentBranchObjectId:self.objectId];
        }
    }
}

- (void)getTableData
{
    LMInstance *instance = [LMInstance fetchActiveEntityOfClass:[LMInstance class] withObjectID:self.objectId.instanceId inContext:self.managedObjectContext];
    if(instance) {
        self.tableData = [NSArray arrayWithArray:instance.advertisers.allObjects];
        NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        self.tableData = [self.tableData sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDesc]];
        [self.tableView reloadData];
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

- (NSString *)nextSegueKey
{
    return [LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_PushProgramList];
}

- (void)getAllProgramIds
{
    NSMutableArray *programIds = [NSMutableArray new];
    LMInstance *instance = [LMInstance fetchActiveEntityOfClass:[LMInstance class] withObjectID:self.objectId.instanceId inContext:self.managedObjectContext];
    if(instance)
    {
        for(LMAdvertiser *advertiser in instance.advertisers.allObjects)
        {
            for(LMProgram *program in advertiser.programs.allObjects)
            {
                [programIds addObject:program.objectId];
            }
        }
    }
    self.objectId.programIds = [NSArray arrayWithArray:programIds];
    self.objectId.reportId = [NSNumber numberWithInt:LMOWNTTReportType_Type1];
}

@end
