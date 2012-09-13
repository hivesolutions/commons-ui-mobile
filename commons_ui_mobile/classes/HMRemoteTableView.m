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
// __revision__  = $LastChangedRevision$
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008-2012 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "HMRemoteTableView.h"

@implementation HMRemoteTableView

@synthesize remoteDataSource = _remoteDataSource;
@synthesize remoteDelegate = _remoteDelegate;
@synthesize searchBar = _searchBar;

- (void)dealloc {
    // cancels any pending remote connections in the
    // remote data source
    [self.remoteDataSource cancelRemote];

    // releases the remote data source
    [_remoteDataSource release];

    // releases the search bar
    [_searchBar release];

    // calls the supper
    [super dealloc];
}

- (void)constructStructures {
    // calls the super
    [super constructStructures];

    // constructs the view
    [self constructView];
}

- (void)constructView {
    // creates the search bar
    CGRect searchBarFrame = CGRectMake(0, 0, 320, 44);
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:searchBarFrame];
    searchBar.placeholder = NSLocalizedString(@"Search", @"Search");
    searchBar.tintColor = [UIColor lightGrayColor];

    // sets the auto resizing mask in the search bar
    searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;

    // sets the search abr delegate as self
    searchBar.delegate = self;

    // adds the search bar as the table header view
    self.tableHeaderView = searchBar;

    // sets the attributes
    self.searchBar = searchBar;

    // releases the objects
    [searchBar release];
}

- (NSObject<HMRemoteTableViewProvider> *)remoteTableViewProvider {
    return _remoteTableViewProvider;
}

- (void)setRemoteTableViewProvider:(NSObject<HMRemoteTableViewProvider> *)remoteTableViewProvider {
    // sets the object
    _remoteTableViewProvider = remoteTableViewProvider;

    // creates and sets the remote table view data source
    // from the remote table view provider
    HMRemoteTableViewDataSource *remoteDataSource = [[HMRemoteTableViewDataSource alloc] initWithRemoteTableViewProvider:remoteTableViewProvider];
    remoteDataSource.tableView = self;

    // sets the attributes
    self.remoteDataSource = remoteDataSource;
    self.dataSource = remoteDataSource;

    // sets the current instance as the delegate to the table view
    self.delegate = self;

    // retrieves the item title name
    NSString *itemTitleName = [self.remoteTableViewProvider getItemTitleName];

    // sets the item title name as the filter name
    self.remoteDataSource.filterName = itemTitleName;

    // releases the objects
    [remoteDataSource release];
}

- (void)willAppear {
    // calls the super
    [super willAppear];

    // calls the update remote
    [self.remoteDataSource updateRemote];

    // sets the search bar as the table header view
    // re-setting the search bar avoids problems when
    // changing the visibility of the view while focusing
    // in the search bar
    self.tableHeaderView = self.searchBar;
}

- (void)willDisappear {
    // calls the super
    [super willDisappear];

    // resigns the search bar as first responder (no focus)
    [self.searchBar resignFirstResponder];
}

- (void)reloadData {
    // calls the super
    [super reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // retrieves the remote data
    NSArray *remoteData = self.remoteDataSource.remoteData;

    // retrieves the index path row
    NSInteger row = indexPath.row;

    // retrieves the remote data item from the remote data at the row
    NSMutableDictionary *remoteDataItem = [remoteData objectAtIndex:row];

    // calls the did select remote row with data method
    [self.remoteDelegate didSelectRemoteRowWithData:remoteDataItem];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    // retrieves the remote data
    NSArray *remoteData = self.remoteDataSource.remoteData;

    // retrieves the index path row
    NSInteger row = indexPath.row;

    // retrieves the remote data item from the remote data at the row
    NSMutableDictionary *remoteDataItem = [remoteData objectAtIndex:row];

    // calls the did deselect remote row with data method
    [self.remoteDelegate didDeselectRemoteRowWithData:remoteDataItem];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    // sets the filter value from the search bar text
    self.remoteDataSource.filterValue = searchBar.text;

    // updates the remote in forced mode
    [self.remoteDataSource updateRemoteForced];
}

@end
