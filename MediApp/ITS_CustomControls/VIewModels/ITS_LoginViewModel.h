//
//  ITS_LoginViewModel.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 06/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ITS_Repository.h"
#import "ITS_ServiceErrorHandler.h"
NS_ASSUME_NONNULL_BEGIN

@interface ITS_LoginViewModel : NSObject
- (void)registerUserWithEmail: (NSString *) email andPassword: (NSString *) password;
- (void)logInUserWithEmail:(NSString *)email andPassword:(NSString *)password completion:(void (^)(ITS_ServiceErrorHandler * errorHandler))completion;
- (void)logOut;
@end

NS_ASSUME_NONNULL_END
