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
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;
@property (weak, nonatomic) IBOutlet UITableView *currentDiagnosticsTableView;
@property (nonatomic) NSMutableArray<Diagnostic *>* diagnosticArray;
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
    [self updateComponentStatus:UITextFieldStatusNormal withWarningMessage:@""];
    id<DiagnosticComponentDelegate> strongDelegate = self.delegate;
    ITS_DiagnosticViewController *diagnosticVC = [[ITS_DiagnosticViewController alloc] init];
    diagnosticVC.delegate = self;
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
    [self.warningLabel setHidden:YES];
    [self.addButton setTintColor:[ITS_Colors secondaryColor]];
    self.diagnosticArray = [NSMutableArray new];
   
}

#pragma mark - Public Functions

- (id)getObjectData {
    return self.diagnosticArray;
}

- (CGFloat)getDefaultComponentHeight {
    return 150;
}

- (void)diagnosticViewController:(ITS_DiagnosticViewController *)viewController didFinishDiagnostic:(Diagnostic *)diagnostic{
    
    [self.diagnosticArray addObject:diagnostic];
    [self.currentDiagnosticsTableView reloadData];
}

#pragma mark - design
//updates the status. Status means the coloring of the border and the label display.
- (void)updateComponentStatus:(TextFieldStatus)textFieldStatus withWarningMessage:(NSString *) warningMessage {
    
    switch (textFieldStatus) {
        case UITextFieldStatusNormal:
            [self.warningLabel setText:@""];
            [self.warningLabel setHidden:YES];
            [self.warningLabel setTextColor:[ITS_Colors smallTextColor]];
            break;
        case UITextFieldStatusWarning:
            [self.warningLabel setText:warningMessage];
            [self.warningLabel setHidden:NO];
            [self.warningLabel setTextColor:[ITS_Colors warningColor]];
            break;
        default:
            break;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
      return [self.diagnosticArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"searchTableViewCell";
    NSString *nibID = @"ITS_SearchTableViewCell";
    [self.currentDiagnosticsTableView registerNib:[UINib nibWithNibName:nibID bundle:nil] forCellReuseIdentifier:cellID];
    ITS_SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    [cell removeButtonIsHidden:NO];
    Diagnostic *diagnostic = [self.diagnosticArray objectAtIndex:indexPath.row];
    [cell setDiagnostic:diagnostic];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.delegate = self;
    return cell;
}

- (void)cellRemoval:(ITS_SearchTableViewCell *)cell didRemoveObject:(id)object {
    [self.diagnosticArray removeObject:object];
    [self.currentDiagnosticsTableView reloadData];
}


@end
