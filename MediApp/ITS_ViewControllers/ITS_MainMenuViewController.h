//
//  ITS_MainMenuViewController.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 06/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_ViewController.h"
#import <FirebaseAuth.h>
#import "ITS_MainMenuSelectionCollectionViewCell.h"
#import "ITS_MedicsListViewController.h"
#import "ITS_CarroselCollectionView.h"
NS_ASSUME_NONNULL_BEGIN

@interface ITS_MainMenuViewController : ITS_ViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *topSectionView;
@property (weak, nonatomic) IBOutlet ITS_CarroselCollectionView *menuSelectionCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *showAllButton;
@end

NS_ASSUME_NONNULL_END
