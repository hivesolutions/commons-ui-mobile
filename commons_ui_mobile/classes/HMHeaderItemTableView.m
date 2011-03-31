// Hive Mobile
// Copyright (C) 2008 Hive Solutions Lda.
//
// This file is part of Hive Mobile.
//
// Hive Mobile is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Hive Mobile is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Hive Mobile. If not, see <http://www.gnu.org/licenses/>.

// __author__    = João Magalhães <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision: 2390 $
// __date__      = $LastChangedDate: 2009-04-02 08:36:50 +0100 (qui, 02 Abr 2009) $
// __copyright__ = Copyright (c) 2008 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "HMHeaderItemTableView.h"

@implementation HMHeaderItemTableView

@synthesize normalHeaderView = _normalHeaderView;
@synthesize editHeaderView = _editHeaderView;
@synthesize titleLabel = _titleLabel;
@synthesize subTitleLabel = _subTitleLabel;
@synthesize imageImage = _imageImage;
@synthesize imageAddButton = _imageAddButton;
@synthesize titleTableViewCell = _titleTableViewCell;
@synthesize subTitleTableViewCell = _subTitleTableViewCell;
@synthesize headerTableView = _headerTableView;

- (id)init {
    // calls the super
    self = [super init];

    // constructs the view
    [self constructView];

    // returns self
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    // calls the super
    self = [super initWithCoder:aDecoder];

    // constructs the view
    [self constructView];

    // returns self
    return self;
}

- (void)dealloc {
    // releases the title
    [_title release];

    // releases the sub title
    [_subTitle release];

    // releases the image
    [_image release];

    // calls the super
    [super dealloc];
}

- (void)constructView {
    // constructs the "normal" view
    [self constructNormalView];

    // constructs the "edit" view
    [self constructEditView];
}

- (void)constructNormalView {
    // initializes the position deltas
    float deltaX = 0;
    float deltaY = 0;

    // retrieves the screen width
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGFloat screenWidth = screenRect.size.width;

    // retrieves the current device model
    UIDevice *currentDevice = [UIDevice currentDevice];
    NSString *currentDeviceModel = [currentDevice model];

    // adjusts the delta in case the device is an ipad
    if([currentDeviceModel hasPrefix:@"iPad"]) {
        deltaX = -38;
        deltaY = -20;
    }

    // creates the header
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 82)];
    header.contentMode = UIViewContentModeScaleToFill;
    header.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    header.backgroundColor = [UIColor redColor];

    // creates the header container
    UIView *headerContainer = [[UIView alloc] initWithFrame:CGRectMake(20 - deltaX, 0, screenWidth - 20 + deltaX, 82)];
    headerContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
    headerContainer.backgroundColor = [UIColor greenColor];

    // creates the image frame
    CGRect imageFrame = CGRectMake(0, 15, 64, 64);

    // creates the image view
    UIImageView *image = [[HMRoundedCornerImageView alloc] initWithFrame:imageFrame];

    // creates the title label frame
    CGRect titleLabelFrame = CGRectMake(83, 34, 197, 24);

    // creates the title label view
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleLabelFrame];
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    titleLabel.shadowColor = [UIColor whiteColor];
    titleLabel.shadowOffset = CGSizeMake(0, 1);

    // creates the subtitle label frame
    CGRect subTitleLabelFrame = CGRectMake(83, 45, 197, 24);

    // creates the subtitle label view
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:subTitleLabelFrame];
    subTitleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
    subTitleLabel.backgroundColor = [UIColor clearColor];
    subTitleLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
    subTitleLabel.shadowColor = [UIColor whiteColor];
    subTitleLabel.shadowOffset = CGSizeMake(0, 1);

    // adds the sub views
    [headerContainer addSubview:image];
    [headerContainer addSubview:titleLabel];
    [headerContainer addSubview:subTitleLabel];
    [header addSubview:headerContainer];

    // sets the table header
    self.tableHeaderView = header;

    // sets the "normal" header view
    self.normalHeaderView = header;

    // sets the attributes
    self.titleLabel = titleLabel;
    self.subTitleLabel = subTitleLabel;
    self.imageImage = image;

    // releases the objects
    [titleLabel release];
    [subTitleLabel release];
    [image release];
    [headerContainer release];
    [header release];
}

- (void)constructEditView {
    // initializes the position deltas
    float deltaX = 0;
    float deltaY = 0;
    float headerTableViewMarginX = 94;

    // retrieves the screen width
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGFloat screenWidth = screenRect.size.width;

    // retrieves the current device model
    UIDevice *currentDevice = [UIDevice currentDevice];
    NSString *currentDeviceModel = [currentDevice model];

    // adjusts the delta in case the device is an ipad
    if([currentDeviceModel hasPrefix:@"iPad"] ) {
        deltaX = -31;
        deltaY = -20;
        headerTableViewMarginX = 98;
    }

    // creates the header
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 110)];
    header.contentMode = UIViewContentModeScaleToFill;
    header.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    header.backgroundColor = [UIColor redColor];
    header.layer.opacity = 0.0;

    // creates the header container
    UIView *headerContainer = [[UIView alloc] initWithFrame:CGRectMake(20 - deltaX, 0, screenWidth - 20 + deltaX, 110)];
    headerContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
    headerContainer.backgroundColor = [UIColor greenColor];

    // creates the image frame
    CGRect imageFrame = CGRectMake(0, 15, 64, 64);

    // creates the add image button view
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];

    [addButton addTarget:self action:@selector(addPhotoButtonClicked:extra:) forControlEvents:UIControlEventTouchUpInside];

    // sets the button frame
    addButton.frame = imageFrame;

    // sets the button properties
    [addButton setTitle:NSLocalizedString(@"add photo", @"add photo") forState:UIControlStateNormal];

    // sets the button title label properties
    addButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    addButton.titleLabel.numberOfLines = 2;
    addButton.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    addButton.titleLabel.textAlignment = UITextAlignmentCenter;

    // creates the images for the button backgrounds
    UIImage *buttonBackground = [UIImage imageNamed:@"white_button.png"];
    UIImage *buttonBackgroundPressed = [UIImage imageNamed:@"white_button_pressed.png"];

    // creates the button background image for the normal state
    UIImage *newImage = [buttonBackground stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];

    // creates the button background image for the pressed state
    UIImage *newPressedImage = [buttonBackgroundPressed stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];

    // sets the background images to the button
    [addButton setBackgroundImage:newImage forState:UIControlStateNormal];
    [addButton setBackgroundImage:newPressedImage forState:UIControlStateHighlighted];

    // creates the header table view
    HMTableView *headerTableView = [[HMItemTableView alloc] initWithFrame:CGRectMake(74 + deltaX, 5 + deltaY, screenWidth - headerTableViewMarginX, 120) style:UITableViewStyleGrouped];
    headerTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
    headerTableView.backgroundColor = [UIColor clearColor];
    headerTableView.dataSource = self;
    headerTableView.editing = YES;
    headerTableView.scrollEnabled = NO;
    headerTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    headerTableView.separatorColor = [UIColor colorWithRed:0.65 green:0.65 blue:0.65 alpha:1.0];
    [headerTableView setBackgroundView: nil];

    // adds the sub views
    [headerContainer addSubview:addButton];
    [headerContainer addSubview:headerTableView];
    [header addSubview:headerContainer];

    // sets the edit header view
    self.editHeaderView = header;

    // sets the attributes
    self.headerTableView = headerTableView;
    self.imageAddButton = addButton;

    // releases the objects
    [headerTableView release];
    [headerContainer release];
    [header release];
}

- (void)addPhotoButtonClicked:(id)sender extra:(id)extra {
    if([self.itemDelegate respondsToSelector:@selector(buttonClicked:)]) {
        // calls the add photo button clicked handler
        [self.itemDelegate buttonClicked:@"addPhoto"];
    }
}

- (NSString *)title {
    return _title;
}

- (void)setTitle:(NSString *)title {
    // in case the object is the same
    if(title == _title) {
        // returns immediately
        return;
    }

    // releases the object
    [_title release];

    // sets and retains the object
    _title = [title retain];

    // updates the title label text
    self.titleLabel.text = _title;

    // sets the title in the table view cell
    self.titleTableViewCell.description = _title;
}

- (NSString *)subTitle {
    return _subTitle;
}

- (void)setSubTitle:(NSString *)subTitle {
    // in case the object is the same
    if(subTitle == _subTitle) {
        // returns immediately
        return;
    }

    // releases the object
    [_subTitle release];

    // sets and retains the object
    _subTitle = [subTitle retain];

    // updates the sub title label text
    self.subTitleLabel.text = _subTitle;

    // sets the subtitle in the table view cell
    self.subTitleTableViewCell.description = _subTitle;

    // positions the title label to give space to the subtitle
    if(_subTitle && [_subTitle length] > 0) {
        self.titleLabel.frame = CGRectMake(83, 24, 197, 24);
    } else {
        self.titleLabel.frame = CGRectMake(83, 34, 197, 24);
    }
}

- (NSString *)image {
    return _image;
}

- (void)setImage:(NSString *)image {
    // in case the object is the same
    if(image == _image) {
        // returns immediately
        return;
    }

    // releases the object
    [_image release];

    // sets and retains the object
    _image = [image retain];

    // creates the image (reference) for the image (path)
    UIImage *imageReference = [UIImage imageNamed:_image];

    // sets the image in the image (view)
    self.imageImage.image = imageReference;
}

- (void)setEditing:(BOOL)editing {
    // calls the super
    [super setEditing:editing];

    // in case it's editing
    if(editing) {
        // shows the editing
        [self showEditing];
    }
    // othewise it's normal
    else {
        // hides the editing
        [self hideEditing];
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animate {
    // calls the super
    [super setEditing:editing animated:animate];

    // in case it's editing
    if(editing) {
        // shows the editing
        [self showEditing];
    }
    // othewise it's normal
    else {
        // hides the editing
        [self hideEditing];
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animate commit:(BOOL)commit {
    // calls the super
    [super setEditing:editing animated:animate commit:commit];

    // changes the cells' editing mode
    [self.titleTableViewCell changeEditing:editing commit:commit];
    [self.subTitleTableViewCell changeEditing:editing commit:commit];

    // in case it's editing
    if(editing) {
        // shows the editing
        [self showEditing];
    }
    // othewise it's normal
    else {
        // hides the editing
        [self hideEditing];
    }
}

- (void)showEditing {
    // updates the title values
    self.title = self.titleLabel.text;
    self.subTitle = self.subTitleLabel.text;

    // changes the cells to edit mode
    [self.titleTableViewCell showEditing];
    [self.subTitleTableViewCell showEditing];

    // fades in the edit header
    [UIView beginAnimations:@"FadeIn" context:nil];
    [UIView setAnimationDuration:0.25];
    self.editHeaderView.layer.opacity = 1.0;
    self.tableHeaderView = self.editHeaderView;
    [UIView commitAnimations];
}

- (void)hideEditing {
    // updates the title values
    self.title = self.titleTableViewCell.description;
    self.subTitle = self.subTitleTableViewCell.description;

    // changes the cells to display mode
    [self.titleTableViewCell hideEditing];
    [self.subTitleTableViewCell hideEditing];

    // fades out the edit header
    [UIView beginAnimations:@"FadeOut" context:nil];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.editHeaderView.layer.opacity = 0.0;
    self.tableHeaderView = self.normalHeaderView;
    [UIView commitAnimations];
}

- (void)redrawHeader {
    // retrieves the header named item group
    HMNamedItemGroup *headerNamedItemGroup = self.itemDataSource.headerNamedItemGroup;

    // retrieves the values from the header named item group
    HMItem *title = [headerNamedItemGroup getItem:@"title"];
    HMItem *subTitle = [headerNamedItemGroup getItem:@"subTitle"];
    HMItem *image = [headerNamedItemGroup getItem:@"image"];

    // sets the attributes
    self.title = title.identifier;
    self.subTitle = subTitle.identifier;
    self.image = image.identifier;
}

- (void)reloadData {
    // calls the super
    [super reloadData];

    // redraws the header
    [self redrawHeader];
}

- (void)flushItemSpecification {
    // calls the super
    [super flushItemSpecification];

    // retrieves the header named item group
    HMNamedItemGroup *headerNamedItemGroup = self.itemDataSource.headerNamedItemGroup;

    // retrieves the items
    HMItem *titleItem = [headerNamedItemGroup getItem:@"title"];
    HMItem *subTitleItem = [headerNamedItemGroup getItem:@"subTitle"];
    HMItem *imageItem = [headerNamedItemGroup getItem:@"image"];

    // sets the attributes
    titleItem.identifier = self.titleTableViewCell.description;
    subTitleItem.identifier = self.subTitleTableViewCell.description;
    imageItem.identifier = self.image;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // creates the cell identifier
    static NSString *cellIdentifier = @"Cell";

    // tries to retrives the cell from cache (reusable)
    HMPlainStringTableViewCell *tableViewCell = (HMPlainStringTableViewCell *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    // in case the cell is not defined in the cuurrent cache
    // need to create a new cell
    if(tableViewCell == nil) {
        tableViewCell = [[HMPlainStringTableViewCell alloc] init];
    }

    // configures the table view cell
    tableViewCell.highlightable = NO;
    tableViewCell.clearable = YES;
    tableViewCell.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];

    // sets each table view cell's value and stores it
    if(indexPath.row == 0) {
        tableViewCell.description = self.title;
        tableViewCell.defaultValue = NSLocalizedString(@"Title", @"Title");
        self.titleTableViewCell = tableViewCell;
    } else {
        tableViewCell.description = self.subTitle;
        tableViewCell.defaultValue = NSLocalizedString(@"Subtitle", @"Subtitle");
        self.subTitleTableViewCell = tableViewCell;
    }

    // returns the cell
    return tableViewCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // returns the number of sections in the header
    return HM_HEADER_ITEM_TABLE_VIEW_HEADER_SECTIONS;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // returns the number of rows in the header
    return HM_HEADER_ITEM_TABLE_VIEW_HEADER_ROWS;
}

@end
