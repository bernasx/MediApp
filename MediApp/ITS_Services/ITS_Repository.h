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
#import "Medic.h"
NS_ASSUME_NONNULL_BEGIN

@interface ITS_Repository : NSObject
- (void)registerUserWithEmail: (NSString *) email andPassword: (NSString *)password completion:(void (^)(NSError * _Nullable error))completion;
- (void)registerSeparateUserWithEmail:(NSString *)email completion:(void (^)(NSString *))completion;
- (void)loginUserWithEmail:(NSString *)email andPassword:(NSString *)password completion:(void (^)(NSError * _Nullable error))completion;
- (void)logOut;
- (void)fetchSpecialties:(void (^)(NSArray * _Nullable))completion;
@end

NS_ASSUME_NONNULL_END
