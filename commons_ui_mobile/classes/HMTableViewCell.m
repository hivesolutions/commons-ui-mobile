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
@synthesize nameFontSize = _nameFontSize;
@synthesize nameColor = _nameColor;
@synthesize descriptionFont = _descriptionFont;
@synthesize descriptionFontSize = _descriptionFontSize;
@synthesize descriptionColor = _descriptionColor;
@synthesize selectableName = _selectableName;
@synthesize height = _height;
@synthesize viewReady = _viewReady;
@synthesize insertableRow = _insertableRow;
@synthesize deletableRow = _deletableRow;
@synthesize dataTransient = _dataTransient;
@synthesize changeEditingStatus = _changeEditingStatus;
@synthesize item = _item;
@synthesize itemTableView = _itemTableView;

- (id)initWithStyle:(UITableViewCellStyle)cellStyle reuseIdentifier:(NSString *)cellIdentifier {
    // invokes the parent constructor
    self = [super initWithStyle:cellStyle reuseIdentifier:cellIdentifier];

    // creates the background view
    HMTableViewCellBackgroundView *backgroundView = [[HMTableViewCellBackgroundView alloc] init];

    // sets the default attributes
    self.nameFont = @"Helvetica-Bold";
    self.nameFontSize = HM_TABLE_VIEW_CELL_NAME_FONT_SIZE;
    self.nameColor = [UIColor blackColor];
    self.descriptionFont = @"Helvetica-Bold";
    self.descriptionFontSize = HM_TABLE_VIEW_CELL_DESCRIPTION_FONT_SIZE;
    self.descriptionColor = [UIColor blackColor];
    self.height = HM_TABLE_VIEW_CELL_HEIGHT;
    self.insertableRow = NO;
    self.deletableRow = YES;
    self.selectedBackgroundView = backgroundView;

    // releases the objects
    [backgroundView release];

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

    // releases the description
    [_description release];

    // releases the description font
    [_descriptionFont release];

    // releases the description color
    [_descriptionColor release];

    // releases the icon
    [_icon release];

    // releases the highlighted icon
    [_highlightedIcon release];

    // releases the accessory type string
    [_accessoryTypeString release];

    // releases the accessory value
    [_accessoryValue release];

    // releases the data
    [_data release];

    // releases the data transient
    [_dataTransient release];

    // releases the item
    [_item release];

    // calls the super
    [super dealloc];
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

- (NSString *)descriptionTransient {
    return nil;
}

- (void)setDescriptionTransient:(NSString *)descriptionTransient {
}

- (NSString *)icon {
    return _icon;
}

- (void)setIcon:(NSString *)icon {
    // in case the object is the same
    if(icon == _icon) {
        // returns immediately
        return;
    }

    // releases the object
    [_icon release];

    // sets and retains the object
    _icon = [icon retain];

    // retrieves the icon image
    UIImage *iconImage = [UIImage imageNamed:icon];

    // sets the image in the image view
    [self.imageView setImage:iconImage];
}

- (NSString *)highlightedIcon {
    return _highlightedIcon;
}

- (void)setHighlightedIcon:(NSString *)highlightedIcon {
    // in case the object is the same
    if(highlightedIcon == _highlightedIcon) {
        // returns immediately
        return;
    }

    // releases the object
    [_highlightedIcon release];

    // sets and retains the object
    _highlightedIcon = [highlightedIcon retain];

    // retrieves the highlighted icon image
    UIImage *highlightedIconImage = [UIImage imageNamed:highlightedIcon];

    // sets the image in the image view
    [self.imageView setHighlightedImage:highlightedIconImage];
}

- (BOOL)selectable {
    return _selectable;
}

- (void)setSelectable:(BOOL)selectable {
    // sets the object
    _selectable = selectable;

    // in case it's selectable in the normal mode
    if(selectable == YES) {
        // changes the selection style to blue
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    // otherwise it's not selectable
    else {
        // changes the selection style to none
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
}

- (NSString *)accessoryTypeString {
    return _accessoryTypeString;
}

- (void)setAccessoryTypeString:(NSString *)accessoryTypeString {
    // in case the object is the same
    if(accessoryTypeString == _accessoryTypeString) {
        // returns immediately
        return;
    }

    // releases the object
    [_accessoryTypeString release];

    // sets and retains the object
    _accessoryTypeString = [accessoryTypeString retain];

    // creates the specified accessory type
    if([accessoryTypeString isEqualToString:@"disclosure_indicator"]) {
        // sets the acessory type as the table view
        // cell acessory disclosure indicator
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if([accessoryTypeString isEqualToString:@"switch"]) {
        // creates the notifications switch
        UISwitch *notificationsSwitch = [[UISwitch alloc] init];

        // sets the notifications switch in the accessory view
        self.accessoryView = notificationsSwitch;
        self.editingAccessoryView = notificationsSwitch;

        // releases the notifications switch
        [notificationsSwitch release];
    } else if([accessoryTypeString isEqualToString:@"badge_label"]) {
        // creates the badge label and sets it as the accessory view
        HMBadgeLabel *badgeLabel = [[HMBadgeLabel alloc] init];
        badgeLabel.font = [UIFont fontWithName:self.descriptionFont size:self.descriptionFontSize];
        badgeLabel.text = self.accessoryValue;
        badgeLabel.backgroundColor = [UIColor clearColor];
        badgeLabel.textColor = [UIColor whiteColor];
        badgeLabel.textAlignment = UITextAlignmentCenter;
        badgeLabel.badgeColor = [UIColor colorWithRed:0.54 green:0.56 blue:0.62 alpha:1.0];

        // sets the badge label as the accessory view
        self.accessoryView = badgeLabel;
        self.editingAccessoryView = badgeLabel;

        // releases the badge label
        [badgeLabel release];
    }
}

- (NSString *)accessoryValue {
    return _accessoryValue;
}

- (void)setAccessoryValue:(NSString *)accessoryValue {
    // in case the object is the same
    if(accessoryValue == _accessoryValue) {
        // returns immediately
        return;
    }

    // releases the object
    [_accessoryValue release];

    // sets and retains the object
    _accessoryValue = [accessoryValue retain];

    // updates the badge label's value
    if([self.accessoryTypeString isEqualToString:@"badge_label"] && self.accessoryView) {
        // retrieves the badge label
        HMBadgeLabel *badgeLabel = (HMBadgeLabel *) self.accessoryView;

        // sets the accessory in the badge
        badgeLabel.text = accessoryValue;
    }
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

- (void)layoutSubviews {
    // calls the super
    [super layoutSubviews];

    // adjusts the badge label's position
    if([self.accessoryTypeString isEqualToString:@"badge_label"] && self.accessoryView) {
        // retrieves the badge label
        HMBadgeLabel *badgeLabel = (HMBadgeLabel *) self.accessoryView;

        // calculates the text size
        CGSize textSize = [badgeLabel.text sizeWithFont:badgeLabel.font];

        // updates the accessory view's frame, this approach
        // assumes that the selected background view is already with
        // a valid position and dimensions
        CGRect frame = CGRectZero;
        frame.origin.x = self.selectedBackgroundView.frame.origin.x + self.selectedBackgroundView.frame.size.width - textSize.width - BADGE_LABEL_ACCESSORY_VALUE_X_MARGIN * 2 - BADGE_LABEL_ACCESSORY_X_MARGIN;
        frame.origin.y = BADGE_LABEL_ACCESSORY_Y_MARGIN;
        frame.size.width = textSize.width + BADGE_LABEL_ACCESSORY_VALUE_X_MARGIN * 2;
        frame.size.height = textSize.height;

        // updates the accessory view's dimensions
        self.accessoryView.frame = frame;
        self.accessoryView.bounds = frame;
    }

    // sets the label fonts and colors
    self.textLabel.font = [UIFont fontWithName:self.descriptionFont size:self.descriptionFontSize];
    self.textLabel.textColor = self.descriptionColor;
    self.detailTextLabel.font = [UIFont fontWithName:self.nameFont size:self.nameFontSize];
    self.detailTextLabel.textColor = self.nameColor;

    // updates the background view position
    [self updateBackgroundViewPosition];
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
    NSUInteger section = [indexPath section];
    NSUInteger numberRows = [tableView numberOfRowsInSection:section];
    NSUInteger row = [indexPath row];

    // retrieves the background view
    HMTableViewCellBackgroundView *backgroundView = (HMTableViewCellBackgroundView *) self.selectedBackgroundView;

    // sets the background view's position
    if(tableView.style == UITableViewStylePlain) {
        [backgroundView setPosition:HMTableViewCellBackgroundViewPositionPlain];
    } else if(row == 0 && numberRows == 1) {
        [backgroundView setPosition:HMTableViewCellBackgroundViewPositionGroupedSingle];
    } else if(row == 0) {
        [backgroundView setPosition:HMTableViewCellBackgroundViewPositionGroupedTop];
    } else if(row == numberRows - 1) {
        [backgroundView setPosition:HMTableViewCellBackgroundViewPositionGroupedBottom];
    } else {
        [backgroundView setPosition:HMTableViewCellBackgroundViewPositionGroupedMiddle];
    }
}

@end
