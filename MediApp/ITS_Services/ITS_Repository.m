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
@end

@implementation ITS_Repository
- (instancetype)init {
    self = [super init];
    if (self) {
        self.ref = [[FIRDatabase database] reference];
    }
    return self;
}

#pragma mark - General Fetches for Static Data

- (void)fetchSpecialties:(void (^)(NSArray * _Nullable))completion  {
    [[_ref child:@"specialties"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
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

//registers a user normally
- (void)registerUserWithEmail:(NSString *)email andPassword:(NSString *)password completion:(void (^)(NSError * _Nullable))completion {
    [[FIRAuth auth] createUserWithEmail:email password:password completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
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

- (void)writeNewMedic:(Medic *)medic {
    
}
@end
