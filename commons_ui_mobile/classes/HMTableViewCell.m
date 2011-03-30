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

@synthesize item = _item;
@synthesize accessoryValue = _accessoryValue;
@synthesize height = _height;
@synthesize itemTableView = _itemTableView;

- (id)initWithStyle:(UITableViewCellStyle)cellStyle reuseIdentifier:(NSString *)cellIdentifier {
    // invokes the parent constructor
    self = [super initWithStyle:cellStyle reuseIdentifier:cellIdentifier];

    // sets the default attributes
    self.height = HM_TABLE_VIEW_CELL_HEIGHT;

    // replaces the selected background view
    HMTableViewCellBackgroundView *backgroundView = [[HMTableViewCellBackgroundView alloc] init];
    self.selectedBackgroundView = backgroundView;

    // releases the objects
    [backgroundView release];

    // returns the instance
    return self;
}

- (void)dealloc {
    // releases the item
    [_item release];

    // releases the name
    [_name release];

    // releases the description
    [_description release];

    // releases the icon
    [_icon release];

    // releases the highlighted icon
    [_highlightedIcon release];

    // releases the accessory type string
    [_accessoryTypeString release];

    // calls the super
    [super dealloc];
}

- (void)changeEditing:(BOOL)editing commit:(BOOL)commit {
}

- (void)drawRect:(CGRect)rect {
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

    // invokes the parent
    [super drawRect:rect];
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

- (BOOL)highlightable {
    return _highlightable;
}

- (void)setHighlightable:(BOOL)highlightable {
    // sets the object
    _highlightable = highlightable;

    // in case it's highlightable
    if(highlightable == YES) {
        // changes the selection style to blue
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    // otherwise it's not highlightable
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
    [accessoryTypeString release];

    // sets and retains the object
    _accessoryTypeString = [accessoryTypeString retain];

    // creates the specified accessory type
    if([accessoryTypeString isEqualToString:@"disclosure_indicator"]) {
        // sets the acessory type as the table view
        // cell acessory disclosure indicator
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if([accessoryTypeString isEqualToString:@"switch"]) {
        // creates the notifications switch
        UISwitch *notificationsSwitch = [[UISwitch alloc] init];

        // sets the notifications switch in the accessory view
        self.accessoryView = notificationsSwitch;

        // releases the notifications switch
        [notificationsSwitch release];
    } else if([accessoryTypeString isEqualToString:@"badge_label"]) {
        // creates the badge label and sets it as the accessory view
        HMBadgeLabel *badgeLabel = [[HMBadgeLabel alloc] init];
        badgeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        badgeLabel.text = self.accessoryValue;
        badgeLabel.backgroundColor = [UIColor clearColor];
        badgeLabel.textColor = [UIColor whiteColor];
        badgeLabel.textAlignment = UITextAlignmentCenter;
        badgeLabel.badgeColor = [UIColor colorWithRed:0.54 green:0.56 blue:0.62 alpha:1.0];

        // sets the badge label as the accessory view
        self.accessoryView = badgeLabel;

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
    [accessoryValue release];

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
}

- (void)didMoveToSuperview {
    // calls the super
    [super didMoveToSuperview];

    // retrieves the associated table view (superview)
    self.itemTableView = (HMItemTableView *) self.superview;
}

@end
