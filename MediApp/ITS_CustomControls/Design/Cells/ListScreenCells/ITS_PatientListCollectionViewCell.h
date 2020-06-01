//
//  ITS_PatientListCollectionViewCell.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 26/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_BaseListCollectionViewCell.h"
#import "Patient.h"
#import "Disease.h"
#import "ITS_ListLabelOnlyTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface ITS_PatientListCollectionViewCell : ITS_BaseListCollectionViewCell<UITableViewDelegate,UITableViewDataSource>
-(void)fillCellWithPatient:(Patient *)patient;
@end

NS_ASSUME_NONNULL_END
