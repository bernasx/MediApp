//
//  ITS_ViewController.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 06/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_ViewController.h"

@interface ITS_ViewController ()

@end

@implementation ITS_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self designNavBar];
}

//Designs the style that navbar will have for the entire app
- (void)designNavBar {
    [self.navigationController.navigationBar setTintColor:[ITS_Colors primaryColor]];
    [self.navigationController.navigationBar  setTitleTextAttributes:@{NSForegroundColorAttributeName:[ITS_Colors primaryColor]}];
    [self.navigationController.navigationBar  setLargeTitleTextAttributes:@{NSForegroundColorAttributeName:[ITS_Colors primaryColor]}];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

@end
