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

#import "HMRemoteTableViewDataSource.h"

@implementation HMRemoteTableViewDataSource

@synthesize remoteTableViewProvider = _remoteTableViewProvider;
@synthesize tableView = _tableView;
@synthesize connection = _connection;
@synthesize receivedData = _receivedData;
@synthesize remoteData = _remoteData;

- (id)init {
    // calls the super
    self = [super init];

    // sets the remote dirty
    _remoteDirty = YES;

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
    // releases the connection
    [_connection release];

    // releases the received data
    [_receivedData release];

    // releases the remote data
    [_remoteData release];

    // calls the supper
    [super dealloc];
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

    // creates the request
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:remoteUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:HM_REMOTE_TABLE_VIEW_CONNECTION_TIMEOUT];

    // creates the connection with the intance as delegate
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];

    // creates the received data
    NSMutableData *receivedData = [[NSMutableData alloc] init];

    // creates a "new" remote data and initializes it
    NSArray *remoteData = [[NSArray alloc] init];

    // sets the attributes
    self.connection = connection;
    self.receivedData = receivedData;
    self.remoteData = remoteData;

    // unsets the remote dirty flag
    _remoteDirty = NO;

    // releases the objects
    [connection release];
    [receivedData release];
    [remoteData release];
}

- (void)cancelRemote {
    // cancels the connection
    [self.connection cancel];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // sets the table view
    self.tableView = tableView;

    // updates the remote (if necessary)
    [self updateRemote];

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
    if (cell == nil) {
        // creates the new cell with the given reuse identifier
        cell = [[[HMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }

    // retrieves the index path row
    NSInteger pathRow = indexPath.row;

    // retrieves the user
    NSMutableDictionary *user = [self.remoteData objectAtIndex:pathRow];

    // retrieves the username for the first user
    NSMutableString *username = [user objectForKey:@"username"];

    // sets the text label text
    cell.textLabel.text = username;

    // returns the cell
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.remoteData count];
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

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // adds the data to the received data
    [self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // creates a new json parser
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];

    // parses the received (remote) data and sets it into the intance
    self.remoteData = [jsonParser objectWithData:self.receivedData];

    // reloads the data
    [self.tableView reloadData];

    // releases the json parser
    [jsonParser release];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // retrieves the (localized) base error message
    NSString *baseErrorMessage = NSLocalizedString(@"ConnectionError", @"ConnectionError");

    // retrieves the localized error description
    NSString *localizedErrorDescription = [error localizedDescription];

    // creates the error message from the base error message and the
    // localized error description
    NSString *errorMessage = [NSString stringWithFormat:@"%@\n%@", baseErrorMessage, localizedErrorDescription];

    // creates the action sheet
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:errorMessage delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel") destructiveButtonTitle:NSLocalizedString(@"Retry", @"Retry") otherButtonTitles:nil];
    actionSheet.alpha = 0.75;

    // sets the action sheet style
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;

    // shows the action sheet in the table view
    [actionSheet showInView:self.tableView];

    // releases the action sheet
    [actionSheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // in case the button click was retry
    if(buttonIndex == 0) {
        // sets the remote dirty flag
        _remoteDirty = YES;

        // updates the remote
        [self updateRemote];
    }
    // in case the button click was cancel
    else {
        // reloads the data
        [self.tableView reloadData];
    }
}

+ (void)_keepAtLinkTime {
}

@end
