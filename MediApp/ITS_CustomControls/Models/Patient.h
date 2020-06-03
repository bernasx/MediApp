//
//  Patient.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 21/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "Person.h"
#import "Diagnostic.h"
NS_ASSUME_NONNULL_BEGIN

@interface Patient : Person
@property (nonatomic) NSArray* previousDiseasesArray;
@property (nonatomic) NSArray* familyDiseasesArray;
@property (nonatomic) NSString* snsNumber;
@property (nonatomic) NSMutableArray* notesArray;
@property (nonatomic) NSArray<Diagnostic *> *diagnosticArray;
- (void)initWithDict:(NSDictionary *)dict andUid:(NSString*)uid;
@end

NS_ASSUME_NONNULL_END
