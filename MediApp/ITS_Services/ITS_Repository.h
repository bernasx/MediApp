//
//  ITS_Repository.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 06/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FirebaseAuth.h>
#import <FirebaseDatabase.h>
#import <FirebaseStorage.h>
#import "Medic.h"
#import "Patient.h"
#import "Specialty.h"
#import "Note.h"
#import "Disease.h"
NS_ASSUME_NONNULL_BEGIN

@interface ITS_Repository : NSObject
//login and register methods
- (void)registerSeparateUserWithEmail:(NSString *)email completion:(void (^)(NSString *))completion;
- (void)loginUserWithEmail:(NSString *)email andPassword:(NSString *)password completion:(void (^)(NSError * _Nullable error))completion;
- (void)logOut;
//static fetches
- (void)fetchSpecialties:(void (^)(NSArray * _Nullable))completion;
- (void)fetchSpecialtyWithID:(NSString*)uid completion:(void (^)(NSDictionary * _Nullable))completion;
- (void)fetchDiseases:(void (^)(NSArray * _Nullable))completion;
- (void)fetchDiseaseWithID:(NSString*)uid completion:(void (^)(NSDictionary * _Nullable))completion;
//write new data
- (void)writeNewMedic:(Medic *)medic withUID:(NSString*)uid andWithSections:(NSArray *)sections;
- (void)writeNewPatient:(Patient *)patient withUID:(NSString*)uid andWithSections:(nonnull NSArray *)sections;
//patients
- (void)getAllPatients:(void (^)(NSDictionary * _Nullable))completion;
//Diagnostic
- (void)getDiagnosticsFromPatientUID:(NSString*)uid completion:(void (^)(NSDictionary * _Nullable))completion;
//Medics
- (void)getAllMedics:(void (^)(NSDictionary * _Nullable))completion;
- (void)getMedicForUID:(NSString*)uid completion:(void (^)(NSDictionary * _Nullable))completion;
- (void)getMedicsFromUID:(NSString *)uid completion:(void (^)(NSDictionary * _Nullable))completion;
- (void)editMedic:(Medic *)medic andWithSections:(nonnull NSArray*)sections andOldMedic:(Medic *)oldMedic;
//others
- (void)getNoteFromUID:(NSString*)uid completion:(void (^)(NSDictionary * _Nullable))completion;

//storage
- (void)getFileMetadata:(NSString *)refString completion:(void (^)(NSString *))completion;
@end

NS_ASSUME_NONNULL_END
