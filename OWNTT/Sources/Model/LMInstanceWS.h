//
//  LMInstanceWS.h
//  OWNTT
//
//  Created by Kaszuba Maciej on 27/08/14.
//
//

#import "JSONModel.h"
#import "LMAdvertiserWS.h"

@interface LMInstanceWS : JSONModel
@property (strong, nonatomic) NSNumber *objectId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *reportPermissions;
@property (strong, nonatomic) NSArray <LMAdvertiserWS>*advertisers;
@end
