// Hive Mobile
// Copyright (C) 2008-2015 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2015 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "HMRemoteTableViewDataSource.h"

@implementation HMRemoteTableViewDataSource

@synthesize remoteTableViewProvider = _remoteTableViewProvider;
@synthesize remoteAbstraction = _remoteAbstraction;
@synthesize remoteData = _remoteData;
@synthesize filterType = _filterType;
@synthesize filterName = _filterName;
@synthesize filterValue = _filterValue;

- (id)init {
    // calls the super
    self = [super init];

    // returns self
    return self;
}

- (id)initWithRemoteTableViewProvider:(NSObject<HMRemoteTableViewProvider> *)remoteTableViewProvider {
    // calls the default contructor
    self = [self init];

    // sets the attributes
    self.remoteTableViewProvider = remoteTableViewProvider;

    // returns self
    return self;
}

- (void)dealloc {
    // releases the remote abstraction
    [_remoteAbstraction release];

    // releases the remote data
    [_remoteData release];

    // releases the filter type
    [_filterType release];

    // releases the filter name
    [_filterName release];

    // releases the filter value
    [_filterValue release];

    // calls the supper
    [super dealloc];
}

- (void)initStructures {
    // calls the super
    [super initStructures];

    // sets the remote dirty
    _remoteDirty = YES;

    // sets the default filter type
    self.filterType = @"like";
}

- (void)updateRemote {
    // in case the remote dirty flag is
    // not set
    if(_remoteDirty == NO) {
        // returns immeditely
        return;
    }

    // retrieves the remote url from the remote table view provider
    NSString *remoteUrl = [self.remoteTableViewProvider getRemoteUrl];

    // the filter dictionary to be used in the url
    NSMutableDictionary *urlData = [[NSMutableDictionary alloc] init];

    // in case the filter value is defined and
    // not empty
    if(self.filterValue && self.filterValue.length > 0) {
        NSString *filter = [NSString stringWithFormat:@"%@:%@:%@", self.filterName, self.filterType, self.filterValue];
        [urlData setObject:filter forKey:@"filters[]"];
    }

    // sets the number of records to be retrieved
    [urlData setObject:@"0" forKey:@"start_record"];
    [urlData setObject:@"30" forKey:@"number_records"];

    // creates the remote abstraction using the remote url
    HMRemoteAbstraction *remoteAbstraction = [[HMRemoteAbstraction alloc] initWithIdAndUrl:HMItemOperationUnset url:remoteUrl];
    remoteAbstraction.remoteDelegate = self;
    remoteAbstraction.view = self.tableView.superview;

    // sets the attributes
    self.remoteAbstraction = remoteAbstraction;

    // updates the remote abstraction with the url data
    [self.remoteAbstraction updateRemoteWithData:urlData method:HTTP_GET_METHOD setSession:YES];

    // unsets the remote dirty flag
    _remoteDirty = NO;

    // releases the objects
    [urlData release];
    [remoteAbstraction release];
}

- (void)updateRemoteForced {
    // sets the remote dirty flag
    _remoteDirty = YES;

    // updates the remote
    [self updateRemote];
}

- (void)cancelRemote {
    // cancels the remote abstraction
    [self.remoteAbstraction cancelRemote];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // returns the number of sections
    return 1;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [[[NSArray alloc] init] autorelease];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // creates the cell identifier
    static NSString *cellIdentifier = @"Cell";

    // tries to retrives the cell from cache (reusable)
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    // in case the cell is not defined in the cuurrent cache
    // need to create a new cell
    if(cell == nil) {
        // creates the colors
        UIColor *lightGreenColor = [UIColor colorWithRed:0.66 green:0.85 blue:0.36 alpha:1];
        UIColor *darkGreenColor = [UIColor colorWithRed:0.23 green:0.62 blue:0.27 alpha:1];

        // creates the selected background colors
        NSArray *selectedBackgroundColors = [[NSArray alloc] initWithObjects:lightGreenColor, darkGreenColor, nil];

        // creates the new cell with the given reuse identifier
        HMTableViewCell *tableViewCell = [[[HMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        tableViewCell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        tableViewCell.selectedBackgroundColors = selectedBackgroundColors;
        cell = tableViewCell;

        // releases the selected background colors
        [selectedBackgroundColors release];
    }

    // retrieves the index path row
    NSInteger pathRow = indexPath.row;

    // retrieves the (current) item
    NSMutableDictionary *item = [self.remoteData objectAtIndex:pathRow];

    // retrieves the item title name from the remote table view provider
    NSString *itemTitleName = [self.remoteTableViewProvider getItemTitleName];

    // retrieves the title for the item
    NSMutableString *title = [item objectForKey:itemTitleName];

    // sets the text label text
    cell.textLabel.text = title;

    // returns the cell
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.remoteData.count;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}

- (void)remoteDidSucceed:(HMRemoteAbstraction *)remoteAbstraction data:(NSData *)data connection:(NSURLConnection *)connection response:(NSURLResponse *)response {
    // creates a new json parser
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];

    // parses the received (remote) data and sets it into the intance
    self.remoteData = [jsonParser objectWithData:data];

    // casts the response as http response
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;

    // in case the status code is valid
    if(httpResponse.statusCode == HTTP_VALID_STATUS_CODE) {
        // reloads the data
        [self.tableView reloadData];
    }
    // otherwise there must be a problem
    else {
        // casts the table view (safe)
        HMTableView *tableView = (HMTableView *) self.tableView;

        // retrieves the view controller from the table view
        UIViewController *viewController = tableView.viewController;

        // handles the error data
        [HMErrorAbstraction handleErrorData:self.remoteData authenticationDelegate:self view:self.tableView.superview viewController:viewController];
    }

    // releases the json parser
    [jsonParser release];
}

- (void)remoteDidFail:(HMRemoteAbstraction *)remoteAbstraction data:(NSData *)data error:(NSError *)error {
    // reloads the data
    [self.tableView reloadData];
}

- (void)authenticationComplete:(BOOL)result {
    // in case the authenticaion fails must
    // return immediately (nothing to be done)
    if(result == NO) { return; }

    // updates the remote table (forced)
    [self updateRemoteForced];
}

@end
