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
// __revision__  = $LastChangedRevision$
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "HMTableViewCell.h"

@implementation HMTableViewCell

@synthesize name = _name;
@synthesize nameLabel = _nameLabel;
@synthesize nameShadowColor = _nameShadowColor;
@synthesize namePosition = _namePosition;
@synthesize nameHorizontalAnchor = _nameHorizontalAnchor;
@synthesize nameVerticalAnchor = _nameVerticalAnchor;
@synthesize nameWidth = _nameWidth;
@synthesize description = _description;
@synthesize descriptionLabel = _descriptionLabel;
@synthesize descriptionShadowColor = _descriptionShadowColor;
@synthesize descriptionPosition = _descriptionPosition;
@synthesize descriptionHorizontalAnchor = _descriptionHorizontalAnchor;
@synthesize descriptionVerticalAnchor = _descriptionVerticalAnchor;
@synthesize descriptionWidth = _descriptionWidth;
@synthesize subDescription = _subDescription;
@synthesize subDescriptionShadowColor = _subDescriptionShadowColor;
@synthesize subDescriptionLabel = _subDescriptionLabel;
@synthesize subDescriptionFont = _subDescriptionFont;
@synthesize subDescriptionPosition = _subDescriptionPosition;
@synthesize subDescriptionHorizontalAnchor = _subDescriptionHorizontalAnchor;
@synthesize subDescriptionVerticalAnchor = _subDescriptionVerticalAnchor;
@synthesize subDescriptionWidth = _subDescriptionWidth;
@synthesize cornerRadius = _cornerRadius;
@synthesize borderColor = _borderColor;
@synthesize backgroundColors = _backgroundColors;
@synthesize backgroundTopSeparatorColor = _backgroundTopSeparatorColor;
@synthesize backgroundBottomSeparatorColor = _backgroundBottomSeparatorColor;
@synthesize backgroundTopSeparatorStyle =  _backgroundTopSeparatorStyle;
@synthesize backgroundBottomSeparatorStyle =  _backgroundBottomSeparatorStyle;
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

    // releases the name label
    [_nameLabel release];

    // releases the name shadow color
    [_nameShadowColor release];

    // releases the name position
    [_namePosition release];

    // releases the name width
    [_nameWidth release];

    // releases the description
    [_description release];

    // releases the description label
    [_descriptionLabel release];

    // releases the description shadow color
    [_descriptionShadowColor release];

    // releases the description position
    [_descriptionPosition release];

    // releases the description width
    [_descriptionWidth release];

    // releases the sub description
    [_subDescription release];

    // releases the sub description label
    [_subDescriptionLabel release];

    // releases the sub description shadow color
    [_subDescriptionShadowColor release];

    // releases the sub description font
    [_subDescriptionFont release];

    // releases the sub description position
    [_subDescriptionPosition release];

    // releases the sub description width
    [_subDescriptionWidth release];

    // releases the border color
    [_borderColor release];

    // releases the background colors
    [_backgroundColors release];

    // releases the background top separator color
    [_backgroundTopSeparatorColor release];

    // releases the background bottom separator color
    [_backgroundBottomSeparatorColor release];

    // releases the selected background colors
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

    // calls the super
    [super dealloc];
}

- (void)initStructures {
    // sets the labels
    self.nameLabel = self.textLabel;
    self.descriptionLabel = self.detailTextLabel;

    // sets the default values
    self.nameLabel.shadowOffset = CGSizeMake(1, 1);
    self.descriptionLabel.shadowOffset = CGSizeMake(1, 1);
    self.subDescriptionHorizontalAnchor = HMTableViewCellHorizontalAnchorNone;
    self.subDescriptionVerticalAnchor = HMTableViewCellVerticalAnchorNone;
}

- (void)constructStructures {
    // creates the selected background view
    HMTableViewCellBackgroundView *selectedBackgroundView = [[HMTableViewCellBackgroundView alloc] init];

    // creates the subDescription label
    CGRect frame = CGRectMake(0, 0, 300, 10);
    UILabel *subDescriptionLabel = [[UILabel alloc] initWithFrame:frame];
    subDescriptionLabel.shadowOffset = CGSizeMake(1, 1);
    subDescriptionLabel.backgroundColor = [UIColor clearColor];
    subDescriptionLabel.hidden = YES;

    // adds the sub description label
    [self.contentView addSubview:subDescriptionLabel];

    // sets the objects
    self.subDescriptionLabel = subDescriptionLabel;
    self.selectedBackgroundView = selectedBackgroundView;

    // releases the objects
    [subDescriptionLabel release];
    [selectedBackgroundView release];
}

- (void)constructBackgroundView {
    // in case the background view is already custom
    if([self.backgroundView isKindOfClass:[HMTableViewCellBackgroundView class]]) {
        // returns
        return;
    }

    // creates the custom background view
    HMTableViewCellBackgroundView *backgroundView = [[HMTableViewCellBackgroundView alloc] init];
    backgroundView.backgroundColor = self.backgroundView.backgroundColor;
    backgroundView.borderColor = self.borderColor;
    backgroundView.cornerRadius = self.cornerRadius;
    backgroundView.topSeparatorColor = self.backgroundTopSeparatorColor;
    backgroundView.bottomSeparatorColor = self.backgroundBottomSeparatorColor;
    backgroundView.topSeparatorStyle = self.backgroundTopSeparatorStyle;
    backgroundView.bottomSeparatorColor = self.backgroundBottomSeparatorColor;

    // sets the custom background view
    self.backgroundView = backgroundView;

    // releases the background view
    [backgroundView release];
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
    self.nameLabel.text = name;
}

- (UIColor *)nameShadowColor {
    return _nameShadowColor;
}

- (void)setNameShadowColor:(UIColor *)nameShadowColor {
    // in case the object is the same
    if(nameShadowColor == _nameShadowColor) {
        // returns immediately
        return;
    }

    // releases the object
    [_nameShadowColor release];

    // sets and retains the object
    _nameShadowColor = [nameShadowColor retain];

    // sets the name label's shadow color
    self.nameLabel.shadowColor = nameShadowColor;
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

    // sets the description label's text
    self.descriptionLabel.text = description;
}

- (NSString *)descriptionTransient {
    return nil;
}

- (void)setDescriptionTransient:(NSString *)descriptionTransient {
}

- (UIColor *)descriptionShadowColor {
    return _descriptionShadowColor;
}

- (void)setDescriptionShadowColor:(UIColor *)descriptionShadowColor {
    // in case the object is the same
    if(descriptionShadowColor == _descriptionShadowColor) {
        // returns immediately
        return;
    }

    // releases the object
    [_descriptionShadowColor release];

    // sets and retains the object
    _descriptionShadowColor = [descriptionShadowColor retain];

    // sets the description label's shadow color
    self.descriptionLabel.shadowColor = descriptionShadowColor;
}

- (NSString *)subDescription {
    return _subDescription;
}

- (void)setSubDescription:(NSString *)subDescription {
    // in case the description is invalid
    if(subDescription == nil) {
        // returns immediately
        return;
    }

    // in case the object is the same
    if(subDescription == _description) {
        // returns immediately
        return;
    }

    // releases the object
    [_subDescription release];

    // sets and retains the object
    _subDescription = [subDescription retain];

    // makes the sub description label visible
    self.subDescriptionLabel.hidden = NO;

    // sets the value in the sub description label
    self.subDescriptionLabel.text = subDescription;
}

- (UIColor *)subDescriptionShadowColor {
    return _subDescriptionShadowColor;
}

- (void)setSubDescriptionShadowColor:(UIColor *)subDescriptionShadowColor {
    // in case the object is the same
    if(subDescriptionShadowColor == _subDescriptionShadowColor) {
        // returns immediately
        return;
    }

    // releases the object
    [_subDescriptionShadowColor release];

    // sets and retains the object
    _subDescriptionShadowColor = [subDescriptionShadowColor retain];

    // sets the sub description label's shadow color
    self.subDescriptionLabel.shadowColor = subDescriptionShadowColor;
}

- (UIFont *)subDescriptionFont {
    // returns the sub description font
    return _subDescriptionFont;
}

- (void)setSubDescriptionFont:(UIFont *)subDescriptionFont {
    // in case the object is the same
    if(subDescriptionFont == _subDescriptionFont) {
        // returns immediately
        return;
    }

    // releases the object
    [_subDescriptionFont release];

    // sets and retains the object
    _subDescriptionFont = [subDescriptionFont retain];

    // sets the font in the sub description label
    self.subDescriptionLabel.font = subDescriptionFont;

    // calculates the new text size
    CGSize textSize = [@"1" sizeWithFont:subDescriptionFont];

    // sets the updates text size
    CGRect frame = self.subDescriptionLabel.frame;
    frame.size.height = textSize.height;
    self.subDescriptionLabel.frame = frame;
}

- (CGFloat)cornerRadius {
    return _cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    // sets the corner radius
    _cornerRadius = cornerRadius;

    // in case the background view is custom
    if([self.backgroundView isKindOfClass:[HMTableViewCellBackgroundView class]]) {
        // retrieves the background view
        HMTableViewCellBackgroundView *backgroundView = (HMTableViewCellBackgroundView *) self.backgroundView;

        // sets the corner radius in the background view
        backgroundView.cornerRadius = cornerRadius;
    }

    // retrieves the selected background view
    HMTableViewCellBackgroundView *selectedBackgroundView = (HMTableViewCellBackgroundView *) self.selectedBackgroundView;

    // sets the corner radius in the selected background view
    selectedBackgroundView.cornerRadius = cornerRadius;
}

- (UIColor *)borderColor {
    // returns the border color
    return _borderColor;
}

- (void)setBorderColor:(UIColor *)borderColor {
    // in case the object is the same
    if(borderColor == _borderColor) {
        // returns immediately
        return;
    }

    // releases the object
    [_borderColor release];

    // sets and retains the object
    _borderColor = [borderColor retain];

    // in case the background view is custom
    if([self.backgroundView isKindOfClass:[HMTableViewCellBackgroundView class]]) {
        // retrieves the background view
        HMTableViewCellBackgroundView *backgroundView = (HMTableViewCellBackgroundView *) self.backgroundView;

        // sets the border color in the background view
        backgroundView.borderColor = borderColor;
    }

    // retrieves the selected background view
    HMTableViewCellBackgroundView *selectedBackgroundView = (HMTableViewCellBackgroundView *)self.selectedBackgroundView;

    // sets the border color
    selectedBackgroundView.borderColor = borderColor;
}

- (NSArray *)backgroundColors {
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

    // constructs the background view
    [self constructBackgroundView];

    // retrieves the background view
    HMTableViewCellBackgroundView *backgroundView = (HMTableViewCellBackgroundView *) self.backgroundView;

    // sets the background colors
    backgroundView.gradientColors = backgroundColors;
}

- (UIColor *)backgroundTopSeparatorColor {
    return _backgroundTopSeparatorColor;
}

- (void)setBackgroundTopSeparatorColor:(UIColor *)backgroundTopSeparatorColor{
    // in case the object is the same
    if(backgroundTopSeparatorColor == _backgroundTopSeparatorColor) {
        // returns immediately
        return;
    }

    // releases the object
    [_backgroundTopSeparatorColor release];

    // sets and retains the object
    _backgroundTopSeparatorColor = [backgroundTopSeparatorColor retain];

    // constructs the background view
    [self constructBackgroundView];

    // retrieves the background view
    HMTableViewCellBackgroundView *backgroundView = (HMTableViewCellBackgroundView *) self.backgroundView;

    // sets the top separator color in the background view
    backgroundView.topSeparatorColor = backgroundTopSeparatorColor;
}

- (UIColor *)backgroundBottomSeparatorColor {
    return _backgroundBottomSeparatorColor;
}

- (void)setBackgroundBottomSeparatorColor:(UIColor *)backgroundBottomSeparatorColor {
    // in case the object is the same
    if(backgroundBottomSeparatorColor == _backgroundBottomSeparatorColor) {
        // returns immediately
        return;
    }

    // releases the object
    [_backgroundBottomSeparatorColor release];

    // sets and retains the object
    _backgroundBottomSeparatorColor = [backgroundBottomSeparatorColor retain];

    // constructs the background view
    [self constructBackgroundView];

    // retrieves the background view
    HMTableViewCellBackgroundView *backgroundView = (HMTableViewCellBackgroundView *) self.backgroundView;

    // sets the bottom separator color in the background view
    backgroundView.bottomSeparatorColor = backgroundBottomSeparatorColor;
}

- (HMTableViewCellBackgroundViewSeparatorStyle)backgroundTopSeparatorStyle {
    return _backgroundTopSeparatorStyle;
}

- (void)setBackgroundTopSeparatorStyle:(HMTableViewCellBackgroundViewSeparatorStyle)backgroundTopSeparatorStyle {
    // sets the value
    _backgroundTopSeparatorStyle = backgroundTopSeparatorStyle;

    // in case the background view is not custom
    if(![self.backgroundView isKindOfClass:[HMTableViewCellBackgroundView class]]) {
        // returns
        return;
    }

    // retrieves the background view
    HMTableViewCellBackgroundView *backgroundView = (HMTableViewCellBackgroundView *) self.backgroundView;

    // sets the top separator style in the background view
    backgroundView.topSeparatorStyle = backgroundTopSeparatorStyle;
}

- (HMTableViewCellBackgroundViewSeparatorStyle)backgroundBottomSeparatorStyle {
    return _backgroundBottomSeparatorStyle;
}

- (void)setBackgroundBottomSeparatorStyle:(HMTableViewCellBackgroundViewSeparatorStyle)backgroundBottomSeparatorStyle {
    // sets the value
    _backgroundBottomSeparatorStyle = backgroundBottomSeparatorStyle;

    // in case the background view is not custom
    if(![self.backgroundView isKindOfClass:[HMTableViewCellBackgroundView class]]) {
        // returns
        return;
    }

    // retrieves the background view
    HMTableViewCellBackgroundView *backgroundView = (HMTableViewCellBackgroundView *) self.backgroundView;

    // sets the bottom separator style in the selected background view
    backgroundView.bottomSeparatorStyle = backgroundBottomSeparatorStyle;
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    // calls the super
    [super setSelected:selected animated:animated];

    // toggles the label's shadows
    self.nameLabel.shadowColor = selected ? nil : self.nameShadowColor;
    self.descriptionLabel.shadowColor = selected ? nil : self.descriptionShadowColor;
    self.subDescriptionLabel.shadowColor = selected ? nil : self.subDescriptionShadowColor;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    // calls the super
    [super setHighlighted:highlighted animated:animated];

    // toggles the label's shadows
    self.nameLabel.shadowColor = highlighted ? nil : self.nameShadowColor;
    self.descriptionLabel.shadowColor = highlighted ? nil : self.descriptionShadowColor;
    self.subDescriptionLabel.shadowColor = highlighted ? nil : self.subDescriptionShadowColor;
}

- (void)layoutSubviews {
    // calls the super
    [super layoutSubviews];

    // updates the name label
    [self layoutNameLabel];

    // updates the description label
    [self layoutDescriptionLabel];

    // updates the sub description label
    [self layoutSubDescriptionLabel];

    // updates the accessory view
    [self layoutAccessoryView];
}

- (void)layoutNameLabel {
    // sets the label background color to clear
    self.nameLabel.backgroundColor = [UIColor clearColor];

    // in case the name width is defined
    if(self.nameWidth) {
        // sets the name width in the frame
        CGRect nameLabelFrame = self.nameLabel.frame;
        nameLabelFrame.size.width = self.nameWidth.floatValue;
        self.nameLabel.frame = nameLabelFrame;
    }

    // in case the name position is defined
    if(self.namePosition) {
        // updates the label's position
        [self layoutLabel:self.nameLabel position:self.namePosition.CGPointValue horizontalAnchor:self.nameHorizontalAnchor verticalAnchor:self.nameVerticalAnchor];
    }
}

- (void)layoutDescriptionLabel {
    // sets the label background color to clear
    self.descriptionLabel.backgroundColor = [UIColor clearColor];

    // in case the description width is defined
    if(self.descriptionWidth) {
        // sets the description width in the frame
        CGRect descriptionLabelFrame = self.descriptionLabel.frame;
        descriptionLabelFrame.size.width = self.descriptionWidth.floatValue;
        self.descriptionLabel.frame = descriptionLabelFrame;
    }

    // in case the description position is defined
    if(self.descriptionPosition) {
        // updates the label's position
        [self layoutLabel:self.descriptionLabel position:self.descriptionPosition.CGPointValue horizontalAnchor:self.descriptionHorizontalAnchor verticalAnchor:self.descriptionVerticalAnchor];
    }
}

- (void)layoutSubDescriptionLabel {
    // in case the sub description width is defined
    if(self.subDescriptionWidth) {
        // sets the sub description width in the frame
        CGRect descriptionLabelFrame = self.descriptionLabel.frame;
        descriptionLabelFrame.size.width = self.subDescriptionWidth.floatValue;
        self.descriptionLabel.frame = descriptionLabelFrame;
    }

    // in case the sub description position is defined
    if(self.subDescriptionPosition) {
        // unpacks the position
        CGPoint subDescriptionPositionPoint = self.subDescriptionPosition.CGPointValue;

        // updates the label's position
        [self layoutLabel:self.subDescriptionLabel position:subDescriptionPositionPoint horizontalAnchor:self.subDescriptionHorizontalAnchor verticalAnchor:self.subDescriptionVerticalAnchor];
    }
}

- (void)layoutLabel:(UILabel *)label position:(CGPoint)position horizontalAnchor:(HMTableViewCellHorizontalAnchor)horizontalAnchor verticalAnchor:(HMTableViewCellVerticalAnchor)verticalAnchor {
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

- (void)layoutAccessoryView {
    // in case the accessory view is not defined
    if(!self.accessoryView) {
        // returns
        return;
    }

    // retrieves the current row number
    UITableView *tableView = (UITableView *) self.superview;
    NSIndexPath *indexPath = [tableView indexPathForCell:self];
    NSUInteger row = indexPath.row;

    // retrieves the accessory view
    HMAccessoryView *accessoryView = (HMAccessoryView *) self.accessoryView;

    // retrieves the selected background view's frame
    UIView *backgroundView = self.selectedBackgroundView;
    CGRect backgroundViewFrame = backgroundView.frame;

    // retrieves the image dimensions
    CGSize imageSize = accessoryView.image.size;
    CGFloat imageWidth = imageSize.width;
    CGFloat imageHeight = imageSize.height;

    // initializes the position
    CGFloat x = 0;
    CGFloat y = 0;

    // initializes the dimensions
    CGFloat width = imageWidth;
    CGFloat height = imageHeight;

    // in case the accessory view has text
    if(accessoryView.text) {
        // retrieves the text dimensions
        CGSize textSize = [accessoryView.text sizeWithFont:accessoryView.label.font];
        CGFloat textWidth = textSize.width;
        CGFloat textHeight = textSize.height;

        // subtracts the text height
        // to remove the vertical padding
        textHeight -= 6;

        // calculates the accessory view's dimensions
        width = textWidth > imageWidth ? textWidth : imageWidth;
        height = textHeight > imageHeight ? textHeight : imageHeight;

        // adds the image cap to the dimensions
        width += accessoryView.image.leftCapWidth * 2;
        height += accessoryView.image.topCapHeight * 2;

        // performs an height adjustment
        // for when the accessory view is
        // not in the first row, the reason
        // for this adjustment being required
        // is currently unknown
        height += (row == 0 && (int)height % 2 == 1 ? 0 : 1);
    }

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

- (void)updatePositionTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    // retrieves the cell's position attributes
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

    // in case the background view is custom
    if([self.backgroundView isKindOfClass:[HMTableViewCellBackgroundView class]]) {
        // retrieves the background view
        HMTableViewCellBackgroundView *backgroundView = (HMTableViewCellBackgroundView *) self.backgroundView;

        // updates the background view's position
        backgroundView.position = position;
    }

    // updates the selected background view's position
    selectedBackgroundView.position = position;
}

- (void)didMoveToSuperview {
    // calls the super
    [super didMoveToSuperview];

    // retrieves the associated table view (superview)
    self.itemTableView = (HMItemTableView *) self.superview;

    // sets the view ready flag
    self.viewReady = YES;
}

@end
