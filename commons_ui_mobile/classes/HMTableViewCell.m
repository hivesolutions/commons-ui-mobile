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

#import "HMTableCellBackgroundView.h"
#import "HMTableViewCell.h"

@implementation HMTableViewCell

@synthesize iconImage = _iconImage;
@synthesize highlightedIconImage = _highlightedIconImage;

- (UITableViewCell *)initWithStyle:(UITableViewCellStyle)cellStyle reuseIdentifier:(NSString *)cellIdentifier {
    // invokes the parent constructor
    self = [super initWithStyle:cellStyle reuseIdentifier:cellIdentifier];

    // replaces the selected background view
    HMTableCellBackgroundView *backgroundView = [[HMTableCellBackgroundView alloc] init];
    self.selectedBackgroundView = backgroundView;

    // returns the instance
    return self;
}

- (UITableViewCell *)initWithStyle:(UITableViewCellStyle)cellStyle reuseIdentifier:(NSString *)cellIdentifier name:(NSString *)name icon:(NSString *)icon highlightedIcon:(NSString *)highlightedIcon {
    // invokes the parent constructor
    self = [super initWithStyle:cellStyle reuseIdentifier:cellIdentifier];

    // replaces the selected background view
    HMTableCellBackgroundView *backgroundView = [[HMTableCellBackgroundView alloc] init];
    self.selectedBackgroundView = backgroundView;

    // sets the cell's text label
    self.textLabel.text = name;

    // initializes the icon images
    self.iconImage = nil;
    self.highlightedIconImage = nil;

    // creates the icon image and sets it in the image view
    if(icon) {
        self.iconImage = [UIImage imageNamed:icon];
        self.imageView.image = self.iconImage;
    }

    // creates the highlighted icon image
    if(highlightedIcon) {
        self.highlightedIconImage = [UIImage imageNamed:highlightedIcon];
    }

    // returns the instance
    return self;
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
    HMTableCellBackgroundView *backgroundView = (HMTableCellBackgroundView *) self.selectedBackgroundView;

    // sets the background view's position
    if(tableView.style == UITableViewStylePlain) {
        [backgroundView setPosition:HMTableCellBackgroundViewPositionPlain];
    } else if(row == 0 && numberRows == 1) {
        [backgroundView setPosition:HMTableCellBackgroundViewPositionGroupedSingle];
    } else if(row == 0) {
        [backgroundView setPosition:HMTableCellBackgroundViewPositionGroupedTop];
    } else if(row == numberRows - 1) {
        [backgroundView setPosition:HMTableCellBackgroundViewPositionGroupedBottom];
    } else {
        [backgroundView setPosition:HMTableCellBackgroundViewPositionGroupedMiddle];
    }

    // invokes the parent
    [super drawRect:rect];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    // invokes the parent function
    [super setSelected:selected animated:animated];

    // updates the cell's icon
    if(selected && self.highlightedIconImage) {
        self.imageView.image = self.highlightedIconImage;
    } else if(self.iconImage) {
        self.imageView.image = self.iconImage;
    }
}

@end
