//
//  LMHeaderView.h
//  OWNTT
//
//  Created by Maciej Kaszuba on 04/08/14.
//
//

#import <UIKit/UIKit.h>
typedef void (^ShowReport)();
@interface LMHeaderView : UITableViewHeaderFooterView
@property (copy, nonatomic) ShowReport showReport;
- (void)setHeaderButtonTitle:(NSString *)title;
@end
