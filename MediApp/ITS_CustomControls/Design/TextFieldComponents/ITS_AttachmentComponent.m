//
//  ITS_AttachmentComponent.m
//  MediApp
//
//  Created by Bernardo Miguel Nunes Ribeiro on 15/05/2020.
//  Copyright © 2020 Bernardo Miguel Nunes Ribeiro. All rights reserved.
//

#import "ITS_AttachmentComponent.h"
@interface ITS_AttachmentComponent()
@property (weak, nonatomic) IBOutlet UITableView *attachmentTableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *attachmentButton;
@property (nonatomic) NSMutableArray *attachmentArray;
@property (nonatomic) NSArray *sectionArray;
@property (nonatomic) NSArray *sectionStringsArray;
@property (nonatomic) int currentIndex;
@end
@implementation ITS_AttachmentComponent
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

- (void)attachmentTableViewHeader:(ITS_AttachmentHeaderTableViewCell *)header didTapDocumentsAtIndex:(int)index {
    id<AttachmentComponentDelegate> strongDelegate = self.delegate;
    self.currentIndex = index;
    NSArray *docTypeArray = @[(NSString *)kUTTypePDF,(NSString *)kUTTypePNG,(NSString *)kUTTypeJPEG];
    UIDocumentPickerViewController *docPicker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:docTypeArray inMode:UIDocumentPickerModeImport];
    docPicker.allowsMultipleSelection = YES;
    docPicker.delegate = self;
    
    // Our delegate method is optional, so we should
    // check that the delegate implements it
    if ([strongDelegate respondsToSelector:@selector(attachmentComponentDidTapAddAttachment:withDocumentPicker:)]) {
        [strongDelegate attachmentComponentDidTapAddAttachment:self withDocumentPicker:docPicker];
    }
}

//adds the view to the superview with a clear background
- (void)buildFrame {
    [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    [self addSubview:self.view];
    [self.view.superview setBackgroundColor:[UIColor clearColor]];
}

//init the object with a type and find out how to set it up. Frame will set up the view properly to fit the one in Storyboard
- (void)initWithTitle:(NSString *)title andFrame:(CGRect)frame andSectionArray:(NSArray *)sectionArray andSectionStringsArray:(NSArray *)sectionStringsArray{
    self.frame = frame;
    self.view.frame = frame;
    [self.titleLabel setText:title];
    [self.titleLabel setTextColor:[ITS_Colors smallButtonAndTitleColor]];
    self.attachmentTableView.delegate = self;
    self.attachmentTableView.dataSource = self;
    self.attachmentArray = [[NSMutableArray alloc] init];
    self.sectionStringsArray = sectionStringsArray;
    self.sectionArray = [[NSArray alloc] initWithArray:sectionArray];
    for (int i = 0; i < [self.sectionArray count]; i++) { //add an array for every section
        [self.attachmentArray addObject:[NSMutableArray new]];
    }
    [self.attachmentTableView reloadData];
}


#pragma mark - UITableview Delegate/DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sectionArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
      NSArray *sectionArray = [self.attachmentArray objectAtIndex:section];
      return [sectionArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"searchTableViewCell";
    NSString *nibID = @"ITS_SearchTableViewCell";
    [self.attachmentTableView registerNib:[UINib nibWithNibName:nibID bundle:nil] forCellReuseIdentifier:cellID];
    ITS_SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    [cell removeButtonIsHidden:NO];
    Attachment *attachment = [[self.attachmentArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    [cell setAttachment:attachment];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.delegate = self;
    return cell;
}

//delegate that lets us remove the cell we want from the specialty tableview
- (void)cellRemoval:(ITS_SearchTableViewCell *)cell didRemoveObject:(id)object {
    for (NSMutableArray* array in self.attachmentArray) {
        if ([array containsObject:object]) {
            [array removeObject:object];
            break;
        }
    }
    [self.attachmentTableView reloadData];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *nibID = @"ITS_AttachmentHeaderTableViewCell";
    ITS_AttachmentHeaderTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:nibID owner:self options:nil] firstObject];
    [cell setTitleForSection:[self.sectionArray objectAtIndex:section]];
    [cell setIndex:(int)section];
    cell.delegate = self;
    return cell;
}

#pragma mark - UIDocumentPicker Delegate

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls {
    //NSURL *url = [urls firstObject];
    
    for (NSURL *url in urls) {
        Attachment *attachment = [Attachment new];
        //get the name and file extension and add them together
        NSString *fileName = [NSString stringWithFormat:@"%@.%@",[[url.path lastPathComponent] stringByDeletingPathExtension],[url.path pathExtension]];
        [attachment setAttachmentName:fileName];
        [attachment setAttachmentData:[[NSFileManager defaultManager] contentsAtPath:url.path]];
        [[self.attachmentArray objectAtIndex:self.currentIndex] addObject:attachment];
    }
    [self.attachmentTableView reloadData];
}

#pragma mark - Public Functions
- (id)getObjectData {
    return [self attachmentArray];
}

- (NSArray *)getSections {
    return self.sectionStringsArray;
}

- (CGFloat)getDefaultComponentHeight {
    return 200;
}

- (void)setDefaultValueFromUser:(id)defaultValue {
    _attachmentArray = defaultValue;
    [self.attachmentTableView reloadData];
}
@end
