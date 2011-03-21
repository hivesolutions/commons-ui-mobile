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
@synthesize titleTextField = _titleTextField;
@synthesize subTitleTextField = _subTitleTextField;
@synthesize imageAddImage = _imageAddImage;

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
    [self.title release];

    // releases the sub title
    [self.subTitle release];

    // releases the image
    [self.image release];

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
    // creates the header
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 82)];
    header.contentMode = UIViewContentModeScaleToFill;
    header.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    header.backgroundColor = [UIColor clearColor];

    // creates the header container
    UIView *headerContainer = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 300, 82)];
    headerContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;

    // creates the image frame
    CGRect imageFrame = CGRectMake(0, 15, 64, 64);

    // creates the image view
    UIImageView *image = [[UIImageView alloc] initWithFrame:imageFrame];

    // sets the header image rounded corners
    image.layer.cornerRadius = 4.0;
    image.layer.masksToBounds = YES;
    image.layer.borderColor = [UIColor lightGrayColor].CGColor;
    image.layer.borderWidth = 1.0;

    // creates the title label frame
    CGRect titleLabelFrame = CGRectMake(83, 34, 197, 24);

    // creates the title label view
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleLabelFrame];
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];
    titleLabel.shadowColor = [UIColor whiteColor];
    titleLabel.shadowOffset = CGSizeMake(0, 1);

    // adds the sub views
    [headerContainer addSubview:image];
    [headerContainer addSubview:titleLabel];
    [header addSubview:headerContainer];

    // sets the table header
    self.tableHeaderView = header;

    // sets the "normal" header view
    self.normalHeaderView = header;

    // sets the attributes
    self.titleLabel = titleLabel;
    self.subTitleLabel = titleLabel;
    self.imageImage = image;

    // releases the objects
    [titleLabel release];
    [image release];
    [headerContainer release];
    [header release];
}

- (void)constructEditView {
    // creates the header
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 82)];
    header.contentMode = UIViewContentModeScaleToFill;
    header.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    header.backgroundColor = [UIColor clearColor];

    // creates the header container
    UIView *headerContainer = [[UIView alloc] initWithFrame:CGRectMake(20, 0, 300, 82)];
    headerContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;

    // creates the image frame
    CGRect imageFrame = CGRectMake(0, 15, 64, 64);

    // creates the add image view
    UIImageView *addImage = [[UIImageView alloc] initWithFrame:imageFrame];

    // sets the header image rounded corners
    addImage.layer.cornerRadius = 4.0;
    addImage.layer.masksToBounds = YES;
    addImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
    addImage.layer.borderWidth = 1.0;

    // creates the title text field frame
    CGRect titleTextFieldFrame = CGRectMake(83, 35, 197, 24);

    // creates the title text field view
    UITextField *titleTextField = [[UITextField alloc] initWithFrame:titleTextFieldFrame];
    titleTextField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    titleTextField.backgroundColor = [UIColor whiteColor];
    titleTextField.font = [UIFont fontWithName:@"Helvetica-Bold" size:19];

    // adds the sub views
    [headerContainer addSubview:addImage];
    [headerContainer addSubview:titleTextField];
    [header addSubview:headerContainer];

    // sets the edit header view
    self.editHeaderView = header;

    // sets the attributes
    self.titleTextField = titleTextField;
    self.subTitleTextField = titleTextField;
    self.imageAddImage = addImage;

    // releases the objects
    [titleTextField release];
    [addImage release];
    [headerContainer release];
    [header release];
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

    // updates the title text field
    self.titleTextField.text = _title;
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

- (void)showEditing {
    // updates the title value
    self.title = self.titleLabel.text;

    // sets the edit header view as the table
    // header view
    self.tableHeaderView = self.editHeaderView;
}

- (void)hideEditing {
    // updates the title value
    self.title = self.titleTextField.text;

    // sets the normal header view as the table
    // header view
    self.tableHeaderView = self.normalHeaderView;
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

@end
