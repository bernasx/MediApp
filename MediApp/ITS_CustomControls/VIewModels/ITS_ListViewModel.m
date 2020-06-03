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
#pragma mark - Patients
- (void)getPatients:(void (^)(NSArray * _Nullable))completion {
    NSMutableArray* patientArray = [[NSMutableArray alloc] init];
    
    [self.repository getAllPatients:^(NSDictionary * _Nullable patientDicts) {
        if (![patientDicts isKindOfClass:[NSNull class]]) {
            for (NSString* key in patientDicts) {
                Patient* patient = [[Patient alloc] init];
                [patientArray addObject:patient];
                [patient initWithDict:patientDicts[key]andUid:key];
                
                
                //notes
                for (NSString*keyNote in patientDicts[key][@"notes"]) {
                    [self.repository getNoteFromUID:patientDicts[key][@"notes"][keyNote] completion:^(NSDictionary * _Nullable noteDict) {
                        Note* note = [[Note alloc] init];
                        note.uid = patientDicts[key][@"notes"][keyNote];
                        note.noteText = noteDict[@"text"];
                        note.noteTitle = noteDict[@"title"];
                        [patient.notesArray addObject:note];
                    }];
                    
                }
                
                //attachments for the medic
                NSMutableArray* attachmentUrlArray = [[NSMutableArray alloc] init];
                [attachmentUrlArray addObject:[NSMutableArray new]];
                [attachmentUrlArray addObject:[NSMutableArray new]];
                int currentSection = 0;
                for (NSString* documentType in patientDicts[key][@"attachments"]) {
                    for (NSString* documentKey in patientDicts[key][@"attachments"][documentType]) {
                        [[attachmentUrlArray objectAtIndex:currentSection] addObject:patientDicts[key][@"attachments"][documentType][documentKey]];
                    }
                    currentSection +=1;
                }
                patient.attachmentURLArray = attachmentUrlArray;
                
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
            
            //notes
            for (NSString*keyNote in diagnosticDicts[key][@"notes"]) {
                [self.repository getNoteFromUID:diagnosticDicts[key][@"notes"][keyNote] completion:^(NSDictionary * _Nullable noteDict) {
                    Note* note = [[Note alloc] init];
                    note.uid = diagnosticDicts[key][@"notes"][keyNote];
                    note.noteText = noteDict[@"text"];
                    note.noteTitle = noteDict[@"title"];
                    [diagnostic.notesArray addObject:note];
                }];
                
            }
            
            //attachments for the diagnostic
            NSMutableArray* attachmentUrlArray = [[NSMutableArray alloc] init];
            [attachmentUrlArray addObject:[NSMutableArray new]];
            [attachmentUrlArray addObject:[NSMutableArray new]];
            int currentSection = 0;
            for (NSString* documentType in diagnosticDicts[key][@"attachments"]) {
                for (NSString* documentKey in diagnosticDicts[key][@"attachments"][documentType]) {
                    [[attachmentUrlArray objectAtIndex:currentSection] addObject:diagnosticDicts[key][@"attachments"][documentType][documentKey]];
                }
                currentSection +=1;
            }
            diagnostic.attachmentURLArray = attachmentUrlArray;
            
            
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

#pragma mark - Medics

- (void)getMedics:(void (^)(NSArray * _Nullable))completion {
    NSMutableArray* medicArray = [[NSMutableArray alloc] init];
    NSString*currentUserUID = [FIRAuth auth].currentUser.uid;
    
    [self.repository getMedicsFromUID:currentUserUID completion:^(NSDictionary * _Nullable medicUIDs) {
        for (NSString* key in medicUIDs) {
            NSDictionary *medicUIDDict = medicUIDs[key];
              [self.repository getMedicForUID:medicUIDDict[@"uid"] completion:^(NSDictionary * _Nullable dict) {
                  Medic* medic = [[Medic alloc] init];
                  [medicArray addObject:medic];
                  [medic initWithDict:dict andUid:medicUIDDict[@"uid"]];
                  
                  //attachments for the medic
                  NSMutableArray* attachmentUrlArray = [[NSMutableArray alloc] init];
                  [attachmentUrlArray addObject:[NSMutableArray new]];
                  [attachmentUrlArray addObject:[NSMutableArray new]];
                  int currentSection = 0;
                  for (NSString* documentType in dict[@"attachments"]) {
                      for (NSString* documentKey in dict[@"attachments"][documentType]) {
                          [[attachmentUrlArray objectAtIndex:currentSection] addObject:dict[@"attachments"][documentType][documentKey]];
                      }
                      currentSection +=1;
                  }
                  medic.attachmentURLArray = attachmentUrlArray;
                  
                  
            
                  for (NSNumber* specialtyID in medic.specialtyIds) {
                      [self.repository fetchSpecialtyWithID:[NSString stringWithFormat:@"%@",specialtyID] completion:^(NSDictionary * _Nullable dict) {
                          Specialty *specialty = [[Specialty alloc] init];
                          [specialty initWithDict:dict];
                          [medic.specialtiesArray addObject:specialty];
                          completion(medicArray);
                      }];
                  }
              }];
        }
    }];
}

@end
