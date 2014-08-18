//
//  LMBorderDescriptionView.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 18/08/14.
//
//

#import "LMBorderDescriptionView.h"

@implementation LMBorderDescriptionView

- (void)awakeFromNib
{
    [self setupView];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupView];
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

- (void)setupView
{
    self.layer.cornerRadius = 15;
    self.layer.borderColor = [UIColor colorWithRed:174./255. green:174./255. blue:174./255. alpha:0.5].CGColor;
    self.layer.borderWidth = 1;
}

@end
