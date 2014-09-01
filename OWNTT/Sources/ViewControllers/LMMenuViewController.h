//
//  LMMenuViewController.h
//  OWNTT
//
//  Created by Maciej Kaszuba on 05/08/14.
//
//

#import "LMHostChildBaseViewController.h"

@class LMData;

@class LMMenuNameView;

@interface LMMenuViewController : LMHostChildBaseViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIImageView *subMenuImage;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) LMData *object;
@property (strong, nonatomic) NSMutableArray *userObjects;
@property (strong, nonatomic) NSManagedObjectContext *localContext;

- (IBAction)addButtonTapped:(id)sender;

@end
