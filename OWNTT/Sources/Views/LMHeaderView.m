//
//  LMHeaderView.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 04/08/14.
//
//

#import "LMHeaderView.h"

@interface LMHeaderView ()
@property (weak, nonatomic) IBOutlet UIButton *headerButton;

@end

@implementation LMHeaderView

- (void)awakeFromNib
{
    self.contentView.backgroundColor = HEADER_VIEW_BACKGROUND_COLOR;
    CGRect sepFrame = CGRectMake(0, self.frame.size.height-1, 320, 1);
    UIView *seperatorView = [[UIView alloc] initWithFrame:sepFrame];
    seperatorView.backgroundColor = [UIColor colorWithWhite:224.0/255.0 alpha:1.0];
    seperatorView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:seperatorView];
}

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
- (IBAction)headerButtonOn:(UIButton *)sender
{
    self.showReport();
}

@end
