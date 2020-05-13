//
//  ITS_MedicsListViewController.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 07/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_MedicsListViewController.h"

@interface ITS_MedicsListViewController ()

@end

@implementation ITS_MedicsListViewController

#pragma mark -  Initial Setup
- (void)viewDidLoad {
    [super viewDidLoad];
    [self designViewElements];
}

- (void)designViewElements {
      //navbar design and setting the menu button design/action
      [self.navigationItem setTitle:@"Médicos"];
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
    [(ITS_AddViewController *)vc setAddTypeSelection:MainMenuSelectionMedics];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
