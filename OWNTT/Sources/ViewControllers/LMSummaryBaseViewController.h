//
//  LMSummaryBaseViewController.h
//  OWNTT
//
//  Created by Maciej Kaszuba on 06/08/14.
//
//

#import <UIKit/UIKit.h>

@class LMDataPickerViewController;

@interface LMSummaryBaseViewController : LMViewControllerBase <TTChildViewControllerProtocol>
@property (strong, nonatomic) LMDataPickerViewController *pickerViewController;
@property (unsafe_unretained, nonatomic) BOOL pickerViewShow;

@property (weak, nonatomic) IBOutlet UIImageView *subMenuImage;
@property (weak, nonatomic) IBOutlet UILabel *instanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *advertiserLabel;
@property (weak, nonatomic) IBOutlet UILabel *programLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) NSArray *pickerData;
- (void)pickerShow;
- (void)pickerHide;

- (void)pickerWillShow;
- (void)pickerWillHide;

- (void)saveObjectData;
- (BOOL)isValid;
@end
