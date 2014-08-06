//
//  LMDataPickerView.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 05/08/14.
//
//

#import "LMDataPickerView.h"

@interface LMDataPickerView ()
@property (weak, nonatomic) IBOutlet UIToolbar *toolbarView;

@property (strong, nonatomic) NSString *currentValue;

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

@end
