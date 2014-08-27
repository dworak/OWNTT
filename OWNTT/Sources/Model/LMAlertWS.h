//
//  LMAlertWS.h
//  OWNTT
//
//  Created by Kaszuba Maciej on 27/08/14.
//
//

#import "JSONModel.h"

@interface LMAlertWS : JSONModel
@property (strong, nonatomic) NSNumber *localId;
@property (strong, nonatomic) NSNumber *programId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *paramType;
@property (strong, nonatomic) NSNumber *monitorType;
@property (strong, nonatomic) NSString *value;
@property (strong, nonatomic) NSString *dateFrom;
@property (strong, nonatomic) NSString *dateTo;
@property (strong, nonatomic) NSNumber *borderType;
@property (strong, nonatomic) NSNumber *hour;
@end
