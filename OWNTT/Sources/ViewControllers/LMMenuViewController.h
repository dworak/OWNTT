//
//  LMMenuViewController.h
//  OWNTT
//
//  Created by Maciej Kaszuba on 05/08/14.
//
//

#import "LMHostChildBaseViewController.h"

@interface LMMenuViewController : LMHostChildBaseViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIImageView *subMenuImage;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)addButtonTapped:(id)sender;

@end
