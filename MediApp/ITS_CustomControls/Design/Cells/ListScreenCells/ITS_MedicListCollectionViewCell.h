//
//  ITS_MedicListCollectionViewCell.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 01/06/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_BaseListCollectionViewCell.h"
#import "ITS_ListLabelOnlyTableViewCell.h"
#import "Medic.h"
#import "Specialty.h"
NS_ASSUME_NONNULL_BEGIN

@interface ITS_MedicListCollectionViewCell : ITS_BaseListCollectionViewCell <UITableViewDelegate,UITableViewDataSource>
- (void)fillCellWithData:(id)data;
@end

NS_ASSUME_NONNULL_END
