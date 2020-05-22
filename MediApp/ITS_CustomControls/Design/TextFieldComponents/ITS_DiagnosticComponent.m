//
//  ITS_DiagnosticComponent.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 22/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_DiagnosticComponent.h"
@interface ITS_DiagnosticComponent()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel; //temporary maybe
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end
@implementation ITS_DiagnosticComponent

#pragma mark - Inits

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self buildFrame];
    }
    return self;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self buildFrame];
    }
    return self;
}
//adds the view to the superview with a clear background
- (void)buildFrame {
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    [self addSubview:self.view];
    [self.view.superview setBackgroundColor:[UIColor clearColor]];
}


- (IBAction)onAdd:(id)sender {
    id<DiagnosticComponentDelegate> strongDelegate = self.delegate;
    ITS_DiagnosticViewController *diagnosticVC = [[ITS_DiagnosticViewController alloc] init];
    if ([strongDelegate respondsToSelector:@selector(diagnosticComponentDidTapAddDiagnostic:withDiagnosticViewController:)]) {
        [strongDelegate diagnosticComponentDidTapAddDiagnostic:self withDiagnosticViewController:diagnosticVC];
    }
}


//init the object with a type and find out how to set it up. Frame will set up the view properly to fit the one in Storyboard
- (void)initWithTitle:(NSString *)title andFrame:(CGRect)frame {
    self.frame = frame;
    self.view.frame = frame;
    [self.titleLabel setText:title]; //all of them have a similar title
    [self.titleLabel setTextColor:[ITS_Colors smallButtonAndTitleColor]];
   
}

#pragma mark - Public Functions

- (id)getObjectData {
    return @"TODO";
}

- (CGFloat)getDefaultComponentHeight {
    return 110;
}

@end
