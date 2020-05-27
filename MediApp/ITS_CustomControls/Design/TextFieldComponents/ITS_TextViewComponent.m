//
//  ITS_TextViewComponent.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 22/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_TextViewComponent.h"
@interface ITS_TextViewComponent()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;
@property (weak, nonatomic) IBOutlet UITextField *titleTextfield;
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;
@property (weak, nonatomic) IBOutlet UITextView *componentTextView;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;
@property (nonatomic) NSMutableArray *objectArray;
@end
@implementation ITS_TextViewComponent
- (IBAction)didTapAddButton:(id)sender {
    if ([self.titleTextfield hasText]) {
        Note *note = [Note new];
        NSUUID* uid = [NSUUID UUID];
        note.uid = uid.UUIDString;
        note.noteText = [self.componentTextView text];
        note.noteTitle = [self.titleTextfield text];
        [self.objectArray addObject:note];
    } else {
        [self updateComponentStatus:UITextFieldStatusWarning withWarningMessage:@"Por favor insira um titulo!"];
    }
    [self.listTableView reloadData];
    
}
- (IBAction)didTapClearButton:(id)sender {
    [self.componentTextView setText:@""];
    [self.titleTextfield setText:@""];
}

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

//init the object with a type and find out how to set it up. Frame will set up the view properly to fit the one in Storyboard
- (void)initWithTitle:(NSString *)title andFrame:(CGRect)frame {
    self.frame = frame;
    self.view.frame = frame;
    self.objectArray = [NSMutableArray new];
    [self.titleLabel setText:title]; //all of them have a similar title
    [self.titleLabel setTextColor:[ITS_Colors smallButtonAndTitleColor]];
    [self.componentTextView.layer setBorderWidth:1];
    [self.componentTextView.layer setBorderColor:[[ITS_Colors smallTextColor]CGColor]];
    [self.componentTextView.layer setCornerRadius:10];
    [self.addButton setTintColor:[ITS_Colors secondaryColor]];
    [self.clearButton setTintColor:[ITS_Colors secondaryColor]];
    [self.warningLabel setTextColor:[ITS_Colors warningColor]];
}

#pragma mark - design
//updates the status. Status means the coloring of the border and the label display.
- (void)updateComponentStatus:(TextFieldStatus)textFieldStatus withWarningMessage:(NSString *) warningMessage {
    switch (textFieldStatus) {
        case UITextFieldStatusNormal:
            [self.warningLabel setText:@""];
            [self.warningLabel setHidden:YES];
            [self changeTextViewDesignWithColor:[ITS_Colors smallTextColor]];
            break;
        case UITextFieldStatusWarning:
            [self.warningLabel setText:warningMessage];
            [self.warningLabel setHidden:NO];
            [self changeTextViewDesignWithColor:[ITS_Colors warningColor]];
            break;
        default:
            break;
    }
    
}

- (void)changeTextViewDesignWithColor: (UIColor *) color{
    self.titleTextfield.layer.masksToBounds=YES;
    self.titleTextfield.layer.borderColor = [color CGColor];
    self.titleTextfield.layer.borderWidth= 1.0f;
    self.titleTextfield.layer.cornerRadius = 8;
}


#pragma mark - Public Functions

- (id)getObjectData {
    return self.objectArray;
}

- (CGFloat)getDefaultComponentHeight {
    return 400;
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
      return [self.objectArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"searchTableViewCell";
    NSString *nibID = @"ITS_SearchTableViewCell";
    [self.listTableView registerNib:[UINib nibWithNibName:nibID bundle:nil] forCellReuseIdentifier:cellID];
    ITS_SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    [cell removeButtonIsHidden:NO];
    Note *note = [self.objectArray objectAtIndex:indexPath.row];
    [cell setNote:note];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.delegate = self;
    return cell;
}

- (void)cellRemoval:(ITS_SearchTableViewCell *)cell didRemoveObject:(id)object {
    [self.objectArray removeObject:object];
    [self.listTableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Note* note = [self.objectArray objectAtIndex:indexPath.row];
    [self.componentTextView setText:note.noteText];
    [self.titleTextfield setText:note.noteTitle];
}

#pragma mark - Textfield Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self updateComponentStatus:UITextFieldStatusNormal withWarningMessage:@""];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self updateComponentStatus:UITextFieldStatusNormal withWarningMessage:@""];
}
@end
