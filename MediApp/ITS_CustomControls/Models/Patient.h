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
@property (nonatomic) NSMutableArray* previousDiseasesArray;
@property (nonatomic) NSArray* previousDiseasesIdArray;
@property (nonatomic) NSMutableArray* familyDiseasesArray;
@property (nonatomic) NSArray* familyDiseasesIdArray;
@property (nonatomic) NSString* snsNumber;
@property (nonatomic) NSMutableArray* notesArray;
@property (nonatomic) NSArray<Diagnostic *> *diagnosticArray;
- (void)initWithDict:(NSDictionary *)dict andUid:(NSString*)uid;
- (NSMutableArray *)arrayWithFullData;
@end

NS_ASSUME_NONNULL_END
