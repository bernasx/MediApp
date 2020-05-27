//
//  Note.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 25/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Note : NSObject
@property (nonatomic) NSString* uid;
@property (nonatomic) NSString* noteText;
@property (nonatomic) NSString* noteTitle;
@end

NS_ASSUME_NONNULL_END
