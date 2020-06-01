//
//  ITS_ListViewModel.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 28/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ITS_Repository.h"
NS_ASSUME_NONNULL_BEGIN

@interface ITS_ListViewModel : NSObject
- (void)getPatients:(void (^)(NSArray * _Nullable))completion;
@end

NS_ASSUME_NONNULL_END
