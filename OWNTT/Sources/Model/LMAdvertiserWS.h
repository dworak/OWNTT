//
//  LMAdvertiserWS.h
//  OWNTT
//
//  Created by Kaszuba Maciej on 27/08/14.
//
//

#import "JSONModel.h"
#import "LMProgramWS.h"

@protocol LMAdvertiserWS
@end

@interface LMAdvertiserWS : JSONModel
@property (strong, nonatomic) NSNumber *objectId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray <LMProgramWS>*programs;
@end
