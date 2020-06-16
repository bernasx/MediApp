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
                
                
                //attachments for the patient
                NSMutableArray* attachmentUrlArray = [[NSMutableArray alloc] init];
                [attachmentUrlArray addObject:[NSMutableArray new]];
                [attachmentUrlArray addObject:[NSMutableArray new]];
                
                for (NSString* documentKey in patientDicts[key][@"attachments"][@"Documents"]) {
                    [[attachmentUrlArray objectAtIndex:0] addObject:patientDicts[key][@"attachments"][@"Documents"][documentKey]];
                }
                
                for (NSString* documentKey in patientDicts[key][@"attachments"][@"Extras"]) {
                    [[attachmentUrlArray objectAtIndex:1] addObject:patientDicts[key][@"attachments"][@"Extras"][documentKey]];
                }
                patient.attachmentURLArray = attachmentUrlArray;
                
                //go get the names for each attachment (but not the actual file)
                for (int i = 0; i < [patient.attachmentURLArray count]; i++) {
                    [patient.attachmentArray addObject:[NSMutableArray new]];
                    [self getAttachmentsWithOutFileDataWithArray:[patient.attachmentURLArray objectAtIndex:i] completion:^(NSMutableArray * attachmentArray) {
                        [patient.attachmentArray replaceObjectAtIndex:i withObject:attachmentArray];
                    }];
                }
                
                [self.repository fetchHistoryOfDiseasesWithUID:patient.uid andIsFamilyHistory:NO completion:^(NSArray * _Nullable idArray) {
                    patient.previousDiseasesIdArray = idArray;
                    
                    for (NSNumber* diseaseID in idArray) {
                        [self.repository fetchDiseaseWithID:[NSString stringWithFormat:@"%@",diseaseID] completion:^(NSDictionary * _Nullable dict) {
                            Disease *disease = [[Disease alloc] init];
                            [disease initWithDict:dict];
                            [patient.previousDiseasesArray addObject:disease];
                        }];
                    }
                }];
                
                [self.repository fetchHistoryOfDiseasesWithUID:patient.uid andIsFamilyHistory:YES completion:^(NSArray * _Nullable idArray) {
                    patient.familyDiseasesIdArray = idArray;
                    for (NSNumber* diseaseID in idArray) {
                        [self.repository fetchDiseaseWithID:[NSString stringWithFormat:@"%@",diseaseID] completion:^(NSDictionary * _Nullable dict) {
                            Disease *disease = [[Disease alloc] init];
                            [disease initWithDict:dict];
                            [patient.familyDiseasesArray addObject:disease];
                        }];
                    }
                }];
                
                
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


#pragma mark - Diagnostics

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
            for (NSString* documentKey in diagnosticDicts[@"attachments"][@"Documents"]) {
                [[attachmentUrlArray objectAtIndex:0] addObject:diagnosticDicts[@"attachments"][@"Documents"][documentKey]];
            }
            
            for (NSString* documentKey in diagnosticDicts[@"attachments"][@"Extras"]) {
                [[attachmentUrlArray objectAtIndex:1] addObject:diagnosticDicts[@"attachments"][@"Extras"][documentKey]];
            }
            diagnostic.attachmentURLArray = attachmentUrlArray;
            
            //go get the names for each attachment (but not the actual file)
              for (int i = 0; i < [diagnostic.attachmentURLArray count]; i++) {
                  [diagnostic.attachmentArray addObject:[NSMutableArray new]];
                  [self getAttachmentsWithOutFileDataWithArray:[diagnostic.attachmentURLArray objectAtIndex:i] completion:^(NSMutableArray * attachmentArray) {
                      [diagnostic.attachmentArray replaceObjectAtIndex:i withObject:attachmentArray];
                  }];
              }
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
        if (![medicUIDs isKindOfClass:[NSNull class]]) {
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
                    
                    for (NSString* documentKey in dict[@"attachments"][@"Documents"]) {
                        [[attachmentUrlArray objectAtIndex:0] addObject:dict[@"attachments"][@"Documents"][documentKey]];
                    }
                    
                    for (NSString* documentKey in dict[@"attachments"][@"Extras"]) {
                        [[attachmentUrlArray objectAtIndex:1] addObject:dict[@"attachments"][@"Extras"][documentKey]];
                    }
                    
                    medic.attachmentURLArray = attachmentUrlArray;
                    
                    //go get the names for each attachment (but not the actual file)
                    for (int i = 0; i < [medic.attachmentURLArray count]; i++) {
                        [medic.attachmentArray addObject:[NSMutableArray new]];
                        [self getAttachmentsWithOutFileDataWithArray:[medic.attachmentURLArray objectAtIndex:i] completion:^(NSMutableArray * attachmentArray) {
                            [medic.attachmentArray replaceObjectAtIndex:i withObject:attachmentArray];
                        }];
                    }
                    
                    
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
        }
    }];
}

- (void)getAttachmentsWithOutFileDataWithArray:(NSArray*)attachmentURLArray completion:(void (^)(NSMutableArray *))completion{
    NSMutableArray* attachmentArray = [[NSMutableArray alloc] init];
    for (NSString* filePath in attachmentURLArray) {
        [self.repository getFileMetadata:filePath completion:^(NSString * _Nonnull fileName) {
            Attachment* attachment = [[Attachment alloc] init];
            attachment.url = filePath;
            attachment.attachmentName = fileName;
            [attachmentArray addObject:attachment];
        }];
    }
    completion(attachmentArray);
}
@end
