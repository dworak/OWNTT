//
//  LMBranchTableViewCell.m
//  OWNTT
//
//  Created by Maciej Kaszuba on 02/08/14.
//
//

#import "LMBranchTableViewCell.h"

@implementation LMBranchTableViewCell

- (void)awakeFromNib
{
    self.textLabel.font = DEFAULT_APP_FONT;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.textLabel.font = DEFAULT_APP_FONT;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
