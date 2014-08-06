//
//  LMReportData.h
//  OWNTT
//
//  Created by Maciej Kaszuba on 05/08/14.
//
//

#import <Foundation/Foundation.h>

@interface LMData : NSObject
@property (unsafe_unretained, nonatomic) BOOL isReport;
@property (strong, nonatomic) NSNumber *instanceId;
@property (strong, nonatomic) NSNumber *advertiserId;
@property (strong, nonatomic) NSNumber *programId;
@property (strong, nonatomic) NSNumber *reportId;
@end
