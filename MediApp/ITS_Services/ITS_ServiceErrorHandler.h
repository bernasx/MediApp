//
//  ITS_ErrorHandler.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 06/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ITS_ServiceErrorHandler : NSObject
@property (nonatomic) NSError *currentError;
@property (nonatomic) NSString *errorString;
@property (nonatomic) NSArray *errorIndexes;
@end

NS_ASSUME_NONNULL_END
