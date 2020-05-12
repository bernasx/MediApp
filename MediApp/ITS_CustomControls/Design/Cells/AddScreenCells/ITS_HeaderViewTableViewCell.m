//
//  ITS_HeaderViewTableViewCell.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 12/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_HeaderViewTableViewCell.h"
@interface ITS_HeaderViewTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *sectionTitleLabel;

@end
@implementation ITS_HeaderViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.sectionTitleLabel setTextColor:[ITS_Colors primaryColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTitleForSection:(NSString*)title {
    [self.sectionTitleLabel setText:title];
}

@end
