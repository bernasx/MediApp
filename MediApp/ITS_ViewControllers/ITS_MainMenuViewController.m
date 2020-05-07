//
//  ITS_MainMenuViewController.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 06/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_MainMenuViewController.h"

@interface ITS_MainMenuViewController ()
@property (nonatomic) NSMutableArray* selectionImages;
@property (nonatomic) NSMutableArray* selectionTitles;
@end

@implementation ITS_MainMenuViewController

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
    [self.navigationController.navigationBar setBarTintColor:[ITS_Colors secondaryColor]];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationItem setTitle:@"Menu"];
    UIImage *menuButtonImage = [UIImage imageNamed:@"menu-25"];
    UIBarButtonItem *menuBarButton = [[UIBarButtonItem alloc] initWithImage:menuButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(didTapMenuButton)];
    [self.navigationItem setRightBarButtonItem:menuBarButton];
    
    //fill up the arrays for designing the main menu
    self.selectionImages = [[NSMutableArray alloc] init];
    self.selectionTitles = [[NSMutableArray alloc] init];
    [self fillSelectionArraysWithSingleImageName:@"calendar" andTitle:@"As minhas consultas"];
    [self fillSelectionArraysWithSingleImageName:@"person.2.fill" andTitle:@"Os meus pacientes"];
    [self fillSelectionArraysWithSingleImageName:@"calendar.badge.plus" andTitle:@"Os meus agendamentos"];
    [self fillSelectionArraysWithSingleImageName:@"person.3.fill" andTitle:@"Os meus médicos"];
    
    //selection collectionview layout
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(128, 128);
    [layout setSectionInset:UIEdgeInsetsMake(5, 10, 5, 10)];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 40;
    layout.minimumInteritemSpacing = 40;
    self.menuSelectionCollectionView.collectionViewLayout = layout;
    
    [self.menuSelectionCollectionView reloadData];
}

//fills the selection arrays used to draw the selection collectionview with given name for an image and title for a labels
- (void)fillSelectionArraysWithSingleImageName:(NSString*)imageName andTitle:(NSString*)title {
    [self.selectionImages addObject:[UIImage systemImageNamed:imageName]];
    [self.selectionTitles addObject:title];
}

#pragma mark - Navigation

- (void)didTapMenuButton {
    //code for displaying a sidemenu
}

- (void)viewWillDisappear:(BOOL)animated {
    //make the navbar look normal again
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
}

#pragma mark - UICollectionView Delegate and Data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.selectionTitles count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"mainMenuSelectionCell";
    NSString *nibID = @"ITS_MainMenuSelectionCollectionViewCell";
    UINib *nib = [UINib nibWithNibName:nibID bundle:NSBundle.mainBundle];
    [self.menuSelectionCollectionView registerNib:nib forCellWithReuseIdentifier:cellID];
    ITS_MainMenuSelectionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    [cell setImage:[self.selectionImages objectAtIndex:indexPath.row]];
    [cell setTitle:[self.selectionTitles objectAtIndex:indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}
@end
