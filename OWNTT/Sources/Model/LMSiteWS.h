//
//  LMSiteWS.h
//  OwnTT Mobile
//
//  Created by Maciej Kaszuba on 11/01/15.
//
//

#import "LMProgramWS.h"
#import "LMSiteAdvertiserWS.h"

@interface LMSiteWS : LMProgramWS
@property (strong, nonatomic) NSArray <LMSiteAdvertiserWS>*advertisements;
@end
