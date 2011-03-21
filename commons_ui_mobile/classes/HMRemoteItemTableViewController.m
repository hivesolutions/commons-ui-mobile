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

#import "HMRemoteItemTableViewController.h"

@implementation HMRemoteItemTableViewController

@synthesize receivedData = _receivedData;
@synthesize remoteGroup = _remoteGroup;
@synthesize editable = _editable;

- (id)init {
    // calls the super
    self = [super init];

    // sets the table view as editable
    self.editable = YES;

    // constructs the structures
    [self constructStructures];

    // returns self
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    // calls the super
    self = [super initWithCoder:aDecoder];

    // sets the table view as editable
    self.editable = YES;

    // constructs the structures
    [self constructStructures];

    // returns self
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    // calls the super
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    // sets the table view as editable
    self.editable = YES;

    // constructs the structures
    [self constructStructures];

    // returns self
    return self;
}

- (void)dealloc {
    // releases the received data
    [self.receivedData release];

    // releases the remote group
    [self.remoteGroup release];

    // calls the super
    [super dealloc];
}

- (NSString *)getRemoteUrl {
    return nil;
}

- (void)constructStructures {
    // creates the item table view and sets the item table
    // view provider and the item delegate
    HMItemTableView *itemTableView = (HMItemTableView *) self.tableView;
    itemTableView.itemTableViewProvider = self;
    itemTableView.itemDelegate = self;

    // in case the current table view is editable
    if(self.editable) {
        // creates the edit ui bar button
        UIBarButtonItem *editUiBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:   @selector(editButtonClick:extra:)];

        // sets the edit ui bar button
        self.navigationItem.rightBarButtonItem = editUiBarButton;
    }
}

- (void)processRemoteData:(NSDictionary *)remoteData {
}

- (void)editButtonClick:(id)sender extra:(id)extra {
    // in case the table view is in editing mode
    if(self.tableView.editing) {
        // sets the table view as not editing
        [self.tableView setEditing:NO animated:YES];
    }
    // otherwise it must not be editing
    else {
        // sets the table view as editing
        [self.tableView setEditing:YES animated:YES];
    }
}

- (void) updateRemote {
    // retrieves the remote url
    NSString *remoteUrl = [self getRemoteUrl];

    // creates the request
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:remoteUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];

    // creates the connection with the intance as delegate
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];

    // creates the received data
    NSMutableData *receivedData = [[NSMutableData alloc] init];

    // creates a "new" remote data and initializes it
    NSArray *remoteData = [[NSArray alloc] init];

    // sets the attributes
    //self.connection = connection;
    self.receivedData = receivedData;
    //self.remoteData = remoteData;

    // unsets the remote dirty flag
    //remoteDirty = NO;

    // releases the objects
    [connection release];
    [receivedData release];
    [remoteData release];
}

- (HMNamedItemGroup *)getItemSpecification {
    return self.remoteGroup;
}

- (void)didSelectItemRowWithItem:(HMItem *)item {
}

- (void)didDeselectItemRowWithItem:(HMItem *)item {
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // adds the data to the received data
    [self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // creates a new json parser
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];

    // parses the received (remote) data and sets it into the intance
    NSDictionary *remoteData = [jsonParser objectWithData:self.receivedData];

    // processes the remote data, setting the remote group
    [self processRemoteData:remoteData];

    // reloads the data
    [self.tableView reloadData];

    // releases the json parser
    [jsonParser release];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
}

+ (void)_keepAtLinkTime {
}

@end
