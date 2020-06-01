//
//  ITS_ListViewController.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 21/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_ListViewController.h"

@interface ITS_ListViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *listCollectionView;
@property (nonatomic) NSArray* objectArray;
@end

@implementation ITS_ListViewController

#pragma mark -  Initial Setup
- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[ITS_ListViewModel alloc] init];
    [self designViewElements];
    [self.viewModel getPatients:^(NSArray * _Nullable array) {
        self.objectArray = array;
        [self.listCollectionView reloadData];
    }];
}

- (void)designViewElements {
    
    //list collectionview layout
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(self.view.frame.size.width - 20, 160);
    [layout setSectionInset:UIEdgeInsetsMake(5, 10, 5, 10)];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 40;
    layout.minimumInteritemSpacing = 40;
    self.listCollectionView.collectionViewLayout = layout;
    
    
    //designing for each type
    switch (self.mainMenuSelection) {
        case MainMenuSelectionMedics:
            [self.navigationItem setTitle:NSLocalizedString(@"list_medic_title", @"")];
            break;
        case MainMenuSelectionPatients:
            [self.navigationItem setTitle:NSLocalizedString(@"list_patient_title", @"")];
            break;
        default:
            break;
    }
      UIImage *addButtonImage = [UIImage systemImageNamed:@"plus.circle"];
      UIBarButtonItem *addBarButton = [[UIBarButtonItem alloc] initWithImage:addButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(didTapAddButton)];
      [self.navigationItem setRightBarButtonItem:addBarButton];
}

#pragma mark -  Navigation
- (void)didTapAddButton {
    [self instantiateNewViewController:@"addViewController"];
}

//Instantiates and pushes a new view controller based on the storyboard identifier
- (void)instantiateNewViewController:(NSString *)identifier{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:NSBundle.mainBundle];
    UIViewController* vc = [storyboard instantiateViewControllerWithIdentifier:identifier]; //Casts the initiated vc to the class it should be in
    [(ITS_AddViewController *)vc setAddTypeSelection:self.mainMenuSelection];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.objectArray count];
    //return [self.objectArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"patientListCell";
    NSString *nibID = @"ITS_PatientListCollectionViewCell";
    UINib *nib = [UINib nibWithNibName:nibID bundle:NSBundle.mainBundle];
    [self.listCollectionView registerNib:nib forCellWithReuseIdentifier:cellID];
    ITS_PatientListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    [cell fillCellWithPatient:[self.objectArray objectAtIndex:indexPath.row]];
    return cell;
}

@end
