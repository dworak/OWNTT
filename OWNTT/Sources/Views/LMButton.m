//
//  LMButton.m
//  OWNTT
//
//  Created by Kaszuba Maciej on 24/07/14.
//
//

#import "LMButton.h"

@interface LMButton ()
- (void)setupButton;
@end

@implementation LMButton

- (void)awakeFromNib
{
    [self setupButton];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupButton];
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

#pragma mark -
#pragma mark === Private methods ===
- (void)setupButton
{
    self.exclusiveTouch = YES;
    self.backgroundColor = UI_BUTTON_BACKGROUND_COLOR;
    
    self.layer.borderWidth = UI_BUTTON_BORDER_WIDTH;
    self.layer.borderColor = UI_BUTTON_BORDER_COLOR;
    self.layer.cornerRadius = UI_BUTTON_CORNER_RADIOUS;
    [self setTitleColor:UI_BUTTON_NORMAL_TEXT_COLOR forState:UIControlStateNormal];
    [self setTitleColor:UI_BUTTON_SELECTED_TEXT_COLOR forState:UIControlStateSelected];
    
    [self setTintColor:[UIColor grayColor]];
    [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    self.tintColor = [UIColor whiteColor];
    
    [self.titleLabel setFont:UI_BUTTON_FONT];
}

@end
