//
//  ITS_AddMedicViewModel.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 08/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_AddMedicViewModel.h"
@interface ITS_AddMedicViewModel()
@property (nonatomic) ITS_Repository *repository;
@end
@implementation ITS_AddMedicViewModel
- (instancetype)init {
    self = [super init];
    if (self) {
        self.repository = [[ITS_Repository alloc] init];
    }
    return self;
}

- (void)fetchSpecialties:(void (^)(NSArray * _Nullable))completion {
    [self.repository fetchSpecialties:^(NSArray * _Nullable arr) {
        NSMutableArray *specialtiesArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in arr) {
            Specialty *specialty = [[Specialty alloc] init];
            [specialty initWithDict:dict];
            [specialtiesArray addObject:specialty];
        }
        completion(specialtiesArray);
    }];
}

@end
