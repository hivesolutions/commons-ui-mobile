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

#import "HMItemTableView.h"

#import "HMItemTableViewDataSource.h"

@implementation HMItemTableView

@synthesize itemDataSource = _itemDataSource;
@synthesize itemDelegate = _itemDelegate;

- (id)init {
    // calls the super
    self = [super init];

    // returns self
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    // calls the super
    self = [super initWithCoder:aDecoder];

    // returns self
    return self;
}

- (NSObject<HMItemTableViewProvider> *)itemTableViewProvider {
    return _itemTableViewProvider;
}

- (void)setItemTableViewProvider:(NSObject<HMItemTableViewProvider> *)itemTableViewProvider {
    _itemTableViewProvider = itemTableViewProvider;

    // creates and sets the item table view data source
    // from the item table view provider
    self.itemDataSource = [[HMItemTableViewDataSource alloc] initWithItemTableViewProvider:itemTableViewProvider];
    self.dataSource = self.itemDataSource;

    // sets the current instance as the delegate to the table view
    self.delegate = self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // rettrieves the item specification
    HMItemGroup *itemSpecification = self.itemDataSource.itemSpecification;

    // retrieves the button item
    HMButtonItem *buttonItem = (HMButtonItem *) [itemSpecification getItem:indexPath];

    // retrieves the selected cell
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];

    // changes the cell's icon
    UIImage *iconImage = [UIImage imageNamed:buttonItem.highlightedIcon];
    cell.imageView.image = iconImage;

    // calls the did select item row with item method
    [self.itemDelegate didSelectItemRowWithItem:buttonItem];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    // rettrieves the item specification
    HMItemGroup *itemSpecification = self.itemDataSource.itemSpecification;

    // retrieves the button item
    HMButtonItem *buttonItem = (HMButtonItem *) [itemSpecification getItem:indexPath];

    // retrieves the deselected cell
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];

    // changes the cell's icon
    UIImage *iconImage = [UIImage imageNamed:buttonItem.icon];
    cell.imageView.image = iconImage;

    // calls the did deselect item row with item method
    [self.itemDelegate didDeselectItemRowWithItem:buttonItem];
}

+ (void)_keepAtLinkTime {
}

@end
