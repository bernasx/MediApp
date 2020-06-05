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
@property (nonatomic) NSMutableArray* specialtiesArray;
@property (nonatomic) bool isSuperior;
@property (nonatomic) NSString* superior;
@property (nonatomic) NSArray* specialtyIds;
- (void)initWithDict:(NSDictionary *)dict andUid:(NSString*)uid;

- (NSMutableArray *)arrayWithFullData;
@end

NS_ASSUME_NONNULL_END
