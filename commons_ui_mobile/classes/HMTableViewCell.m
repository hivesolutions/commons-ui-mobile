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
@synthesize nameWidth = _nameWidth;
@synthesize descriptionFont = _descriptionFont;
@synthesize descriptionColor = _descriptionColor;
@synthesize descriptionNumberLines = _descriptionNumberLines;
@synthesize descriptionAlignment = _descriptionAlignment;
@synthesize descriptionPosition = _descriptionPosition;
@synthesize descriptionHorizontalAnchor = _descriptionHorizontalAnchor;
@synthesize descriptionVerticalAnchor = _descriptionVerticalAnchor;
@synthesize descriptionWidth = _descriptionWidth;
@synthesize selectedBorderColor = _selectedBorderColor;
@synthesize selectedBackgroundColors = _selectedBackgroundColors;
@synthesize selectedBackgroundTopSeparatorColor = _selectedBackgroundTopSeparatorColor;
@synthesize selectedBackgroundBottomSeparatorColor = _selectedBackgroundBottomSeparatorColor;
@synthesize selectedBackgroundTopSeparatorStyle =  _selectedBackgroundTopSeparatorStyle;
@synthesize selectedBackgroundBottomSeparatorStyle =  _selectedBackgroundBottomSeparatorStyle;
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

    // releases the name number lines
    [_nameNumberLines release];

    // releases the name position
    [_namePosition release];

    // releases the name width
    [_nameWidth release];

    // releases the description
    [_description release];

    // releases the description font
    [_descriptionFont release];

    // releases the description color
    [_descriptionColor release];

    // releases the description number lines
    [_descriptionNumberLines release];

    // releases the description position
    [_descriptionPosition release];

    // releases the description width
    [_descriptionWidth release];

    // releases the selected border color
    [_selectedBorderColor release];

    // releases the selecte background colors
    [_selectedBackgroundColors release];

    // releases the selected background top separator color
    [_selectedBackgroundTopSeparatorColor release];

    // releases the selected background bottom separator color
    [_selectedBackgroundBottomSeparatorColor release];

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
    // makes the labels transparent
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.detailTextLabel.backgroundColor = [UIColor clearColor];
}

- (void)constructStructures {
    // creates the selected background view
    HMTableViewCellBackgroundView *selectedBackgroundView = [[HMTableViewCellBackgroundView alloc] init];

    // sets the objects
    self.selectedBackgroundView = selectedBackgroundView;

    // releases the objects
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

        // runs the updates over athe item table view
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

- (UIColor *)selectedBackgroundTopSeparatorColor {
    return _selectedBackgroundTopSeparatorColor;
}

- (void)setSelectedBackgroundTopSeparatorColor:(UIColor *)selectedBackgroundTopSeparatorColor {
    // in case the object is the same
    if(selectedBackgroundTopSeparatorColor == _selectedBackgroundTopSeparatorColor) {
        // returns immediately
        return;
    }

    // releases the object
    [_selectedBackgroundTopSeparatorColor release];

    // sets and retains the object
    _selectedBackgroundTopSeparatorColor = [selectedBackgroundTopSeparatorColor retain];

    // retrieves the selected background view
    HMTableViewCellBackgroundView *selectedBackgroundView = (HMTableViewCellBackgroundView *) self.selectedBackgroundView;

    // sets the top separator color in the selected background view
    selectedBackgroundView.topSeparatorColor = selectedBackgroundTopSeparatorColor;
}

- (UIColor *)selectedBackgroundBottomSeparatorColor {
    return _selectedBackgroundBottomSeparatorColor;
}

- (void)setSelectedBackgroundBottomSeparatorColor:(UIColor *)selectedBackgroundBottomSeparatorColor {
    // in case the object is the same
    if(selectedBackgroundBottomSeparatorColor == _selectedBackgroundBottomSeparatorColor) {
        // returns immediately
        return;
    }

    // releases the object
    [_selectedBackgroundBottomSeparatorColor release];

    // sets and retains the object
    _selectedBackgroundBottomSeparatorColor = [selectedBackgroundBottomSeparatorColor retain];

    // retrieves the selected background view
    HMTableViewCellBackgroundView *selectedBackgroundView = (HMTableViewCellBackgroundView *) self.selectedBackgroundView;

    // sets the bottom separator color in the selected background view
    selectedBackgroundView.bottomSeparatorColor = selectedBackgroundBottomSeparatorColor;
}

- (HMTableViewCellBackgroundViewSeparatorStyle)selectedBackgroundTopSeparatorStyle {
    return _selectedBackgroundTopSeparatorStyle;
}

- (void)setSelectedBackgroundTopSeparatorStyle:(HMTableViewCellBackgroundViewSeparatorStyle)selectedBackgroundTopSeparatorStyle {
    // sets the value
    _selectedBackgroundTopSeparatorStyle = selectedBackgroundTopSeparatorStyle;

    // retrieves the selected background view
    HMTableViewCellBackgroundView *selectedBackgroundView = (HMTableViewCellBackgroundView *) self.selectedBackgroundView;

    // sets the top separator style in the selected background view
    selectedBackgroundView.topSeparatorStyle = selectedBackgroundTopSeparatorStyle;
}

- (HMTableViewCellBackgroundViewSeparatorStyle)selectedBackgroundBottomSeparatorStyle {
    return _selectedBackgroundBottomSeparatorStyle;
}

- (void)setSelectedBackgroundBottomSeparatorStyle:(HMTableViewCellBackgroundViewSeparatorStyle)selectedBackgroundBottomSeparatorStyle {
    // sets the value
    _selectedBackgroundBottomSeparatorStyle = selectedBackgroundBottomSeparatorStyle;

    // retrieves the selected background view
    HMTableViewCellBackgroundView *selectedBackgroundView = (HMTableViewCellBackgroundView *) self.selectedBackgroundView;

    // sets the bottom separator style in the selected background view
    selectedBackgroundView.bottomSeparatorStyle = selectedBackgroundBottomSeparatorStyle;
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

    // updates the position
    [self updatePosition];
}

- (void)updateLabels {
    // updates the name label
    [self updateNameLabel:self.textLabel];

    // updates the description label
    [self updateDescriptionLabel:self.detailTextLabel];
}

- (void)updateNameLabel:(UILabel *)nameLabel {
    // configures the name label
    nameLabel.font = self.nameFont ? self.nameFont : nameLabel.font;
    nameLabel.textColor = self.nameColor ? self.nameColor : nameLabel.textColor;
    nameLabel.textAlignment = self.nameAlignment;

    // in case the name number of lines are defined
    if(self.nameNumberLines) {
        // sets the number of lines in the name label
        nameLabel.numberOfLines = self.nameNumberLines.intValue;
    }

    // in case the name width is defined
    if(self.nameWidth) {
        // unpacks the name width
        float nameWidth = self.nameWidth.floatValue;

        // sets the name width in the frame
        CGRect nameLabelFrame = nameLabel.frame;
        nameLabelFrame.size.width = nameWidth;
        nameLabel.frame = nameLabelFrame;
    }

    // in case the name position is defined
    if(self.namePosition) {
        // retrieves the name position
        CGPoint namePosition = self.namePosition.CGPointValue;

        // updates the label's position
        [self updateLabelPosition:nameLabel position:namePosition horizontalAnchor:self.nameHorizontalAnchor verticalAnchor:self.nameVerticalAnchor];
    }
}

- (void)updateDescriptionLabel:(UILabel *)descriptionLabel {
    // configures the description label
    descriptionLabel.font = self.descriptionFont ? self.descriptionFont : descriptionLabel.font;
    descriptionLabel.textColor = self.descriptionColor ? self.descriptionColor : descriptionLabel.textColor;
    descriptionLabel.textAlignment = self.descriptionAlignment;

    // in case the description number of lines are defined
    if(self.descriptionNumberLines) {
        // sets the number of lines in the description label
        descriptionLabel.numberOfLines = self.descriptionNumberLines.intValue;
    }

    // in case the description width is defined
    if(self.descriptionWidth) {
        // unpacks the description width
        float descriptionWidth = self.descriptionWidth.floatValue;

        // sets the description width in the frame
        CGRect descriptionLabelFrame = descriptionLabel.frame;
        descriptionLabelFrame.size.width = descriptionWidth;
        descriptionLabel.frame = descriptionLabelFrame;
    }

    // in case the description position is defined
    if(self.descriptionPosition) {
        // retrieves the description position
        CGPoint descriptionPosition = self.descriptionPosition.CGPointValue;

        // updates the label's position
        [self updateLabelPosition:descriptionLabel position:descriptionPosition horizontalAnchor:self.descriptionHorizontalAnchor verticalAnchor:self.descriptionVerticalAnchor];
    }
}

- (void)updateLabelPosition:(UILabel *)label position:(CGPoint)position horizontalAnchor:(HMTableViewCellHorizontalAnchor)horizontalAnchor verticalAnchor:(HMTableViewCellVerticalAnchor)verticalAnchor {
    // retrieves the label frame
    CGRect labelFrame = label.frame;

    // updates the label's horizontal positions
    // according to the type of horizontal anchoring
    switch(horizontalAnchor) {
        // in case the labels should anchor to the left
        case HMTableViewCellHorizontalAnchorLeft:
            labelFrame.origin.x = self.frame.origin.x + position.x;

            // breaks
            break;

        // in case the labels should anchor to the top
        case HMTableViewCellHorizontalAnchorRight:
            labelFrame.origin.x = self.frame.origin.x + self.frame.size.width - labelFrame.size.width - position.x;

            // breaks
            break;

        // in case no anchoring is defined
        case HMTableViewCellHorizontalAnchorNone:
            labelFrame.origin.x = position.x;

            // breaks
            break;
    }

    // updates the label's vertical positions
    // according to the type of vertical anchoring
    switch(verticalAnchor) {
        // in case the labels should anchor to the top
        case HMTableViewCellVerticalAnchorTop:
            labelFrame.origin.y = self.frame.origin.y + position.y;

            // breaks
            break;

        // in case the labels should anchor to the bottom
        case HMTableViewCellVerticalAnchorBottom:
            labelFrame.origin.y = self.frame.origin.y + self.frame.size.height - position.y;

            // breaks
            break;

        // in case no anchoring is defined
        case HMTableViewCellVerticalAnchorNone:
            labelFrame.origin.y = position.y;

            // breaks
            break;
    }

    // sets the updated label frame
    label.frame = labelFrame;
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

- (void)updatePosition {
    // retrieves the parent table view
    UITableView *tableView = (UITableView *) self.superview;

    // retrieves the cell's position attributes
    NSIndexPath *indexPath = [tableView indexPathForCell:self];
    NSUInteger section = indexPath.section;
    NSUInteger numberRows = [tableView numberOfRowsInSection:section];
    NSUInteger row = indexPath.row;

    // retrieves the background views
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
    selectedBackgroundView.position = position;
}

@end
