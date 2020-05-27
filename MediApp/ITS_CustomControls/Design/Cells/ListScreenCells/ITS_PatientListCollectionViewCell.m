//
//  ITS_PatientListCollectionViewCell.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 26/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_PatientListCollectionViewCell.h"
@interface ITS_PatientListCollectionViewCell()
@end
@implementation ITS_PatientListCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initContainerView:[ITS_Colors mainMenuCellGradient]];
}

@end
