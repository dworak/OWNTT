//
//  LMDataPickerView.h
//  OWNTT
//
//  Created by Maciej Kaszuba on 05/08/14.
//
//

#import <UIKit/UIKit.h>

typedef void (^PickerViewDoneAction)(NSString *value);
typedef void (^PickerViewCancelAction)();

@interface LMDataPickerView : UIPickerView <UIPickerViewDelegate>
@property (copy, nonatomic) PickerViewDoneAction pickerViewDoneAction;
@property (copy, nonatomic) PickerViewCancelAction pickerViewCancelAction;

-(void)addPickerData:(NSArray *)pickerData;
@end
