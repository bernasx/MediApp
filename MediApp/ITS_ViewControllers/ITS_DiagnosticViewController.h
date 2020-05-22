//
//  ITS_DiagnosticViewController.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 22/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITS_DiagnosticViewModel.h"
#import "ITS_Enums.h"
#import "ITS_AddTableViewCell.h"
#import "ITS_HeaderViewTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface ITS_DiagnosticViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,DiagnosticViewModelDelegate>
@property (nonatomic) ITS_DiagnosticViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *fieldsTableView;
@end

NS_ASSUME_NONNULL_END
