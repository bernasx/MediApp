//
//  ITS_Repository.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 06/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_Repository.h"
@interface ITS_Repository()
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (nonatomic) FIRStorage *storage;
@end

@implementation ITS_Repository
- (instancetype)init {
    self = [super init];
    if (self) {
        self.ref = [[FIRDatabase database] reference];
        self.storage  = [FIRStorage storage];
    }
    return self;
}

#pragma mark - General Fetches for Static Data

- (void)fetchSpecialties:(void (^)(NSArray * _Nullable))completion  {
    [[_ref child:@"specialties"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        completion(snapshot.value);
    }];
}

- (void)fetchSpecialtyWithID:(NSString*)uid completion:(void (^)(NSDictionary * _Nullable))completion {
    [[[_ref child:@"specialties"] child:uid] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        completion(snapshot.value);
    }];
}

- (void)fetchDiseases:(void (^)(NSArray * _Nullable))completion {
    [[_ref child:@"diseases"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        completion(snapshot.value);
    }];
}

- (void)fetchDiseaseWithID:(NSString*)uid completion:(void (^)(NSDictionary * _Nullable))completion {
    [[[_ref child:@"diseases"] child:uid] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        completion(snapshot.value);
    }];
}

#pragma mark - User Creation

//logs in user with an email and password, return an error if it failed
- (void)loginUserWithEmail:(NSString *)email andPassword:(NSString *)password completion:(void (^)(NSError * _Nullable))completion {
    [[FIRAuth auth] signInWithEmail:email password:password completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
        completion(error);
    }];
}


//registers a user and immediately logs out and back in with the old account, assuming the old password is 123123123
- (void)registerSeparateUserWithEmail:(NSString *)email completion:(void (^)(NSString *))completion{
    NSString *tempEmail = [[FIRAuth auth] currentUser].email;
    //logout
    [self logOut];
    
    //Create a new account
    [[FIRAuth auth] createUserWithEmail:email password:@"123123123" completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
        NSLog(@"%@",error.localizedDescription);
        //logout
        [self logOutAndLogBackIn:tempEmail completion:^(NSString * uid) {
            completion(uid);
        }];
    }];
 
}
//logs out of the new fake user, logs back in to old one.
- (void)logOutAndLogBackIn:(NSString *)email completion:(void (^)(NSString *))completion {
      NSString *newUserUid = [[[FIRAuth auth] currentUser] uid];
    //Logout again
    [self logOut];
    //login to old account
    [[FIRAuth auth] signInWithEmail:email password:@"123123123" completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
           NSLog(@"%@",error.localizedDescription);
        completion(newUserUid);
    }];
}

- (void)logOut {
    FIRAuth *firebaseAuth = [FIRAuth auth];
    NSError *signOutError;
    bool status = [firebaseAuth signOut:&signOutError];
    if (!status) {
        NSLog(@"Error signing out: %@", signOutError);
        return;
    }
}

#pragma mark - Medic Functions

//uid is the new user's uid
- (void)writeNewMedic:(Medic *)medic withUID:(NSString*)uid andWithSections:(nonnull NSArray *)sections {
    NSString*currentUserUID = [FIRAuth auth].currentUser.uid;
    [[[[self.ref child:@"medics"] child:uid] child:@"firstName"] setValue:medic.firstNames];
    [[[[self.ref child:@"medics"] child:uid] child:@"lastName"] setValue:medic.lastNames];
    [[[[self.ref child:@"medics"] child:uid] child:@"age"] setValue:[NSNumber numberWithInt:medic.age]];
    [[[[self.ref child:@"medics"] child:uid] child:@"gender"] setValue:medic.gender];
    [[[[self.ref child:@"medics"] child:uid] child:@"address"] setValue:medic.address];
    [[[[self.ref child:@"medics"] child:uid] child:@"postalCode"] setValue:medic.postalCode];
    [[[[self.ref child:@"medics"] child:uid] child:@"natural"] setValue:medic.natural];
    [[[[self.ref child:@"medics"] child:uid] child:@"nationality"] setValue:medic.nationality];
    [[[[self.ref child:@"medics"] child:uid] child:@"NIF"] setValue:medic.NIF];
    [[[[self.ref child:@"medics"] child:uid] child:@"ccNumber"] setValue:medic.ccNumber];
    [[[[self.ref child:@"medics"] child:uid] child:@"email"] setValue:medic.email];
    [[[[self.ref child:@"medics"] child:uid] child:@"phoneNumber"] setValue:medic.phoneNumber];
    [[[[self.ref child:@"medics"] child:uid] child:@"isSuperior"] setValue:[NSNumber numberWithBool:medic.isSuperior]];
    [[[[self.ref child:@"medics"] child:uid] child:@"superior"] setValue:currentUserUID];
    
    //add medic to superior medics
    if (medic.isSuperior) {
        [self getSuperiorMedics:^(NSArray * _Nullable superiorMedicsArray) {
            if ([superiorMedicsArray isKindOfClass:[NSNull class]]) {
                superiorMedicsArray = [[NSArray alloc] init];
            }
            NSMutableArray* newSuperiorMedicsArray = [[NSMutableArray alloc] initWithArray:superiorMedicsArray];
            [newSuperiorMedicsArray addObject:@{@"uid":uid,@"superior":currentUserUID}]; //add
            [[self.ref child:@"superiorMedics"] setValue:newSuperiorMedicsArray];
        }];
    }
  
    [[[[[self.ref child:@"medics"] child:currentUserUID] child:@"medics"] childByAutoId] setValue:@{@"uid":uid}];

    
    
    //get only the IDs
    NSMutableArray *specialtiesArray = [NSMutableArray new];
    for (Specialty* specialty in medic.specialtiesArray) {
        [specialtiesArray addObject:specialty.specialtyId];
    }
    //Save the IDs
    [[[[self.ref child:@"medics"] child:uid] child:@"specialties"] setValue:specialtiesArray];
    
    int sectionCount = 0; //track which section we're in so we can name it for the file path
    for (NSMutableArray* array in medic.attachmentArray) {
        //get all the attachments, add a uuid to each of them.
        for (Attachment* attachment in array) {
            NSUUID *uuid = [NSUUID UUID]; //generate a new id for the attachment
            NSString *str = [uuid UUIDString];
            [self saveToStorageWithReferenceString:[NSString stringWithFormat:@"%@/attachments/%@/%@/%@",uid,[sections objectAtIndex:sectionCount],str,attachment.attachmentName] andData:attachment.attachmentData completion:^(NSURL * url) {
                [[[[[[self.ref child:@"medics"] child:uid] child:@"attachments"] child:[sections objectAtIndex:sectionCount]]childByAutoId] setValue:url.absoluteString];
            }];
        }
        sectionCount += 1;
    }
}

//get medics that someone with the uid is in charge of
- (void)getMedicsFromUID:(NSString *)uid completion:(void (^)(NSDictionary * _Nullable))completion {
    [[[[self.ref child:@"medics"] child:uid] child:@"medics"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        completion(snapshot.value);
    }];
}

//get an array of superior medic uids
- (void)getSuperiorMedics:(void (^)(NSArray * _Nullable))completion {
    [[_ref child:@"superiorMedics"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        completion(snapshot.value);
    }];
}

//get all medics
- (void)getAllMedics:(void (^)(NSDictionary * _Nullable))completion {
    [[_ref child:@"medics"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        completion(snapshot.value);
    }];
}

- (void)getMedicForUID:(NSString*)uid completion:(void (^)(NSDictionary * _Nullable))completion {
    [[[_ref child:@"medics"] child:uid] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
           completion(snapshot.value);
       }];
}

#pragma mark - Patient Functions

//uid is the new user's uid
- (void)writeNewPatient:(Patient *)patient withUID:(NSString*)uid andWithSections:(nonnull NSArray *)sections {
       /* Patient info */
    NSString*currentUserUID = [FIRAuth auth].currentUser.uid;
    [[[[self.ref child:@"patients"] child:uid] child:@"firstName"] setValue:patient.firstNames];
    [[[[self.ref child:@"patients"] child:uid] child:@"lastName"] setValue:patient.lastNames];
    [[[[self.ref child:@"patients"] child:uid] child:@"age"] setValue:[NSNumber numberWithInt:patient.age]];
    [[[[self.ref child:@"patients"] child:uid] child:@"gender"] setValue:patient.gender];
    [[[[self.ref child:@"patients"] child:uid] child:@"address"] setValue:patient.address];
    [[[[self.ref child:@"patients"] child:uid] child:@"postalCode"] setValue:patient.postalCode];
    [[[[self.ref child:@"patients"] child:uid] child:@"natural"] setValue:patient.natural];
    [[[[self.ref child:@"patients"] child:uid] child:@"nationality"] setValue:patient.nationality];
    [[[[self.ref child:@"patients"] child:uid] child:@"NIF"] setValue:patient.NIF];
    [[[[self.ref child:@"patients"] child:uid] child:@"ccNumber"] setValue:patient.ccNumber];
    [[[[self.ref child:@"patients"] child:uid] child:@"email"] setValue:patient.email];
    [[[[self.ref child:@"patients"] child:uid] child:@"phoneNumber"] setValue:patient.phoneNumber];
    [[[[self.ref child:@"patients"] child:uid] child:@"snsNumber"] setValue:patient.snsNumber];

    for (Note* note in patient.notesArray) {
        [[[[self.ref child:@"notes"] child:note.uid] child:@"title"]setValue:note.noteTitle];
        [[[[self.ref child:@"notes"] child:note.uid] child:@"text"]setValue:note.noteTitle];
        [[[[[self.ref child:@"patients"] child:uid] child:@"notes"] child:note.uid] setValue:note.uid];
    }
    
    /* Disease history */
    //get only the IDs
    NSMutableArray *diseasesArray = [NSMutableArray new];
    for (Disease* disease in patient.previousDiseasesArray) {
        [diseasesArray addObject:disease.diseaseId];
    }
    //Save the ID
    [[[[[self.ref child:@"history"] child:@"patientHistory"] child:uid] child:@"previousDiseases"] setValue:diseasesArray];
    
    //Same for family history
    NSMutableArray *familyDiseases = [NSMutableArray new];
    for (Disease* disease in patient.familyDiseasesArray) {
        [familyDiseases addObject:disease.diseaseId];
    }
    //Save the ID
    [[[[[self.ref child:@"history"] child:@"patientHistory"] child:uid] child:@"familyDiseases"] setValue:familyDiseases];
    
    /* Patient attachments */
    int patientSectionCount = 0; //track which section we're in so we can name it for the file path
    for (NSMutableArray* array in patient.attachmentArray) {
        //get all the attachments, add a uuid to each of them.
        for (Attachment* attachment in array) {
            NSUUID *uuid = [NSUUID UUID]; //generate a new id for the attachment
            NSString *str = [uuid UUIDString];
            [self saveToStorageWithReferenceString:[NSString stringWithFormat:@"%@/attachments/%@/%@/%@",uid,[sections objectAtIndex:patientSectionCount],str,attachment.attachmentName] andData:attachment.attachmentData completion:^(NSURL * url) {
                [[[[[[self.ref child:@"patients"] child:uid] child:@"attachments"] child:[sections objectAtIndex:patientSectionCount]]childByAutoId] setValue:url.absoluteString];
            }];
        }
        patientSectionCount += 1;
    }
   
    [self writeNewDiagnosticWithArray:patient.diagnosticArray withPatientUid:uid andCurrentUserUid:currentUserUID andSections:sections];
}


- (void)getAllPatients:(void (^)(NSDictionary * _Nullable))completion {
    [[_ref child:@"patients"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        completion(snapshot.value);
    }];
}

#pragma mark - Diagnostic Functions

- (void)getDiagnosticsFromPatientUID:(NSString*)uid completion:(void (^)(NSDictionary * _Nullable))completion {
    [[[_ref child:@"diagnostics"] child:uid] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        completion(snapshot.value);
    }];
}

- (void)writeNewDiagnosticWithArray:(NSArray*)diagnosticArray withPatientUid:(NSString*)uid andCurrentUserUid:(NSString*)currentUserUid andSections:(NSArray*)sections {
    /* Save Diagnostics */
    for (Diagnostic* diagnostic in diagnosticArray) {
        NSString* historyID = [[NSUUID UUID] UUIDString];
        NSString* creationDate = [NSString stringWithFormat:@"%f",diagnostic.creationDate.timeIntervalSince1970];
        [[[[[self.ref child:@"diagnostics"] child:uid] child:diagnostic.uid.UUIDString] child:@"treatment"] setValue:diagnostic.treatment];
        [[[[[self.ref child:@"diagnostics"] child:uid] child:diagnostic.uid.UUIDString] child:@"medic"] setValue:currentUserUid];
        [[[[[self.ref child:@"diagnostics"] child:uid] child:diagnostic.uid.UUIDString] child:@"creationDate"] setValue:creationDate];
        
        [[[[[[self.ref child:@"history"] child:@"diagnostics"] child:diagnostic.uid.UUIDString] child:historyID] child:@"treatment"] setValue:diagnostic.treatment];
        [[[[[[self.ref child:@"history"] child:@"diagnostics"] child:diagnostic.uid.UUIDString] child:historyID] child:@"medic"] setValue:currentUserUid];
        [[[[[[self.ref child:@"history"] child:@"diagnostics"] child:diagnostic.uid.UUIDString] child:historyID] child:@"creationDate"] setValue:creationDate];
        
        NSMutableArray* currentDiseases = [[NSMutableArray alloc] init];
        for (Disease* disease in diagnostic.currentDiseases) {
            [currentDiseases addObject:disease.diseaseId];
        }
        
        [[[[[self.ref child:@"diagnostics"] child:uid] child:diagnostic.uid.UUIDString] child:@"currentDiseases"] setValue:currentDiseases];
        
        [[[[[[self.ref child:@"history"] child:@"diagnostics"] child:diagnostic.uid.UUIDString] child:historyID] child:@"currentDiseases"] setValue:currentDiseases];
        
        //save diagnostic to patient path
        [[[[self.ref child:@"patients"] child:uid] child:@"diagnostic"] setValue:diagnostic.uid.UUIDString];
        //diagnostic attachments
        int sectionCount = 0; //track which section we're in so we can name it for the file path
        for (NSMutableArray* array in diagnostic.attachmentArray) {
            //get all the attachments, add a uuid to each of them.
            for (Attachment* attachment in array) {
                NSUUID *uuid = [NSUUID UUID]; //generate a new id for the attachment
                NSString *str = [uuid UUIDString];
                [self saveToStorageWithReferenceString:[NSString stringWithFormat:@"%@/attachments/%@/%@/%@",diagnostic.uid,[sections objectAtIndex:sectionCount],str,attachment.attachmentName] andData:attachment.attachmentData completion:^(NSURL * url) {
                    [[[[[[[self.ref child:@"diagnostics"] child:uid]child:diagnostic.uid.UUIDString] child:@"attachments"] child:[diagnostic.attachmentsSections objectAtIndex:sectionCount]]childByAutoId] setValue:url.absoluteString];
                    
                    [[[[[[[[self.ref child:@"history"] child:@"diagnostics"] child:diagnostic.uid.UUIDString] child:historyID] child:@"attachments"] child:[diagnostic.attachmentsSections objectAtIndex:sectionCount]]childByAutoId] setValue:url.absoluteString];
                }];
            }
            sectionCount += 1;
        }
        //diagnostic notes
        for (Note* note in diagnostic.notesArray) {
            [[[[self.ref child:@"notes"] child:note.uid] child:@"title"]setValue:note.noteTitle];
            [[[[self.ref child:@"notes"] child:note.uid] child:@"text"]setValue:note.noteTitle];
            [[[[[[self.ref child:@"diagnostics"] child:uid]child:diagnostic.uid.UUIDString] child:@"notes"] child:note.uid] setValue:note.uid];
            
            [[[[[[[self.ref child:@"history"] child:@"diagnostics"] child:diagnostic.uid.UUIDString] child:historyID] child:@"currentDiseases"] child:note.uid] setValue:note.uid];
        }
        
        //save diagnostic id to medic by patient
        [[[[[self.ref child:@"medics"] child:currentUserUid] child:@"diagnostics"] child:diagnostic.uid.UUIDString] setValue:diagnostic.uid.UUIDString];
    }
}


#pragma mark - Other fetches

- (void)getNoteFromUID:(NSString*)uid completion:(void (^)(NSDictionary * _Nullable))completion {
    [[[_ref child:@"notes"] child:uid] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        completion(snapshot.value);
    }];
}

#pragma mark - Storage Functions

- (void)saveToStorageWithReferenceString:(NSString *)refString andData:(NSData *)data completion:(void (^)(NSURL *))completion {
    FIRStorageReference *storageRef = [self.storage reference];
    FIRStorageReference *ref = [storageRef child:refString];
    [ref putData:data metadata:nil completion:^(FIRStorageMetadata * _Nullable metadata, NSError * _Nullable error) {
        if(error) {
            NSLog(@"%@",error.localizedDescription);
        } else {
            [ref downloadURLWithCompletion:^(NSURL * _Nullable URL, NSError * _Nullable error) {
                completion(URL);
            }];
        }
    }];
}
@end
