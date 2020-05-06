//
//  ITS_FirebaseManager.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 06/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FirebaseDatabase.h>
#import <FirebaseAuth.h>
NS_ASSUME_NONNULL_BEGIN

@interface ITS_FirebaseManager : NSObject

- (void)createUserWithEmail:(NSString *)email andPassword:(NSString *)password completion:(void (^)(NSError * _Nonnull errorMessage))completion;
- (void)signInWithEmail:(NSString *)email andPassword:(NSString *)password completion:(void (^)(NSError * _Nonnull errorMessage))completion;
- (void)signOut;
@end

NS_ASSUME_NONNULL_END
