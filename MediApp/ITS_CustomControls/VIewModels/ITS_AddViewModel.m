//
//  ITS_AddViewModel.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 11/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_AddViewModel.h"
@interface ITS_AddViewModel()
@property (nonatomic) ITS_Repository *repository;
@end;

@implementation ITS_AddViewModel
- (instancetype)init {
    self = [super init];
    if (self) {
        self.repository = [[ITS_Repository alloc] init];
    }
    return self;
}

#pragma mark - Repository Calls
- (void)fetchSpecialties:(void (^)(NSArray * _Nullable))completion {
    [self.repository fetchSpecialties:^(NSArray * _Nullable arr) {
        NSMutableArray *specialtiesArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in arr) {
            Specialty *specialty = [[Specialty alloc] init];
            [specialty initWithDict:dict];
            [specialtiesArray addObject:specialty];
        }
        completion(specialtiesArray);
    }];
}

#pragma mark - Object Construction

- (void)buildObjectWithType:(MainMenuSelection)mainMenuSelection andWithArray:(NSArray *)buildingArray {
    switch (mainMenuSelection) {
        case MainMenuSelectionMedics:
            [self buildMedicObject:buildingArray];
            break;
        case MainMenuSelectionPatients:
            //build patient
            break;
        case MainMenuSelectionAppointments:
            //build appointments
            break;
        case MainMenuSelectionMedicalAppointment:
            //build medical appointment
            break;
        default:
            break;
    }
}

- (void)buildMedicObject:(NSArray *)buildingArray {
    Medic* medic = [[Medic alloc] init];
    [medic setFirstNames:[buildingArray objectAtIndex:0]];
    [medic setLastNames:[buildingArray objectAtIndex:1]];
    [medic setAge:[[buildingArray objectAtIndex:2] intValue]];
    [medic setGender:[buildingArray objectAtIndex:3]];
    [medic setAddress:[buildingArray objectAtIndex:4]];
    [medic setPostalCode:[buildingArray objectAtIndex:5]];
    [medic setNatural:[buildingArray objectAtIndex:6]];
    [medic setNationality:[buildingArray objectAtIndex:7]];
    [medic setNIF:[buildingArray objectAtIndex:8]];
    [medic setCcNumber:[buildingArray objectAtIndex:9]];
    [medic setSpecialtiesArray:[buildingArray objectAtIndex:10]];
    [medic setEmail:[buildingArray objectAtIndex:11]];
    [medic setPhoneNumber:[buildingArray objectAtIndex:12]];
    [medic setAttachmentArray:[buildingArray objectAtIndex:13]];
    
    [self.repository registerSeparateUserWithEmail:medic.email completion:^(NSString * _Nonnull uid) {
        
    }];
}
@end
