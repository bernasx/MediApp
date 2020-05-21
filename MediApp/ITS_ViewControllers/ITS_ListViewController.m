//
//  ITS_ListViewController.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 21/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_ListViewController.h"

@interface ITS_ListViewController ()

@end

@implementation ITS_ListViewController

#pragma mark -  Initial Setup
- (void)viewDidLoad {
    [super viewDidLoad];
    [self designViewElements];
}

- (void)designViewElements {    
    //designing for each type
    switch (self.mainMenuSelection) {
        case MainMenuSelectionMedics:
            [self.navigationItem setTitle:@"Médicos"];
            break;
        case MainMenuSelectionPatients:
            [self.navigationItem setTitle:@"Pacientes"];
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

@end
