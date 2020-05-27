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
#import "Diagnostic.h"
#import "ITS_AddTableViewCell.h"
#import "ITS_HeaderViewTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN
@protocol DiagnosticViewControllerDelegate;
@interface ITS_DiagnosticViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,DiagnosticViewModelDelegate,AttachmentComponentDelegate>
@property (nonatomic) ITS_DiagnosticViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *fieldsTableView;
@property (nonatomic, weak) id<DiagnosticViewControllerDelegate> delegate;
@end

@protocol DiagnosticViewControllerDelegate <NSObject>

- (void)diagnosticViewController:(ITS_DiagnosticViewController*)viewController
             didFinishDiagnostic:(Diagnostic*)diagnostic;

@end

NS_ASSUME_NONNULL_END
