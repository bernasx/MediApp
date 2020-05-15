//
//  Attachment.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 15/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Attachment : NSObject
@property (nonatomic) NSString* attachmentName;
@property (nonatomic) NSData* attachmentData;
@end

NS_ASSUME_NONNULL_END
