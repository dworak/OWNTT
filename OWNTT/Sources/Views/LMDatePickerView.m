//
//  LMDatePickerView.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 06/08/14.
//
//

#import "LMDatePickerView.h"

@interface LMDatePickerView ()
@property (weak, nonatomic) IBOutlet UIToolbar *toolbarView;

@property (strong, nonatomic) NSString *currentValue;

@end

@implementation LMDatePickerView

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

@end
