//
//  ITS_FirebaseManager.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 06/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_FirebaseManager.h"


@interface ITS_FirebaseManager()
@property (strong, nonatomic) FIRDatabaseReference *ref;
@end

@implementation ITS_FirebaseManager
- (instancetype)init {
    self = [super init];
    if (self) {
        self.ref = [[FIRDatabase database] reference];
    }
    return self;
}

- (void)createUserWithEmail:(NSString *)email andPassword:(NSString *)password completion:(void (^)(NSError * _Nonnull))completion {
    
    [[FIRAuth auth] createUserWithEmail:email password:password completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
        completion(error);
    }];
}

- (void)signInWithEmail:(NSString *)email andPassword:(NSString *)password completion:(void (^)(NSError * _Nonnull))completion {
    [[FIRAuth auth] signInWithEmail:email password:password completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
        completion(error);
    }];
}

- (void)signOut {
     FIRAuth *firebaseAuth = [FIRAuth auth];
     NSError *signOutError;
     BOOL status = [firebaseAuth signOut:&signOutError];
     if (!status) {
       NSLog(@"Error signing out: %@", signOutError);
       return;
     }
}

@end
