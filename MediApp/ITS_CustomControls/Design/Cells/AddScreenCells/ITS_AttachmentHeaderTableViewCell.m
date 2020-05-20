//
//  ITS_AttachmentHeaderTableViewCell.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 19/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_AttachmentHeaderTableViewCell.h"
@interface ITS_AttachmentHeaderTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *addDocumentButton;
@end
@implementation ITS_AttachmentHeaderTableViewCell
- (IBAction)didPressAddButton:(id)sender {
    id<AttachmentTableViewHeaderDelegate> strongDelegate = self.delegate;
    
    if ([strongDelegate respondsToSelector:@selector(attachmentTableViewHeader:didTapDocumentsAtIndex:)]) {
        [strongDelegate attachmentTableViewHeader:self didTapDocumentsAtIndex:self.index];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTitleForSection:(NSString *)title {
    [self.titleLabel setText:title];
    [self.titleLabel setTextColor:[ITS_Colors secondaryColor]];
}

@end
