//
//  ITS_CarroselCollectionView.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 08/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_CarroselCollectionView.h"
@interface ITS_CarroselCollectionView()
@property (nonatomic) NSMutableArray* selectionImages;
@property (nonatomic) NSMutableArray* selectionTitles;
@end
@implementation ITS_CarroselCollectionView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setUpArrays];
        
        //selection collectionview layout
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(128, 128);
        [layout setSectionInset:UIEdgeInsetsMake(5, 10, 5, 10)];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 40;
        layout.minimumInteritemSpacing = 40;
        self.collectionViewLayout = layout;
    }
    return self;
}

//fill up the arrays for designing the main menu
- (void)setUpArrays {    
    self.selectionImages = [[NSMutableArray alloc] init];
    self.selectionTitles = [[NSMutableArray alloc] init];
    [self fillSelectionArraysWithSingleImageName:@"calendar" andTitle:NSLocalizedString(@"main_menu_medical_appointments", @"")];
    [self fillSelectionArraysWithSingleImageName:@"person.2.fill" andTitle:NSLocalizedString(@"main_menu_patients", @"")];
    [self fillSelectionArraysWithSingleImageName:@"calendar.badge.plus" andTitle:NSLocalizedString(@"main_menu_appointments", @"")];
    [self fillSelectionArraysWithSingleImageName:@"person.3.fill" andTitle:NSLocalizedString(@"main_menu_medics", @"")];
}


//fills the selection arrays used to draw the selection collectionview with given name for an image and title for a labels
- (void)fillSelectionArraysWithSingleImageName:(NSString*)imageName andTitle:(NSString*)title {
    [self.selectionImages addObject:[UIImage systemImageNamed:imageName]];
    [self.selectionTitles addObject:title];
}

- (NSInteger)itemCount {
    return self.selectionImages.count;
}

- (UIImage *)imageAtIndex:(NSInteger)index {
    return [self.selectionImages objectAtIndex:index];
}

- (NSString *)titleAtIndex:(NSInteger)index {
    return [self.selectionTitles objectAtIndex:index];
}

@end
