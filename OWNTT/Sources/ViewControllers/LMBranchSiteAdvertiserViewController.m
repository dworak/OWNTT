//
//  LMBranchSiteAdveriserViewController.m
//  OwnTT Mobile
//
//  Created by Maciej Kaszuba on 17/01/15.
//
//

#import "LMBranchSiteAdvertiserViewController.h"
#import "LMSiteAdvertiserWS.h"
#import "LMAlertSummaryViewController.h"
#import "LMSiteWS.h"
#import "LMSiteAdvertiserWS.h"

@interface LMBranchSiteAdvertiserViewController ()

@end

@implementation LMBranchSiteAdvertiserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self performSelector:@selector(selectRow) withObject:nil afterDelay:0.1];
}

- (void)selectRow
{
    if(self.objectId.siteAdvertiserId)
    {
        int position = 0;
        BOOL selected = NO;
        for(LMProgramWS *advertiser in self.tableData)
        {
            if(self.objectId.siteAdvertiserId.intValue == advertiser.objectId.intValue)
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

- (void)getTableData
{
    for(LMSiteWS *site in OWNTT_APP_DELEGATE.appUtils.currentSites)
    {
        if(site.objectId.intValue == self.objectId.siteId.intValue)
        {
            self.tableData = [NSArray arrayWithArray:site.advertisements];
            break;
        }
    }
}

- (IBAction)cancelAction:(id)sender
{
    self.objectId.siteAdvertiserId = nil;
    [self popAndSaveData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LMSiteAdvertiserWS *advertiser = [self.tableData objectAtIndex:indexPath.row];
    self.objectId.siteAdvertiserId = advertiser.objectId;
    [self popAndSaveData];
}

- (void)popAndSaveData
{
    if(self.parentViewController.navigationController.viewControllers.count > 3)
    {
        UIViewController *controller = [self.parentViewController.navigationController.viewControllers objectAtIndex:self.parentViewController.navigationController.viewControllers.count-3];
        if([controller isKindOfClass:[TTHostViewController class]])
        {
            if([((TTHostViewController *)controller).childViewController isKindOfClass:[LMAlertSummaryViewController class]])
                {
                    LMAlertSummaryViewController *summary = (LMAlertSummaryViewController *)((TTHostViewController *)controller).childViewController;
                    summary.transactionData = self.objectId;
                    [self.parentViewController.navigationController popToViewController:controller animated:YES];
                }
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
