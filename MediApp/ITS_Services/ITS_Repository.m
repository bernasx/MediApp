//
//  ITS_Repository.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 06/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_Repository.h"
@interface ITS_Repository()
@property (nonatomic) ITS_FirebaseManager *firebaseManager;
@end

@implementation ITS_Repository
- (instancetype)init {
    self = [super init];
    if (self) {
        self.firebaseManager = [[ITS_FirebaseManager alloc] init];
    }
    return self;
}

- (void)loginUserWithEmail:(NSString *)email andPassword:(NSString *)password completion:(void (^)(NSError * _Nullable))completion {
    [self.firebaseManager signInWithEmail:email andPassword:password completion:^(NSError * _Nonnull error) {
        completion(error);
    }];
}

- (void)registerUserWithEmail:(NSString *)email andPassword:(NSString *)password completion:(void (^)(NSError * _Nullable))completion {
    [self.firebaseManager createUserWithEmail:email andPassword:password completion:^(NSError * _Nonnull error) {
        completion(error);
    }];
}

- (void)logOut {
    [self.firebaseManager signOut];
}
@end
