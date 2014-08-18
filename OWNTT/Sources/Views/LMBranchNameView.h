//
//  LMBranchNameView.h
//  OWNTT
//
//  Created by Maciej Kaszuba on 18/08/14.
//
//

#import "LMBorderDescriptionView.h"
#import "LMFontLabel.h"

@interface LMBranchNameView : LMBorderDescriptionView
@property (weak, nonatomic) IBOutlet DroidSansRegularLabel *firstName;
@property (weak, nonatomic) IBOutlet DroidSansRegularLabel *SecondName;
@property (weak, nonatomic) IBOutlet DroidSansRegularLabel *ThirdName;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@end
