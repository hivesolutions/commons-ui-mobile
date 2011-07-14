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
@synthesize image = _image;
@synthesize imageAddButton = _imageAddButton;
@synthesize titleTableViewCell = _titleTableViewCell;
@synthesize subTitleTableViewCell = _subTitleTableViewCell;
@synthesize headerTableView = _headerTableView;
@synthesize cellList = _cellList;

- (void)dealloc {
    // releases the fcell list
    [_cellList release];

    // releases the title
    [_title release];

    // releases the sub title
    [_subTitle release];

    // releases the image name
    [_imageName release];

    // releases the image value
    [_imageValue release];

    // calls the super
    [super dealloc];
}

- (void)constructStructures {
    // calls the super
    [super constructStructures];

    // constructs the "normal" view
    [self constructNormalView];

    // constructs the "edit" view
    [self constructEditView];
}

- (void)constructNormalView {
    // initializes the position deltas
    float deltaX = 0;

    // retrieves the screen width
    UIScreen *mainScreen = [UIScreen mainScreen];
    CGRect screenRect = mainScreen.applicationFrame;
    CGFloat screenWidth = screenRect.size.width;

    // retrieves the current device model
    UIDevice *currentDevice = [UIDevice currentDevice];
    NSString *currentDeviceModel = currentDevice.model;
    BOOL iPadDevice = [currentDeviceModel hasPrefix:@"iPad"];

    // adjusts the delta in case the device is an ipad
    if(iPadDevice) {
        deltaX = -38;
    }

    // creates the header
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 82)];
    header.contentMode = UIViewContentModeScaleToFill;
    header.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    header.backgroundColor = [UIColor clearColor];

    // creates the header container
    UIView *headerContainer = [[UIView alloc] initWithFrame:CGRectMake(20 - deltaX, 0, screenWidth - 20 + deltaX, 82)];
    headerContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
    headerContainer.backgroundColor = [UIColor clearColor];

    // creates the image view
    CGRect imageFrame = CGRectMake(0, 15, 64, 64);
    UIImageView *image = [[HMRoundedCornerImageView alloc] initWithFrame:imageFrame];

    // creates the title label view
    CGRect titleLabelFrame = CGRectMake(83, 34, 197, 24);
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleLabelFrame];
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    titleLabel.shadowColor = [UIColor whiteColor];
    titleLabel.shadowOffset = CGSizeMake(0, 1);

    // creates the subtitle label view
    CGRect subTitleLabelFrame = CGRectMake(83, 45, 197, 24);
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
    self.image = image;

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

    // constructs the cell list
    NSMutableArray *cellList = [[NSMutableArray alloc] init];

    // retrieves the screen width
    UIScreen *mainScreen = [UIScreen mainScreen];
    CGRect screenRect = mainScreen.applicationFrame;
    CGFloat screenWidth = screenRect.size.width;

    // retrieves the current device model
    UIDevice *currentDevice = [UIDevice currentDevice];
    NSString *currentDeviceModel = currentDevice.model;

    // adjusts the delta in case the device is an ipad
    if([currentDeviceModel hasPrefix:@"iPad"]) {
        deltaX = -31;
        deltaY = -20;
        headerTableViewMarginX = 98;
    }

    // creates the header
    CGRect headerFrame = CGRectMake(0, 0, screenWidth, 110);
    UIView *header = [[UIView alloc] initWithFrame:headerFrame];
    header.contentMode = UIViewContentModeScaleToFill;
    header.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    header.backgroundColor = [UIColor clearColor];
    header.layer.opacity = 0.0;

    // creates the header container
    CGRect headerContainerFrame = CGRectMake(20 - deltaX, 0, screenWidth - 20 + deltaX, 110);
    UIView *headerContainer = [[UIView alloc] initWithFrame:headerContainerFrame];
    headerContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
    headerContainer.backgroundColor = [UIColor clearColor];

    // creates the add image button view
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];

    // adds the add button touch event
    [addButton addTarget:self action:@selector(addPhotoButtonClicked:extra:) forControlEvents:UIControlEventTouchUpInside];

    // sets the button frame
    CGRect imageFrame = CGRectMake(0, 15, 64, 64);
    addButton.frame = imageFrame;

    // sets the button properties
    [addButton setTitle:NSLocalizedString(@"add photo", @"add photo") forState:UIControlStateNormal];

    // sets the button title label properties
    addButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
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
    CGRect headerTableViewFrame = CGRectMake(74 + deltaX, 5 + deltaY, screenWidth - headerTableViewMarginX, 120);
    HMTableView *headerTableView = [[HMTableView alloc] initWithFrame:headerTableViewFrame style:UITableViewStyleGrouped];
    headerTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
    headerTableView.backgroundColor = [UIColor clearColor];
    headerTableView.dataSource = self;
    headerTableView.editing = NO;
    headerTableView.scrollEnabled = NO;
    headerTableView.separatorStyle = self.separatorStyle;
    headerTableView.separatorColor = self.separatorColor;
    headerTableView.backgroundView = nil;

    // adds the sub views
    [headerContainer addSubview:addButton];
    [headerContainer addSubview:headerTableView];
    [header addSubview:headerContainer];

    // sets the edit header view
    self.editHeaderView = header;

    // sets the attributes
    self.headerTableView = headerTableView;
    self.imageAddButton = addButton;

    // sets the cell list
    self.cellList = cellList;

    // releases the objects
    [headerTableView release];
    [headerContainer release];
    [header release];
    [cellList release];
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
    if(_subTitle && _subTitle.length > 0) {
        self.titleLabel.frame = CGRectMake(83, 24, 197, 24);
    } else {
        self.titleLabel.frame = CGRectMake(83, 34, 197, 24);
    }
}

- (NSString *)imageName {
    return _imageName;
}

- (void)setImageName:(NSString *)imageName {
    // in case the object is the same
    if(imageName == _imageName) {
        // returns immediately
        return;
    }

    // releases the object
    [_imageName release];

    // sets and retains the object
    _imageName = [imageName retain];

    // creates the image (reference) for the image (path)
    UIImage *imageReference = [UIImage imageNamed:_imageName];

    // sets the image in the image (view)
    self.image.image = imageReference;
}

- (NSData *)imageValue {
    return _imageValue;
}

- (void)setImageValue:(NSData *)imageValue {
    // in case the object is the same
    if(imageValue == _imageValue) {
        // returns immediately
        return;
    }

    // releases the object
    [_imageValue release];

    // sets and retains the object
    _imageValue = [imageValue retain];

    // creates the image (reference) for the image (path)
    UIImage *imageReference = [UIImage imageWithData:_imageValue];

    // sets the image in the image (view)
    self.image.image = imageReference;
}

- (void)setEditing:(BOOL)editing {
    // calls the super
    [super setEditing:editing];

    // changes the cells' editing mode
    [self.titleTableViewCell changeEditing:editing commit:NO];
    [self.subTitleTableViewCell changeEditing:editing commit:NO];

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

    // changes the cells' editing mode
    [self.titleTableViewCell changeEditing:editing commit:NO];
    [self.subTitleTableViewCell changeEditing:editing commit:NO];

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
    HMItem *titleItem = [headerNamedItemGroup getItem:@"title"];
    HMItem *subTitleItem = [headerNamedItemGroup getItem:@"subTitle"];
    HMItem *imageItem = [headerNamedItemGroup getItem:@"image"];

    // sets the attributes
    self.title = titleItem.description;
    self.subTitle = subTitleItem.description;
    self.imageName = imageItem.description;
    self.imageValue = (NSData *) imageItem.data;
}

- (void)reloadData {
    // calls the super
    [super reloadData];

    // redraws the header
    [self redrawHeader];
}

- (void)flushItemSpecificationTransient:(BOOL)transient {
    // calls the super
    [super flushItemSpecificationTransient:(BOOL)transient];

    // retrieves the header named item group
    HMNamedItemGroup *headerNamedItemGroup = self.itemDataSource.headerNamedItemGroup;

    // retrieves the items
    HMItem *titleItem = [headerNamedItemGroup getItem:@"title"];
    HMItem *subTitleItem = [headerNamedItemGroup getItem:@"subTitle"];
    HMItem *imageItem = [headerNamedItemGroup getItem:@"image"];

    // sets the attributes
    titleItem.description = transient ? self.titleTableViewCell.descriptionTransient : self.titleTableViewCell.description;
    subTitleItem.description = transient ? self.subTitleTableViewCell.descriptionTransient : self.subTitleTableViewCell.description;
    imageItem.description = self.imageName;
    imageItem.data = self.imageValue;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // creates the cell identifier
    static NSString *cellIdentifier = @"Cell";

    // tries to retrives the cell from cache (reusable)
    HMEditTableViewCell *tableViewCell = (HMEditTableViewCell *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    // in case the cell is not defined in the current cache
    // need to create a new cell
    if(tableViewCell == nil) {
        // retrieves the header named item group
        HMNamedItemGroup *headerNamedItemGroup = self.itemDataSource.headerNamedItemGroup;

        // sets each table view cell's value and stores it
        if(indexPath.row == 0) {
            // retrieves the title item
            HMItem *titleItem = [headerNamedItemGroup getItem:@"title"];

            // generates the component
            tableViewCell = (HMEditTableViewCell *) titleItem.component;

            // sets the table view cell to always be in edit mode
            tableViewCell.editAlways = YES;

            // updates the cell's position
            [tableViewCell updatePositionTableView:tableView indexPath:indexPath];

            // forces the cell to be constructed in
            // edit mode, since when set editing is
            // first called the cells won't be
            // constructed yet
            [tableViewCell changeEditing:YES commit:NO];

            // sets the title table view cell
            self.titleTableViewCell = tableViewCell;
        } else {
            // retrieves the subtitle item
            HMItem *subTitleItem = [headerNamedItemGroup getItem:@"subTitle"];

            // Generates the component
            tableViewCell = (HMEditTableViewCell *) subTitleItem.component;

            // sets the table view cell to always be in edit mode
            tableViewCell.editAlways = YES;

            // updates the cell's position
            [tableViewCell updatePositionTableView:tableView indexPath:indexPath];

            // forces the cell to be constructed in
            // edit mode, since when set editing is
            // first called the cells won't be
            // constructed yet
            [tableViewCell changeEditing:YES commit:NO];

            // sets the table view cell as the subtitle table view cell
            self.subTitleTableViewCell = tableViewCell;
        }

        // adds the table view cell to the cell list
        [self.cellList addObject:tableViewCell];
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

- (void)setSeparatorColor:(UIColor *)separatorColor {
    // calls the super
    [super setSeparatorColor:separatorColor];

    // sets the separator color in the header table view
    self.headerTableView.separatorColor = separatorColor;
}

- (void)setSeparatorStyle:(UITableViewCellSeparatorStyle)separatorStyle {
    // calls the super
    [super setSeparatorStyle:separatorStyle];

    // sets the separator style in the header table view
    self.headerTableView.separatorStyle = separatorStyle;
}

@end
