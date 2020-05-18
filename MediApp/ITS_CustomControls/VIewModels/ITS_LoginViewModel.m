//
//  ITS_LoginViewModel.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 06/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_LoginViewModel.h"
@interface ITS_LoginViewModel()
@property (nonatomic) ITS_Repository *repository;
@end

@implementation ITS_LoginViewModel
- (instancetype)init {
    self = [super init];
    if (self) {
        self.repository = [[ITS_Repository alloc] init];
    }
    return self;
}


- (void)logInUserWithEmail:(NSString *)email andPassword:(NSString *)password completion:(void (^)(ITS_ServiceErrorHandler * _Nonnull))completion {
    [self.repository loginUserWithEmail:email andPassword:password completion:^(NSError * _Nullable error) {
        ITS_ServiceErrorHandler *errorHandler = [[ITS_ServiceErrorHandler alloc] init];
        if(error) {
            [errorHandler checkStatusCode:error];
        }
        completion(errorHandler);
    }];
}

- (void)logOut {
    [self.repository logOut];
}
@end
