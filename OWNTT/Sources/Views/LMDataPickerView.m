//
//  LMDataPickerView.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 05/08/14.
//
//

#import "LMDataPickerView.h"

@interface LMDataPickerView ()
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbarView;

@property (strong, nonatomic) NSString *currentValue;

@property (strong, nonatomic) NSArray *pickerData;

@end

@implementation LMDataPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)doneButton:(id)sender
{
    self.pickerViewDoneAction(self.currentValue);
}

- (IBAction)cancelAction:(id)sender
{
    self.pickerViewCancelAction();
}

- (void)addPickerData:(NSArray *)pickerData
{
    self.pickerData = pickerData;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.pickerData objectAtIndex:row];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	self.currentValue = [self.pickerData objectAtIndex:row];
}

@end
