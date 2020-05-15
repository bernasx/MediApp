//
//  ITS_SpecialtyTableViewCell.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 08/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITS_Colors.h"
#import "Specialty.h"
#import "Disease.h"
#import "Attachment.h"
#import "ITS_Enums.h"
NS_ASSUME_NONNULL_BEGIN
@protocol SearchTableViewCellDelegate;

@interface ITS_SearchTableViewCell : UITableViewCell
- (void)setSpecialty:(Specialty *)specialty;
- (void)setDisease:(Disease *)disease;
- (void)setAttachment:(Attachment *)attachment;
- (void)removeButtonIsHidden:(bool) isHidden;
- (void)setTitleLabelColor:(UIColor *)color;

@property (nonatomic, weak) id<SearchTableViewCellDelegate> delegate;
@end

// 3. Definition of the delegate's interface
@protocol SearchTableViewCellDelegate <NSObject>

- (void)cellRemoval:(ITS_SearchTableViewCell*)cell
            didRemoveObject:(id)object;

@end
NS_ASSUME_NONNULL_END
