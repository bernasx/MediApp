//
//  Person.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 12/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property (nonatomic) NSString* firstNames;
@property (nonatomic) NSString* lastNames;
@property (nonatomic) int age;
@end

NS_ASSUME_NONNULL_END
