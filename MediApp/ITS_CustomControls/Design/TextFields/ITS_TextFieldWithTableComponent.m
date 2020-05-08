//
//  ITS_TextFieldWithTableComponent.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 07/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_TextFieldWithTableComponent.h"
@interface ITS_TextFieldWithTableComponent()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;
@property (weak, nonatomic) IBOutlet UITableView *textCompletionTableView;
@property (weak, nonatomic) IBOutlet UITableView *selectedSpecialtiesTableView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (nonatomic) NSMutableArray *objectArray; //holds the selected items
@property (nonatomic) NSMutableArray *displayArray; //holds the item to display
@property (nonatomic) NSArray *firebaseArray;//holds the items from firebase, cannot ever change

@property (nonatomic) TextFieldType textFieldType;
@property (nonatomic) SearchType searchType;
@property (nonatomic) TextFieldStatus textFieldStatus;
@end

@implementation ITS_TextFieldWithTableComponent

- (IBAction)didAddSpecialty:(id)sender {
    //go through each specialty in the original array, add to the object array the valid ones that match the textfield
    for (Specialty * specialty in self.firebaseArray) {
        if ([specialty.specialtyName.lowercaseString isEqualToString:self.textfield.text.lowercaseString]) {
            [self.objectArray addObject:specialty];
        }
    }
    [self.selectedSpecialtiesTableView reloadData];
    [self.textfield setText:@""];
    [self displayEverythingInAutoComplete];
}

#pragma mark - Inits
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
        [self addSubview:self.view];
        [self.view.superview setBackgroundColor:[UIColor clearColor]];
    }
    return self;
    
}

//init the object with a type and find out how to set it up. Frame will set up the view properly to fit the one in Storyboard
- (void)initWithTitle:(NSString *)title andType:(TextFieldType)textfieldType andSearchType:(SearchType)searchType andFrame:(CGRect)frame andArray:(NSArray *)array {
    self.view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    [self.titleLabel setText:title]; //all of them have a similar title
    [self.titleLabel setTextColor:[ITS_Colors smallButtonAndTitleColor]];
    [self.warningLabel setHidden:YES]; //all warning labels should be hidden by default
    [self.warningLabel setTextColor:[ITS_Colors warningColor]];
    [self.textfield setTintColor:[ITS_Colors smallTextColor]]; //makes all icons the same color
    [self changeTextViewDesignWithColor:[ITS_Colors smallTextColor]]; //setup the textfield with whatever color we wish
    [self.addButton setTintColor:[ITS_Colors smallButtonAndTitleColor]];
    //initialize the two arrays
    self.objectArray = [[NSMutableArray alloc] init];
    self.displayArray = [[NSMutableArray alloc] init];
    //delegates
    self.textfield.delegate = self;
    self.selectedSpecialtiesTableView.delegate = self;
    self.selectedSpecialtiesTableView.dataSource = self;
    self.textCompletionTableView.delegate = self;
    self.textCompletionTableView.dataSource = self;
    //set the default array
    self.firebaseArray = array;
    //set the display one to the default, because at first the list displays everything
    self.displayArray = [NSMutableArray arrayWithArray:array];
    
    //make the textfield editing change
    [self.textfield addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    
    [self updateComponentType:textfieldType andSearchType:searchType];
    
    //Reload the data to display
    [self.textCompletionTableView reloadData];
    [self.selectedSpecialtiesTableView reloadData];
}

#pragma mark - View Design

//updates the componentType to allow
- (void)updateComponentType:(TextFieldType)textfieldType andSearchType:(SearchType)searchType {
    self.textFieldType = textfieldType;
    self.searchType = searchType;
    [self.textfield setSecureTextEntry:NO]; //if we change the type of text field, make sure it doesn't stay as securetext
    //update view
    switch (textfieldType) {
        case UITextFieldDefault:
            break;
        case UITextFieldSearch:
            [self setupWithLeftView:nil andRightView:[UIImage systemImageNamed:@"magnifyingglass"]];
            break;
        default:
            break;
    }
}

//updates the status. Status means the coloring of the border and the label display.
- (void)updateComponentStatus:(TextFieldStatus)textFieldStatus withWarningMessage:(NSString *)warningMessage {
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

//Sets the images for the left and right views of the textfield. Pass a nil value to not put anything.
//Left view is always an image, right view is always a button.
- (void)setupWithLeftView:(UIImage *)leftImage andRightView:(UIImage *) rightImage{
    if(leftImage) {
        self.textfield.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 22, 22)];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        [imageView setImage:leftImage];
        UIView *container = [[UIView alloc] initWithFrame:imageView.frame];
        [container addSubview:imageView];
        [self.textfield setLeftView:container];
    }
    if(rightImage) {
        self.textfield.rightViewMode = UITextFieldViewModeAlways;
        UIButton * rightViewButton = [[UIButton alloc] initWithFrame:CGRectMake(-5, 0, 32, 32)];
        [rightViewButton setImage:rightImage forState:UIControlStateNormal];
        UIView *container = [[UIView alloc] initWithFrame:rightViewButton.frame];
        [container addSubview:rightViewButton];
        [self.textfield setRightView:container];
    }
}

- (void)changeTextViewDesignWithColor: (UIColor *) color{
    self.textfield.layer.masksToBounds=YES;
    self.textfield.layer.borderColor = [color CGColor];
    self.textfield.layer.borderWidth= 1.0f;
    self.textfield.layer.cornerRadius = 8;
}

#pragma mark - Public Functions
- (bool)textfieldHasText {
    return self.textfield.hasText;
}

- (NSInteger)textfieldSize {
    return self.textfield.text.length;
}

- (NSString *)textfieldText {
    return self.textfield.text;
}

#pragma mark - UITextfield Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self updateComponentStatus:UITextFieldStatusNormal withWarningMessage:@""];
}

//Called when textfield changes
- (void)textFieldDidChange {
    self.displayArray = [[NSMutableArray alloc] init]; //erase the old array
    if ([self textfieldHasText]) {
        switch (self.searchType) {
            case SearchSpecialty:
                //go through each specialty in the original array, add to the display array the valid ones that match the textfield
                for (Specialty * specialty in self.firebaseArray) {
                    if ([specialty.specialtyName.lowercaseString containsString:self.textfield.text.lowercaseString]) {
                        [self.displayArray addObject:specialty];
                    }
                }
                [self.textCompletionTableView reloadData];
                break;
            case SearchDisease:
                // same as above but for disease
                break;
                
            default:
                break;
        }
    } else {
       //if it doesn't have text, display the whole thing
        [self displayEverythingInAutoComplete];
    }
}

- (void)displayEverythingInAutoComplete {
    self.displayArray = [NSMutableArray arrayWithArray:self.firebaseArray];
    [self.textCompletionTableView reloadData];
    
}

#pragma mark - UITableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 0) {
        //is the autocompletion tableview
        return [self.displayArray count];
    } else {
        //is the tableview with currently selected specialties
        return [self.objectArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"searchTableViewCell";
    NSString *nibID = @"ITS_SearchTableViewCell";
    if (tableView.tag == 0) {
        //is the autocompletion tableview
        [self.textCompletionTableView registerNib:[UINib nibWithNibName:nibID bundle:nil] forCellReuseIdentifier:cellID];
        return [self setUpCellWithID:cellID andTableView:tableView withRemoveButtonHidden:YES withObject:[self.displayArray objectAtIndex:indexPath.row]];
    } else {
        //is the tableview with currently selected specialties
        [self.selectedSpecialtiesTableView registerNib:[UINib nibWithNibName:nibID bundle:nil] forCellReuseIdentifier:cellID];
        ITS_SearchTableViewCell *cell = [self setUpCellWithID:cellID andTableView:tableView withRemoveButtonHidden:NO withObject:[self.objectArray objectAtIndex:indexPath.row]];
        [cell setTitleLabelColor:[ITS_Colors primaryColor]];
        return cell;
    }
    
}

//returns a cell that is set up depending on the content it should take. 
- (ITS_SearchTableViewCell *)setUpCellWithID:(NSString*)cellID andTableView:(UITableView *)tableView withRemoveButtonHidden:(bool)removeButtonHidden withObject:(id) object{
    ITS_SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    switch (self.searchType) {
        case SearchSpecialty:
            [cell setSpecialty:object];
            [cell removeButtonIsHidden:removeButtonHidden];
            break;
        case SearchDisease:
            [cell setDisease:object];
            [cell removeButtonIsHidden:removeButtonHidden];
            break;
        default:
            break;
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone]; //don't want any selection
    cell.delegate = self; //make us the delegate so we can react to deleting something
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.searchType) {
        case SearchSpecialty:{
            Specialty* specialty = [self.displayArray objectAtIndex:indexPath.row];
            [self.textfield setText:specialty.specialtyName];
             break;
        }
        case SearchDisease:{
            Disease* disease = [self.displayArray objectAtIndex:indexPath.row];
            [self.textfield setText:disease.diseaseName];
            break;
        }
        default:
            break;
    }
}
//delegate that lets us remove the cell we want from the specialty tableview
- (void)cellRemoval:(ITS_SearchTableViewCell *)cell didRemoveObject:(id)object {
    [self.objectArray removeObject:object];
    [self.selectedSpecialtiesTableView reloadData];
}
@end
