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

// __author__    = Tiago Silva <tsilva@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision: 2390 $
// __date__      = $LastChangedDate: 2009-04-02 08:36:50 +0100 (qui, 02 Abr 2009) $
// __copyright__ = Copyright (c) 2008 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "HMTableViewCell.h"

@implementation HMTableViewCell

@synthesize name = _name;
@synthesize nameFont = _nameFont;
@synthesize nameColor = _nameColor;
@synthesize nameNumberLines = _nameNumberLines;
@synthesize nameAlignment = _nameAlignment;
@synthesize namePosition = _namePosition;
@synthesize nameHorizontalAnchor = _nameHorizontalAnchor;
@synthesize nameVerticalAnchor = _nameVerticalAnchor;
@synthesize descriptionFont = _descriptionFont;
@synthesize descriptionColor = _descriptionColor;
@synthesize descriptionNumberLines = _descriptionNumberLines;
@synthesize descriptionAlignment = _descriptionAlignment;
@synthesize descriptionPosition = _descriptionPosition;
@synthesize descriptionHorizontalAnchor = _descriptionHorizontalAnchor;
@synthesize descriptionVerticalAnchor = _descriptionVerticalAnchor;
@synthesize borderColor = _borderColor;
@synthesize selectedBorderColor = _selectedBorderColor;
@synthesize backgroundColors = _backgroundColors;
@synthesize selectedBackgroundColors = _selectedBackgroundColors;
@synthesize selectableName = _selectableName;
@synthesize height = _height;
@synthesize viewReady = _viewReady;
@synthesize insertableRow = _insertableRow;
@synthesize deletableRow = _deletableRow;
@synthesize dataTransient = _dataTransient;
@synthesize changeEditingStatus = _changeEditingStatus;
@synthesize readViewController = _readViewController;
@synthesize readNibName = _readNibName;
@synthesize item = _item;
@synthesize itemTableView = _itemTableView;

- (id)initWithStyle:(UITableViewCellStyle)cellStyle reuseIdentifier:(NSString *)cellIdentifier {
    // invokes the parent constructor
    self = [super initWithStyle:cellStyle reuseIdentifier:cellIdentifier];

    // initializes the structures
    [self initStructures];

    // constructs the structures
    [self constructStructures];

    // returns the instance
    return self;
}

- (void)dealloc {
    // releases the name
    [_name release];

    // releases the name font
    [_nameFont release];

    // releases the name color
    [_nameColor release];

    // releases the name position
    [_namePosition release];

    // releases the description
    [_description release];

    // releases the description font
    [_descriptionFont release];

    // releases the description color
    [_descriptionColor release];

    // releases the description position
    [_descriptionPosition release];

    // releases the border color
    [_borderColor release];

    // releases the selected border color
    [_selectedBorderColor release];

    // releases the background colors
    [_backgroundColors release];

    // releases the selecte background colors
    [_selectedBackgroundColors release];

    // releases the data
    [_data release];

    // releases the data transient
    [_dataTransient release];

    // releases the read nib name
    [_readNibName release];

    // releases the item
    [_item release];

    // calls the super
    [super dealloc];
}

- (void)initStructures {
    // sets the default attributes
    self.nameFont = [UIFont fontWithName:@"Helvetica-Bold" size:HM_TABLE_VIEW_CELL_NAME_FONT_SIZE];
    self.nameColor = [UIColor blackColor];
    self.descriptionFont = [UIFont fontWithName:@"Helvetica-Bold" size:HM_TABLE_VIEW_CELL_DESCRIPTION_FONT_SIZE];
    self.descriptionColor = [UIColor blackColor];
    self.borderColor = [UIColor grayColor];
    self.height = HM_TABLE_VIEW_CELL_HEIGHT;
    self.insertableRow = NO;
    self.deletableRow = YES;
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.detailTextLabel.backgroundColor = [UIColor clearColor];
}

- (void)constructStructures {
    // creates the background view
    HMTableViewCellBackgroundView *backgroundView = [[HMTableViewCellBackgroundView alloc] init];
    HMTableViewCellBackgroundView *selectedBackgroundView = [[HMTableViewCellBackgroundView alloc] init];

    // sets the objects
    self.backgroundView = backgroundView;
    self.selectedBackgroundView = selectedBackgroundView;

    // releases the objects
    [backgroundView release];
    [selectedBackgroundView release];
}

- (void)changeEditing:(BOOL)editing commit:(BOOL)commit {
    self.changeEditingStatus = editing;
}

- (void)updateTableData {
    // in case the view is ready and positioned
    // in the item table view
    if(self.viewReady && self.itemTableView) {
        // retrieves if the animations are enabled
        BOOL areAnimationsEnabled = [UIView areAnimationsEnabled];

        // disables the animations
        [UIView setAnimationsEnabled:NO];

        // runs the updates over the item table view
        [self.itemTableView beginUpdates];
        [self.itemTableView endUpdates];

        // resets the animations enabled value
        [UIView setAnimationsEnabled:areAnimationsEnabled];
    }
    // otherwise the cell is not positioned in the table
    // or is not ready to be presented and changed
    else {
        // in case the item table view is not dirty
        if(!self.itemTableView.dirty) {
            // executes the update table data delayed in the main thread
            // to avoid thread issues with the table view
            [self performSelectorOnMainThread:@selector(updateTableDataDelayed) withObject:nil waitUntilDone:NO];

            // sets the dirty flag
            self.itemTableView.dirty = YES;
        }
    }
}

- (void)updateTableDataDelayed {
    // prints a debug message
    NSLog(@"Updating table data in delayed mode");

    // retrieves if the animations are enabled
    BOOL areAnimationsEnabled = [UIView areAnimationsEnabled];

    // disables the animations
    [UIView setAnimationsEnabled:YES];

    // runs the updates over the item table view
    [self.itemTableView beginUpdates];
    [self.itemTableView endUpdates];

    // resets the animations enabled value
    [UIView setAnimationsEnabled:areAnimationsEnabled];

    // unsets the dirty flag
    self.itemTableView.dirty = NO;
}

- (NSString *)name {
    return _name;
}

- (void)setName:(NSString *)name {
    // in case the object is the same
    if(name == _name) {
        // returns immediately
        return;
    }

    // releases the object
    [_name release];

    // sets and retains the object
    _name = [name retain];

    // sets the cell's text label
    self.textLabel.text = name;
}

- (NSString *)description {
    return _description;
}

- (void)setDescription:(NSString *)description {
    // in case the description is invalid
    if(description == nil) {
        // returns immediately
        return;
    }

    // in case the object is the same
    if(description == _description) {
        // returns immediately
        return;
    }

    // releases the object
    [_description release];

    // sets and retains the object
    _description = [description retain];

    // sets the cell's text label
    self.detailTextLabel.text = description;
}

- (UIColor *)borderColor {
    // returns the border color
    return _borderColor;
}

- (void)setBorderColor:(UIColor *)borderColor{
    // in case the object is the same
    if(borderColor == _borderColor) {
        // returns immediately
        return;
    }

    // releases the object
    [_borderColor release];

    // sets and retains the object
    _borderColor = [borderColor retain];

    // retrieves the background view
    HMTableViewCellBackgroundView *backgroundView = (HMTableViewCellBackgroundView *)self.backgroundView;

    // sets the border color
    backgroundView.borderColor = borderColor;
}

- (UIColor *)selectedBorderColor {
    // returns the selected border color
    return _selectedBorderColor;
}

- (void)setSelectedBorderColor:(UIColor *)selectedBorderColor{
    // in case the object is the same
    if(selectedBorderColor == _selectedBorderColor) {
        // returns immediately
        return;
    }

    // releases the object
    [_selectedBorderColor release];

    // sets and retains the object
    _selectedBorderColor = [selectedBorderColor retain];

    // retrieves the selected background view
    HMTableViewCellBackgroundView *selectedBackgroundView = (HMTableViewCellBackgroundView *)self.selectedBackgroundView;

    // sets the border color
    selectedBackgroundView.borderColor = selectedBorderColor;
}

- (NSArray *)backgroundColors {
    // returns the background colors
    return _backgroundColors;
}

- (void)setBackgroundColors:(NSArray *)backgroundColors {
    // in case the object is the same
    if(backgroundColors == _backgroundColors) {
        // returns immediately
        return;
    }

    // releases the object
    [_backgroundColors release];

    // sets and retains the object
    _backgroundColors = [backgroundColors retain];

    // retrieves the background view
    HMTableViewCellBackgroundView *backgroundView = (HMTableViewCellBackgroundView *)self.backgroundView;

    // sets the background colors
    backgroundView.gradientColors = backgroundColors;
}

- (NSArray *)selectedBackgroundColors {
    // returns the selected background colors
    return _selectedBackgroundColors;
}

- (void)setSelectedBackgroundColors:(NSArray *)selectedBackgroundColors {
    // in case the object is the same
    if(selectedBackgroundColors == _selectedBackgroundColors) {
        // returns immediately
        return;
    }

    // releases the object
    [_selectedBackgroundColors release];

    // sets and retains the object
    _selectedBackgroundColors = [selectedBackgroundColors retain];

    // retrieves the selected background view
    HMTableViewCellBackgroundView *selectedBackgroundView = (HMTableViewCellBackgroundView *)self.selectedBackgroundView;

    // sets the selected background colors
    selectedBackgroundView.gradientColors = selectedBackgroundColors;
}

- (BOOL)selectable {
    return _selectable;
}

- (void)setSelectable:(BOOL)selectable {
    // sets the object
    _selectable = selectable;

    // sets the cell's selection style
    self.selectionStyle = selectable ? UITableViewCellSelectionStyleBlue : UITableViewCellSelectionStyleNone;
}

- (NSObject *)data {
    return _data;
}

- (void)setData:(NSObject *)data {
    // in case the object is the same
    if(data == _data) {
        // returns immediately
        return;
    }

    // releases the object
    [_data release];

    // sets and retains the object
    _data = [data retain];

    // sets the data as the
    // transient data
    self.dataTransient = _data;
}

- (NSString *)descriptionTransient {
    return nil;
}

- (void)setDescriptionTransient:(NSString *)descriptionTransient {
}

- (void)layoutSubviews {
    // calls the super
    [super layoutSubviews];

    // updates the labels
    [self updateLabels];

    // updates the accessory view
    [self updateAccessoryView];

    // updates the background view position
    [self updateBackgroundViewPosition];
}

- (void)updateLabels {
    // updates the name label
    [self updateNameLabel:self.detailTextLabel];

    // updates the description label
    [self updateDescriptionLabel:self.textLabel];
}

- (void)updateNameLabel:(UILabel *)nameLabel {
    // configures the name label
    nameLabel.font = self.nameFont;
    nameLabel.textColor = self.nameColor;
    nameLabel.textAlignment = self.nameAlignment;
    nameLabel.numberOfLines = self.nameNumberLines;

    // retrieves the name label frame
    CGRect nameLabelFrame = nameLabel.frame;

    // in case the name position is not defined
    if(self.namePosition) {
        // retrieves the name position
        CGPoint namePosition = self.namePosition.CGPointValue;

        // updates the name label's horizontal positions
        // according to the type of horizontal anchoring
        switch(self.nameHorizontalAnchor) {
            // in case the labels should anchor to the left
            case HMTableViewCellHorizontalAnchorLeft:
                nameLabelFrame.origin.x = self.frame.origin.x + namePosition.x;
                break;

            // in case the labels should anchor to the top
            case HMTableViewCellHorizontalAnchorRight:
                nameLabelFrame.origin.x = self.frame.origin.x + self.frame.size.width - nameLabelFrame.size.width - namePosition.x;
                break;

            // in case no anchoring is defined
            case HMTableViewCellHorizontalAnchorNone:
                nameLabelFrame.origin.x = namePosition.x;
                break;
        }

        // updates the name label's vertical positions
        // according to the type of vertical anchoring
        switch(self.nameVerticalAnchor) {
            // in case the labels should anchor to the top
            case HMTableViewCellVerticalAnchorTop:
                nameLabelFrame.origin.y = self.frame.origin.y + namePosition.y;
                break;

            // in case the labels should anchor to the bottom
            case HMTableViewCellVerticalAnchorBottom:
                nameLabelFrame.origin.y = self.frame.origin.y + self.frame.size.height - namePosition.y;
                break;

            // in case no anchoring is defined
            case HMTableViewCellVerticalAnchorNone:
                nameLabelFrame.origin.y = namePosition.y;
                break;
        }
    }

    // sets the updated label frame
    nameLabel.frame = nameLabelFrame;
}

- (void)updateDescriptionLabel:(UILabel *)descriptionLabel {
    // configures the description label
    descriptionLabel.font = self.descriptionFont;
    descriptionLabel.textColor = self.descriptionColor;
    descriptionLabel.textAlignment = self.descriptionAlignment;
    descriptionLabel.numberOfLines = self.descriptionNumberLines;

    // retrieves the description label frame
    CGRect descriptionLabelFrame = descriptionLabel.frame;

    // in case the description position is not defined
    if(self.descriptionPosition) {
        // retrieves the description position
        CGPoint descriptionPosition = self.descriptionPosition.CGPointValue;

        // updates the description label's horizontal positions
        // according to the type of horizontal anchoring
        switch(self.descriptionHorizontalAnchor) {
            // in case the labels should anchor to the left
            case HMTableViewCellHorizontalAnchorLeft:
                descriptionLabelFrame.origin.x = self.frame.origin.x + descriptionPosition.x;

                // breaks
                break;

            // in case the labels should anchor to the top
            case HMTableViewCellHorizontalAnchorRight:
                descriptionLabelFrame.origin.x = self.frame.origin.x + self.frame.size.width - descriptionLabelFrame.size.width - descriptionPosition.x;

                // breaks
                break;

            // in case no anchoring is defined
            case HMTableViewCellHorizontalAnchorNone:
                descriptionLabelFrame.origin.x = descriptionPosition.x;

                // breaks
                break;
        }

        // updates the description label's vertical positions
        // according to the type of vertical anchoring
        switch(self.descriptionVerticalAnchor) {
            // in case the labels should anchor to the top
            case HMTableViewCellVerticalAnchorTop:
                descriptionLabelFrame.origin.y = self.frame.origin.y + descriptionPosition.y;

                // breaks
                break;

            // in case the labels should anchor to the bottom
            case HMTableViewCellVerticalAnchorBottom:
                descriptionLabelFrame.origin.y = self.frame.origin.y + self.frame.size.height - descriptionPosition.y;

                // breaks
                break;

            // in case no anchoring is defined
            case HMTableViewCellVerticalAnchorNone:
                descriptionLabelFrame.origin.y = descriptionPosition.y;

                // breaks
                break;
        }
    }

    // sets the updated label frame
    descriptionLabel.frame = descriptionLabelFrame;
}

- (void)updateAccessoryView {
    // in case the accessory view is not defined
    if(!self.accessoryView) {
        // returns
        return;
    }

    // retrieves the accessory view
    HMAccessoryView *accessoryView = (HMAccessoryView *) self.accessoryView;

    // retrieves the selected background view's frame
    UIView *backgroundView = self.selectedBackgroundView;
    CGRect backgroundViewFrame = backgroundView.frame;

    // retrieves the text dimensions
    CGSize textSize = [accessoryView.text sizeWithFont:accessoryView.label.font];
    CGFloat textWidth = textSize.width;
    CGFloat textHeight = textSize.height;

    // subtracts the text height
    // to remove the vertical padding
    textHeight -= 6;

    // retrieves the image dimensions
    CGSize imageSize = accessoryView.image.size;
    CGFloat imageWidth = imageSize.width;
    CGFloat imageHeight = imageSize.height;

    // calculates the accessory view's dimensions
    CGFloat width = textWidth > imageWidth ? textWidth : imageWidth;
    CGFloat height = textHeight > imageHeight ? textHeight : imageHeight;

    // adds the image cap to the dimensions
    width += accessoryView.image.leftCapWidth * 2;
    height += accessoryView.image.topCapHeight * 2;

    // initializes the position
    CGFloat x = 0;
    CGFloat y = 0;

    // in case the accessory view's margin is defined
    if(accessoryView.margin) {
        // retrieves the margin point
        CGPoint marginPoint = accessoryView.margin.CGPointValue;

        // uses the margin to calculate the accessory view's position
        x = backgroundViewFrame.origin.x + backgroundViewFrame.size.width - width - marginPoint.x;
        y = marginPoint.y;
    }
    // in case the accessory view's margin is not defined
    else {
        // sets the default accessory view position
        x = backgroundViewFrame.origin.x + backgroundViewFrame.size.width - width - HM_TABLE_VIEW_CELL_ACCESSORY_VIEW_MARGIN_X;
        y = (backgroundViewFrame.size.height - height) / 2;
    }

    // updates the accessory view's frame
    CGRect frame = CGRectMake(x, y, width, height);
    accessoryView.frame = frame;
    accessoryView.bounds = frame;
}

- (void)didMoveToSuperview {
    // calls the super
    [super didMoveToSuperview];

    // retrieves the associated table view (superview)
    self.itemTableView = (HMItemTableView *) self.superview;

    // sets the view ready flag
    self.viewReady = YES;
}

- (void)updateBackgroundViewPosition {
    // retrieves the parent table view
    UITableView *tableView = (UITableView *) self.superview;

    // retrieves the cell's position attributes
    NSIndexPath *indexPath = [tableView indexPathForCell:self];
    NSUInteger section = indexPath.section;
    NSUInteger numberRows = [tableView numberOfRowsInSection:section];
    NSUInteger row = indexPath.row;

    // retrieves the background views
    HMTableViewCellBackgroundView *backgroundView = (HMTableViewCellBackgroundView *) self.backgroundView;
    HMTableViewCellBackgroundView *selectedBackgroundView = (HMTableViewCellBackgroundView *) self.selectedBackgroundView;

    // initializes the position
    HMTableViewCellBackgroundViewPosition position = HMTableViewCellBackgroundViewPositionGroupedMiddle;

    // in case the table has a plain style
    if(tableView.style == UITableViewStylePlain) {
        position = HMTableViewCellBackgroundViewPositionPlain;
    }
    // in case there is only one row
    else if(row == 0 && numberRows == 1) {
        position = HMTableViewCellBackgroundViewPositionGroupedSingle;
    }
    // in case there is more than one
    // row and this is the first one
    else if(row == 0) {
        position = HMTableViewCellBackgroundViewPositionGroupedTop;
    }
    // in case this is the last row
    else if(row == numberRows - 1) {
        position = HMTableViewCellBackgroundViewPositionGroupedBottom;
    }

    // updates the background views' positions
    backgroundView.position = position;
    selectedBackgroundView.position = position;
}

@end
