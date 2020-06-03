//
//  ITS_ListViewController.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 21/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_ViewController.h"
#import "ITS_AddViewController.h"
#import "ITS_Enums.h"
#import "ITS_BaseListCollectionViewCell.h"
#import "ITS_PatientListCollectionViewCell.h"
#import "ITS_MedicListCollectionViewCell.h"
#import "ITS_ListViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ITS_ListViewController : ITS_ViewController
@property (nonatomic) MainMenuSelection mainMenuSelection;
@property (nonatomic) ITS_ListViewModel *viewModel;
@end

NS_ASSUME_NONNULL_END
