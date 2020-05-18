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
#import "Specialty.h"
NS_ASSUME_NONNULL_BEGIN

@interface ITS_Repository : NSObject
//login and register methods
- (void)registerSeparateUserWithEmail:(NSString *)email completion:(void (^)(NSString *))completion;
- (void)loginUserWithEmail:(NSString *)email andPassword:(NSString *)password completion:(void (^)(NSError * _Nullable error))completion;
- (void)logOut;
//static fetches
- (void)fetchSpecialties:(void (^)(NSArray * _Nullable))completion;
//write new data
- (void)writeNewMedic:(Medic *)medic withUID:(NSString*)uid;

@end

NS_ASSUME_NONNULL_END
