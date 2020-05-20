//
//  ITS_AttachmentHeaderTableViewCell.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 19/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITS_Colors.h"
NS_ASSUME_NONNULL_BEGIN
@protocol AttachmentTableViewHeaderDelegate;
@interface ITS_AttachmentHeaderTableViewCell : UITableViewCell
- (void)setTitleForSection:(NSString *)title;
@property (nonatomic, weak) id<AttachmentTableViewHeaderDelegate> delegate;
@property (nonatomic) int index;
@end

@protocol AttachmentTableViewHeaderDelegate <NSObject>
- (void)attachmentTableViewHeader:(ITS_AttachmentHeaderTableViewCell*)header didTapDocumentsAtIndex:(int)index;
@end
NS_ASSUME_NONNULL_END
