//
//  ITS_AddViewModel.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 11/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ITS_Repository.h"
#import "Specialty.h"
NS_ASSUME_NONNULL_BEGIN

@interface ITS_AddViewModel : NSObject
- (void)fetchSpecialties:(void (^)(NSArray * _Nullable))completion;
@end

NS_ASSUME_NONNULL_END
