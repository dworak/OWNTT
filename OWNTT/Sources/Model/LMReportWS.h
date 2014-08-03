//
//  LMReportWS.h
//  OWNTT
//
//  Created by Maciej Kaszuba on 03/08/14.
//
//

#import <UIKit/UIKit.h>
#import <JSONModel.h>

@interface LMReportWS : JSONModel
@property (strong, nonatomic) NSNumber *InstancjaId;
@property (strong, nonatomic) NSString *InstancjaNazwa;
@property (strong, nonatomic) NSNumber *ReklamodawcaId;
@property (strong, nonatomic) NSString *ReklamodawcaNazwa;
@property (strong, nonatomic) NSNumber *ProgramId;
@property (strong, nonatomic) NSString *ProgramNazwa;
@property (strong, nonatomic) NSNumber *Raport1;
@property (strong, nonatomic) NSNumber *Raport5;
@property (strong, nonatomic) NSNumber *Raport8;
@end
