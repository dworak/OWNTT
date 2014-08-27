//
//  LMProgramWS.h
//  OWNTT
//
//  Created by Kaszuba Maciej on 27/08/14.
//
//

#import "JSONModel.h"

@protocol LMProgramWS
@end

@interface LMProgramWS : JSONModel
@property (strong, nonatomic) NSNumber *objectId;
@property (strong, nonatomic) NSString *name;
@end
