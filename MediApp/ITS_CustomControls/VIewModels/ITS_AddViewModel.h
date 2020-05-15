//
//  ITS_AddViewModel.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 11/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ITS_Repository.h"
#import "ITS_Enums.h"
#import "Specialty.h"
#import "Medic.h"
NS_ASSUME_NONNULL_BEGIN

@interface ITS_AddViewModel : NSObject
- (void)fetchSpecialties:(void (^)(NSArray * _Nullable))completion;
- (void)buildObjectWithType:(MainMenuSelection)mainMenuSelection andWithArray:(NSArray *)buildingArray;
@end

NS_ASSUME_NONNULL_END
