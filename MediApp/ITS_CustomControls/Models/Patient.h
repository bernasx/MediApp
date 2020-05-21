//
//  Patient.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 21/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Patient : Person
@property (nonatomic) NSArray* diseasesArray;
@property (nonatomic) NSString* snsNumber;
@end

NS_ASSUME_NONNULL_END
