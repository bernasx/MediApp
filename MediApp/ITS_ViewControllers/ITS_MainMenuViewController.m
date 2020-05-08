//
//  ITS_MainMenuViewController.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 06/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_MainMenuViewController.h"

@interface ITS_MainMenuViewController ()
@property (nonatomic) MainMenuSelection mainMenuSelection;
@end

@implementation ITS_MainMenuViewController
#pragma mark - IBActions

- (IBAction)onShowAll:(id)sender {
    //decide where to go
    switch (self.mainMenuSelection) {
        case MainMenuSelectionMedicalAppointment:
            //go to medicalappointments (consultas)
            break;
        case MainMenuSelectionPatients:
            //go to patients
            break;
        case MainMenuSelectionAppointments:
            //go to appointments(agendamentos)
            break;
        case MainMenuSelectionMedics:
            [self instantiateNewViewController:@"medicsListViewController"];
            break;
        default:
            break;
    }
}

#pragma mark -  Initial Setup
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",[[FIRAuth auth] currentUser].email);
    [self designViewElements];
}

//Designs the view's elements and components with the proper characteristics
- (void)designViewElements {
    //design top view that hides behind the collection view
    [self.topSectionView setBackgroundColor:[ITS_Colors secondaryColor]];
    [self.topSectionView setClipsToBounds:YES];
    [self.topSectionView.layer setCornerRadius:20];
    [self.topSectionView.layer setMaskedCorners:kCALayerMaxXMaxYCorner | kCALayerMinXMaxYCorner];
    
    //navbar design and setting the menu button design/action
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationItem setTitle:@"Menu"];
    UIImage *menuButtonImage = [UIImage imageNamed:@"menu-25"];
    UIBarButtonItem *menuBarButton = [[UIBarButtonItem alloc] initWithImage:menuButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(didTapMenuButton)];
    [self.navigationItem setRightBarButtonItem:menuBarButton];
    
    //show all button
    [self.showAllButton setTintColor:[ITS_Colors smallButtonAndTitleColor]];
}

- (void)viewWillAppear:(BOOL)animated {
    //must be set here due to this view specifically changing its navBar color. If we press back to menu we want to be able to reapply the color
    [self.navigationController.navigationBar setBarTintColor:[ITS_Colors secondaryColor]];
}

#pragma mark - Navigation

- (void)didTapMenuButton {
    //code for displaying a sidemenu
}

- (void)viewWillDisappear:(BOOL)animated {
    //make the navbar look normal again
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
}

//Instantiates and pushes a new view controller based on the storyboard identifier
- (void)instantiateNewViewController:(NSString *)identifier{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:NSBundle.mainBundle];
    UIViewController* vc = [storyboard instantiateViewControllerWithIdentifier:identifier]; //Casts the initiated vc to the class it should be in
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Data and Status

- (void)updateViewWithCurrentSelection {
    //Code for updating the view, calling everything appropriately
}

#pragma mark - UICollectionView Delegate and Data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.menuSelectionCollectionView itemCount];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"mainMenuSelectionCell";
    NSString *nibID = @"ITS_MainMenuSelectionCollectionViewCell";
    UINib *nib = [UINib nibWithNibName:nibID bundle:NSBundle.mainBundle];
    [self.menuSelectionCollectionView registerNib:nib forCellWithReuseIdentifier:cellID];
    ITS_MainMenuSelectionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    [cell setImage:[self.menuSelectionCollectionView imageAtIndex:indexPath.row]];
    [cell setTitle:[self.menuSelectionCollectionView titleAtIndex:indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            self.mainMenuSelection = MainMenuSelectionMedicalAppointment;
            break;
        case 1:
            self.mainMenuSelection = MainMenuSelectionPatients;
            break;
        case 2:
            self.mainMenuSelection = MainMenuSelectionAppointments;
            break;
        case 3:
            self.mainMenuSelection = MainMenuSelectionMedics;
            break;
        default:
            break;
    }
    [self updateViewWithCurrentSelection];
}
@end
