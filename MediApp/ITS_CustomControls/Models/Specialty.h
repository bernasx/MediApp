//
//  Specialty.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 08/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Specialty : NSObject
@property (nonatomic) NSString *specialtyName;
@property (nonatomic) NSString *specialtyJob;
@property (nonatomic) NSString *specialtyId;

- (void)initWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
