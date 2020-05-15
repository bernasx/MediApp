//
//  ITS_SpecialtyTableViewCell.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 08/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_SearchTableViewCell.h"
@interface ITS_SearchTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *removeButton;
@property (nonatomic) Specialty *specialty;
@property (nonatomic) Disease *disease;
@property (nonatomic) Attachment *attachment;
@end
@implementation ITS_SearchTableViewCell
- (IBAction)onRemove:(id)sender {
    id<SearchTableViewCellDelegate> strongDelegate = self.delegate;
    // Our delegate method is optional, so we should
    // check that the delegate implements it
    
    //check what object to return
    if(self.specialty){
        if ([strongDelegate respondsToSelector:@selector(cellRemoval:didRemoveObject:)]) {
            [strongDelegate cellRemoval:self didRemoveObject:self.specialty];
        }
    } else if (self.disease) {
        if ([strongDelegate respondsToSelector:@selector(cellRemoval:didRemoveObject:)]) {
            [strongDelegate cellRemoval:self didRemoveObject:self.disease];
        }
        
    } else {
        if ([strongDelegate respondsToSelector:@selector(cellRemoval:didRemoveObject:)]) {
            [strongDelegate cellRemoval:self didRemoveObject:self.attachment];
        }
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.titleLabel setTextColor:[ITS_Colors smallTextColor]];
    [self.removeButton setTintColor:[ITS_Colors smallButtonAndTitleColor]];
    [self.removeButton setHidden:YES];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSpecialty:(Specialty *)specialty {
    _specialty = specialty;
    [self.titleLabel setText:self.specialty.specialtyName];
}

- (void)setDisease:(Disease *)disease {
    _disease = disease;
    [self.titleLabel setText:self.disease.diseaseName];
}

- (void)setAttachment:(Attachment *)attachment {
    _attachment = attachment;
    [self.titleLabel setText:self.attachment.attachmentName];
}

- (void)setTitleLabelColor:(UIColor *)color {
    [self.titleLabel setTextColor:color];
}

//Since hidding the button may be needed, this provides that option
- (void)removeButtonIsHidden:(bool)isHidden {
    [self.removeButton setHidden:isHidden];
}

@end
