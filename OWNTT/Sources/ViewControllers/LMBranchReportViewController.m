//
//  LMBranchReportViewController.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 04/08/14.
//
//

#import "LMBranchReportViewController.h"
#import "LMDateConfigurationViewController.h"
#import "LMAlertSummaryViewController.h"
#import "LMNavigationViewController.h"
#import "LMReport.h"
#import "LMInstance.h"
#import "LMBranchTableViewCell.h"
#import "LMBranchReportTableViewCell.h"
#import "LMBranchNameView.h"
#import "LMAdvertiser.h"
#import "LMProgram.h"
#import "LMSettings.h"

@interface LMBranchReportViewController ()
@property (strong, nonatomic) LMBranchNameView *nameView;
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
    self.title = @"Raport";
    self.tableView.separatorColor = [UIColor clearColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.bounces = NO;
    
    self.nameView = [[[NSBundle mainBundle] loadNibNamed:[NSString stringWithFormat:@"%@_iPhone", NSStringFromClass([LMBranchNameView class])] owner:self options:nil] objectAtIndex:0];
    if([self.parentViewController.navigationController isKindOfClass:[LMNavigationViewController class]])
    {
        LMNavigationViewController *navController = (LMNavigationViewController *)self.parentViewController.navigationController;
        if(navController.controllerType.intValue == NavigationControllerType_Report)
        {
            self.nameView.calendarButton.hidden = NO;
        }
        else
        {
            self.nameView.calendarButton.hidden = YES;
        }
    }
    [self.nameView.calendarButton addTarget:self action:@selector(calendarButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.nameView];
    
    LMInstance *instance = [LMInstance fetchActiveEntityOfClass:[LMInstance class] withObjectID:self.objectId.instanceId inContext:self.managedObjectContext];
    if(instance)
    {
        for(LMAdvertiser *advertiser in instance.advertisers.allObjects)
        {
            if(advertiser.objectId.intValue == self.objectId.advertiserId.intValue)
            {
                self.nameView.firstName.text = advertiser.name;
                for(LMProgram *program in advertiser.programs.allObjects)
                {
                    NSNumber *selectedProgram = [self.objectId.programIds objectAtIndex:0];
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
            TTHostViewController *hostController = segue.destinationViewController;
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
        if([hostController.childViewController isKindOfClass:[LMWebViewController class]])
        {
            ((LMWebViewController *)hostController.childViewController).transactionData = self.objectId;
            ((LMWebViewController *)hostController.childViewController).isPop = NO;
            ((LMWebViewController *)hostController.childViewController).isInstance = NO;
        }
        if([hostController.childViewController isKindOfClass:[LMDateConfigurationViewController class]])
        {
            ((LMDateConfigurationViewController *)hostController.childViewController).fromBranchReport = YES;
        }
    }
}

- (void)setLocalizationStrings
{
    if(((LMNavigationViewController *)self.navigationController).controllerType.intValue == NavigationControllerType_Report)
    {
        if(OWNTT_APP_DELEGATE.appUtils.currentUser.settings.reportDefaultIsEnumValue)
        {
            self.nameView.ThirdName.text = [LMUtils reportTimeIntervalTypeToString:OWNTT_APP_DELEGATE.appUtils.currentUser.settings.reportDefaultEnum.intValue];
        }
        else
        {
            NSDateFormatter *dateFormatter = [NSDateFormatter new];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            self.nameView.ThirdName.text = [NSString stringWithFormat:@"%@ - %@", [dateFormatter stringFromDate:OWNTT_APP_DELEGATE.appUtils.currentUser.settings.reportDefaultDateFrom], [dateFormatter stringFromDate:OWNTT_APP_DELEGATE.appUtils.currentUser.settings.reportDefaultDateTo]];
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

- (IBAction)calendarButtonTapped:(id)sender
{
    [self.parentViewController performSegueWithIdentifier:[LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_PushDate] sender:self];
}

- (void)getTableData
{
    LMInstance *instance = [LMInstance fetchActiveEntityOfClass:[LMInstance class] withObjectID:self.objectId.instanceId inContext:self.managedObjectContext];
    LMReport *reportToRemove;
    NSMutableArray *dataArray = [NSMutableArray arrayWithArray:instance.reports.allObjects];
    for(LMReport * report in dataArray)
    {
        if(report.objectIdValue == 4)
        {
            reportToRemove = report;
        }
    }
    if(reportToRemove)
    {
        [dataArray removeObject:reportToRemove];
    }
    self.tableData = [NSArray arrayWithArray:dataArray];
    
    NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    self.tableData = [self.tableData sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDesc]];
}

- (NSString *)cellIdentifier
{
    return @"BranchReportCell";
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
            return [LMSegueKeys segueIdentifierForSegueKey:LMSegueKeyType_ModalWebPop];
        }
        
    }
    return nil;
}

- (UITableViewCell *)createNewCell
{
    LMBranchReportTableViewCell *cell = (LMBranchReportTableViewCell *)[[[NSBundle mainBundle] loadNibNamed:[NSString stringWithFormat:@"%@_iPhone", NSStringFromClass([LMBranchReportTableViewCell class])] owner:self options:nil] objectAtIndex:0];
    [cell.cellButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    //UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 25)];
    //view.backgroundColor = [UIColor greenColor];
    //cell.accessoryView = view;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    //[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    LMBranchReportTableViewCell *cellRep = ((LMBranchReportTableViewCell *) cell);
    [cellRep.cellButton setTitleColor:UI_FULL_BUTTON_NORMAL_TEXT_COLOR forState:UIControlStateNormal];
    [cellRep.cellButton setTitleColor:UI_FULL_BUTTON_SELECTED_TEXT_COLOR forState:UIControlStateSelected];
    [cellRep.cellButton.titleLabel setFont:UI_FULL_BUTTON_FONT];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (IBAction)buttonTapped:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
}

@end
