//
//  LMDatePickerView.h
//  OWNTT
//
//  Created by Maciej Kaszuba on 06/08/14.
//
//

#import <UIKit/UIKit.h>

@interface LMDatePickerView : UIView
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneItem;

@end
