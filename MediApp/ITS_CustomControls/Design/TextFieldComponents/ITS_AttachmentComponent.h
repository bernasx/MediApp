//
//  ITS_AttachmentComponent.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 15/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_BaseTextFieldComponent.h"
#import "ITS_Colors.h"
#import "ITS_SearchTableViewCell.h"
#import "ITS_AttachmentHeaderTableViewCell.h"
#import <MobileCoreServices/MobileCoreServices.h>
NS_ASSUME_NONNULL_BEGIN
@protocol AttachmentComponentDelegate;
@interface ITS_AttachmentComponent : ITS_BaseTextFieldComponent <UITableViewDelegate,UITableViewDataSource, SearchTableViewCellDelegate,UIDocumentPickerDelegate,AttachmentTableViewHeaderDelegate>
@property (strong, nonatomic) IBOutlet UIView *view;
@property (nonatomic, weak) id<AttachmentComponentDelegate> delegate;
- (void)initWithTitle:(NSString *)title andFrame:(CGRect)frame andSectionArray:(NSArray *)sectionArray andSectionStringsArray:(NSArray *)sectionStringsArray;
- (NSArray *)getSections;
- (id)getObjectData;
- (void)setAttachmentArray:(NSMutableArray *)attachmentArray;
@end

// 3. Definition of the delegate's interface
@protocol AttachmentComponentDelegate <NSObject>
- (void)attachmentComponentDidTapAddAttachment:(ITS_AttachmentComponent*)attachmentComponent withDocumentPicker:(UIDocumentPickerViewController *)documentPicker;

@end

NS_ASSUME_NONNULL_END
