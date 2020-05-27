//
//  ITS_DiagnosticComponent.h
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 22/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//


#import "ITS_BaseTextFieldComponent.h"
#import "ITS_Colors.h"
#import "ITS_Enums.h"
#import "Diagnostic.h"
#import "ITS_DiagnosticViewController.h"


NS_ASSUME_NONNULL_BEGIN
@protocol DiagnosticComponentDelegate;
@interface ITS_DiagnosticComponent : ITS_BaseTextFieldComponent<DiagnosticViewControllerDelegate,UITableViewDelegate,SearchTableViewCellDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *view;
- (void)initWithTitle:(NSString *)title andFrame:(CGRect)frame;
@property (nonatomic, weak) id<DiagnosticComponentDelegate> delegate;
@end

@protocol DiagnosticComponentDelegate <NSObject>
- (void)diagnosticComponentDidTapAddDiagnostic:(ITS_DiagnosticComponent*)diagnosticComponent withDiagnosticViewController:(ITS_DiagnosticViewController*)diagnosticViewController;
@end

NS_ASSUME_NONNULL_END
