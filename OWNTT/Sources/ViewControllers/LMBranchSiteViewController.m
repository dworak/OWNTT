//
//  LMBranchSiteViewController.m
//  OwnTT Mobile
//
//  Created by Maciej Kaszuba on 11/01/15.
//
//

#import "LMAlertSummaryViewController.h"
#import "LMBranchSiteViewController.h"
#import "LMBranchSiteAdvertiserViewController.h"
#import "LMBranchSiteViewController.h"
#import "LMProgramWS.h"
#import "LMBranchTableViewCell.h"

@interface LMBranchSiteViewController ()

@end

@implementation LMBranchSiteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.parentViewController.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(cancelAction:)]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[self performSelector:@selector(selectRow) withObject:nil afterDelay:0.1];
}

- (void)selectRow
{
    if(self.objectId.siteId)
    {
        int position = 0;
        BOOL selected = NO;
        for(LMProgramWS *site in self.tableData)
        {
            if(self.objectId.siteId.intValue == site.objectId.intValue)
            {
                selected = YES;
                break;
            }
            position++;
        }
        if(selected)
        {
            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:position inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSString*)nextSegueKey
{
    return [LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_PushSiteAdvertiserList];
}

#pragma mark -
#pragma mark === Private methods ===
- (void)getTableData
{
    self.tableData = OWNTT_APP_DELEGATE.appUtils.currentSites;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdentifier]];
    if(!cell) {
        cell = [self createNewCell];
    }
    LMProgramWS *object = [self.tableData objectAtIndex:indexPath.row];
    cell.textLabel.font = DEFAULT_APP_FONT;
    cell.textLabel.text = object.name;
    if(indexPath.row == self.tableData.count-1)
    {
        ((LMBranchTableViewCell *)cell).separatorImage.hidden = YES;
    }
    else
    {
        ((LMBranchTableViewCell *)cell).separatorImage.hidden = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.objectId.siteAdvertiserId = nil;
    self.objectId.pageAddName = nil;
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (IBAction)cancelAction:(id)sender
{
    [self popAndSaveData];
}

- (void)popAndSaveData
{
    if(self.parentViewController.navigationController.viewControllers.count > 2)
    {
        UIViewController *controller = [self.parentViewController.navigationController.viewControllers objectAtIndex:self.parentViewController.navigationController.viewControllers.count-2];
        if([controller isKindOfClass:[TTHostViewController class]])
        {
            if([((TTHostViewController *)controller).childViewController isKindOfClass:[LMAlertSummaryViewController class]])
            {
                LMAlertSummaryViewController *summary = (LMAlertSummaryViewController *)((TTHostViewController *)controller).childViewController;
                summary.transactionData.siteId = nil;
                summary.transactionData.siteAdvertiserId = nil;
                summary.transactionData.pageAddName = nil;
                summary.transactionData.pageName = nil;
                [self.parentViewController.navigationController popToViewController:controller animated:YES];
            }
        }
    }
}

@end
