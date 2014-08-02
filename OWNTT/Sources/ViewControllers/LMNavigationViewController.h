//
//  MLNavigationViewController.h
//  OWNTT
//
//  Created by Kaszuba Maciej on 24/07/14.
//
//

#import <UIKit/UIKit.h>

typedef enum {
    NavigationControllerType_Report = 0,
    NavigationControllerType_ReportTemplate,
    NavigationControllerType_Alert
} NavigationControllerType;

@interface LMNavigationViewController : UINavigationController
@property (strong, nonatomic) NSNumber *controllerType;
@end
