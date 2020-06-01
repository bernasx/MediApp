//
//  ITS_ListViewModel.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 28/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_ListViewModel.h"
@interface ITS_ListViewModel()
@property (nonatomic) ITS_Repository *repository;
@end
@implementation ITS_ListViewModel
- (instancetype)init {
    self = [super init];
    if (self) {
        self.repository = [[ITS_Repository alloc] init];
    }
    return self;
}

- (void)getPatients:(void (^)(NSArray * _Nullable))completion {
    NSMutableArray* patientArray = [[NSMutableArray alloc] init];
    
    [self.repository getAllPatients:^(NSDictionary * _Nullable patientDicts) {
        if (![patientDicts isKindOfClass:[NSNull class]]) {
            for (NSString* key in patientDicts) {
                Patient* patient = [[Patient alloc] init];
                [patientArray addObject:patient];
                [patient initWithDict:patientDicts[key]andUid:key];
                [self fetchDiagnosticsFromPatientUID:patient.uid completion:^(NSArray * _Nullable diagnosticArray) {
                    patient.diagnosticArray = diagnosticArray;
                    for (Diagnostic* diagnostic in patient.diagnosticArray) {
                        for (NSNumber* diseaseId in diagnostic.currentDiseasesIds) {
                            [self.repository fetchDiseaseWithID:[NSString stringWithFormat:@"%@",diseaseId] completion:^(NSDictionary * _Nullable diseaseDict) {
                                Disease *disease = [[Disease alloc] init];
                                [disease initWithDict:diseaseDict];
                                [diagnostic.currentDiseases addObject:disease];
                                completion(patientArray);
                            }];
                        }
                    }
                }];
            }
        }
        
    }];
}

- (void)fetchDiagnosticsFromPatientUID:(NSString *)uid completion:(void (^)(NSArray * _Nullable))completion {
    
    [self.repository getDiagnosticsFromPatientUID:uid completion:^(NSDictionary * _Nullable diagnosticDicts) {
        NSMutableArray* diagnosticArray = [[NSMutableArray alloc] init];
        for (NSString* key in diagnosticDicts) {
            Diagnostic *diagnostic = [[Diagnostic alloc] init];
            [diagnostic initWithDict:diagnosticDicts[key] andUid:key];
            [diagnosticArray addObject: diagnostic];
        }
        completion(diagnosticArray);
    }];

}

- (void)fetchDiseases:(void (^)(NSArray * _Nullable))completion {
    [self.repository fetchDiseases:^(NSArray * _Nullable arr) {
        NSMutableArray *diseasesArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in arr) {
            Disease *disease = [[Disease alloc] init];
            [disease initWithDict:dict];
            [diseasesArray addObject:disease];
        }
        completion(diseasesArray);
    }];
}

@end
