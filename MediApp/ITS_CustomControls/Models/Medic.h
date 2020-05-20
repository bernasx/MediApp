//
//  Medic.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 15/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Medic : Person
@property (nonatomic) NSArray* specialtiesArray;
@property (nonatomic) bool isSuperior;
@property (nonatomic) NSString* superior;
@end

NS_ASSUME_NONNULL_END
