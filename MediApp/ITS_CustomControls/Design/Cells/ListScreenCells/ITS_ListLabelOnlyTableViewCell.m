//
//  ITS_ListLabelOnlyTableViewCell.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 28/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_ListLabelOnlyTableViewCell.h"

@implementation ITS_ListLabelOnlyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.titleLabel setTextColor:[ITS_Colors smallTextColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
