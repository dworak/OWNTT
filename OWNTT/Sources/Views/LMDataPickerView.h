//
//  LMDataPickerView.h
//  OWNTT
//
//  Created by Maciej Kaszuba on 05/08/14.
//
//

#import <UIKit/UIKit.h>

@interface LMDataPickerView : UIView
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneItem;

@end
