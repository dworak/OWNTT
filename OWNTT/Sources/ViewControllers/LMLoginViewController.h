//
//  MLLoginViewController.h
//  OWNTT
//
//  Created by Kaszuba Maciej on 24/07/14.
//
//

#import <UIKit/UIKit.h>

@interface LMLoginViewController : LMViewControllerBase <TTChildViewControllerProtocol, UITextFieldDelegate>
@property (unsafe_unretained, nonatomic) BOOL isPresentModal;
@property (unsafe_unretained, nonatomic) BOOL showToolbar;
@end
