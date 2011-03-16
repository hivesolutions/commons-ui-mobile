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

#import "HMItemTableViewDataSource.h"
#import "HMItemTableView.h"

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

    // creats the header view
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 72)];
    header.contentMode = UIViewContentModeScaleToFill;
    header.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;

    // creates the image frame
    CGRect imageFrame = CGRectMake(20, 15, 64, 64);

    // creates the image view
    UIImageView *image = [[UIImageView alloc] initWithFrame:imageFrame];
    image.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
    image.image = [UIImage imageNamed:@"user.png"];
    image.backgroundColor = [UIColor clearColor];

    // sets the header image rounded corners
    image.layer.cornerRadius = 4.0;
    image.layer.masksToBounds = YES;
    image.layer.borderColor = [UIColor lightGrayColor].CGColor;
    image.layer.borderWidth = 1.0;

    // creates the label frame
    CGRect labelFrame = CGRectMake(103, 34, 197, 24);

    // creates the label view
    UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    label.text = @"Accenture";
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Helvetica" size:19];
    label.shadowColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(0, 1);

    header.backgroundColor = [UIColor clearColor];
    header.opaque = NO;

    // adds the sub views
    [header addSubview:image];
    [header addSubview:label];

    // sets the table header
    self.tableHeaderView = header;

    // releases the objects
    [image release];
    [label release];
    [header release];

    // returns self
    return self;
}

- (void)dealloc {
    // releases the item data source
    [_itemDataSource release];

    // calls the super
    [super dealloc];
}

- (NSObject<HMItemTableViewProvider> *)itemTableViewProvider {
    return _itemTableViewProvider;
}

- (void)setItemTableViewProvider:(NSObject<HMItemTableViewProvider> *)itemTableViewProvider {
    // sets the object
    _itemTableViewProvider = itemTableViewProvider;

    // creates and sets the item table view data source
    // from the item table view provider
    HMItemTableViewDataSource *itemDataSource = [[HMItemTableViewDataSource alloc] initWithItemTableViewProvider:itemTableViewProvider];

    // sets the attributes
    self.itemDataSource = itemDataSource;
    self.dataSource = itemDataSource;

    // sets the current instance as the delegate to the table view
    self.delegate = self;

    // releases the objects
    [itemDataSource release];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // rettrieves the item specification
    HMItemGroup *itemSpecification = self.itemDataSource.itemSpecification;

    // retrieves the button item
    HMButtonItem *buttonItem = (HMButtonItem *) [itemSpecification getItem:indexPath];

    // calls the did select item row with item method
    [self.itemDelegate didSelectItemRowWithItem:buttonItem];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    // rettrieves the item specification
    HMItemGroup *itemSpecification = self.itemDataSource.itemSpecification;

    // retrieves the button item
    HMButtonItem *buttonItem = (HMButtonItem *) [itemSpecification getItem:indexPath];

    // calls the did deselect item row with item method
    [self.itemDelegate didDeselectItemRowWithItem:buttonItem];
}

+ (void)_keepAtLinkTime {
}

@end
