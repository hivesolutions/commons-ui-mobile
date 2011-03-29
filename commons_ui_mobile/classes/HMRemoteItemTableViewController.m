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

@synthesize remoteAbstraction = _remoteAbstraction;
@synthesize receivedData = _receivedData;
@synthesize remoteGroup = _remoteGroup;
@synthesize operationType = _operationType;

- (id)init {
    // calls the super
    self = [super init];

    // initializes the structures
    [self initStructures];

    // constructs the structures
    [self constructStructures];

    // returns self
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    // calls the super
    self = [super initWithCoder:aDecoder];

    // initializes the structures
    [self initStructures];

    // constructs the structures
    [self constructStructures];

    // returns self
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    // calls the super
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    // initializes the structures
    [self initStructures];

    // constructs the structures
    [self constructStructures];

    // returns self
    return self;
}

- (id)initWithNibNameAndType:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil operationType:(HMItemOperationType)operationType {
    // calls the super
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    // initializes the structures
    [self initStructures];

    // sets the operation type
    self.operationType = operationType;

    // constructs the structures
    [self constructStructures];

    // returns self
    return self;
}

- (void)dealloc {
    // releases the remote abstraction
    [_remoteAbstraction release];

    // releases the received data
    [_receivedData release];

    // releases the remote group
    [_remoteGroup release];

    // calls the super
    [super dealloc];
}

- (NSString *)getRemoteUrl {
    return nil;
}

- (NSString *)getRemoteUrlForOperation:(HMItemOperationType)operationType {
    return nil;
}

- (void)viewWillAppear:(BOOL)animated {
    // calls the super
    [super viewWillAppear:animated];

    // updates the view in the remote abstraction
    [self.remoteAbstraction updateView:self.tableView.superview];
}

- (void)viewDidAppear:(BOOL)animated {
    // calls the super
    [super viewDidAppear:animated];

    // sets the view appear flag
    _viewAppear = YES;

    // calls the construct structures delayed
    [self constructStructuresDelayed];
}

- (void)viewWillDisappear:(BOOL)animated {
    // hides the toolbar
    [self hideToolbar];

    // sets the view appear flag
    _viewAppear = NO;

    // calls the destroy structures delayed
    [self destroyStructuresDelayed];
}

- (void)initStructures {
    // sets the table view as read
    self.operationType = HMItemOperationRead;

    // sets the remote data as not set
    _remoteDataIsSet = NO;

    // sets the view appear as not set
    _viewAppear = NO;
}

- (void)constructStructures {
    // creates the item table view and sets the item table
    // view provider and the item delegate
    HMItemTableView *itemTableView = (HMItemTableView *) self.tableView;
    itemTableView.itemTableViewProvider = self;
    itemTableView.itemDelegate = self;

    // switches over the operation type
    // in order to create the apropriate
    // components
    switch(self.operationType) {
        // in case it's a create operation
        case HMItemOperationCreate:
            // constructs the create structures
            [self constructCreateStructures];

            // breaks the swtich
            break;

        // in case it's default
        default:
            // breaks the switch
            break;
    }
}

- (void)destroyStructures {
    // switches over the operation type
    // in order to create the apropriate
    // components
    switch(self.operationType) {
        // in case it's a create operation
        case HMItemOperationCreate:
            // destroys the create structures
            [self destroyCreateStructures];

            // breaks the swtich
            break;

        // in case it's default
        default:
            // breaks the switch
            break;
    }
}

- (void)constructStructuresDelayed {
    // in case the remote data is not set
    // or the view is hidden
    if(!_remoteDataIsSet || !_viewAppear) {
        // returns immediately (can't
        // construct without remote data)
        return;
    }

    // switches over the operation type
    // in order to create the apropriate
    // components
    switch(self.operationType) {
        // in case it's a read operation
        case HMItemOperationRead:
            // constructs the read structures
            [self constructReadStructures];

            // breaks the switch
            break;

        // in case it's default
        default:
            break;
    }
}

- (void)destroyStructuresDelayed {
    // in case the remote data is set
    // or the view is hidden
    if(_remoteDataIsSet || !_viewAppear) {
        // returns immediately (can't
        // destroy with remote data)
        return;
    }

    // switches over the operation type
    // in order to create the apropriate
    // components
    switch(self.operationType) {
        // in case it's an read operation
        case HMItemOperationRead:
            // destroys the read structures
            [self destroyReadStructures];

            // breaks the switch
            break;

        // in case it's default
        default:
            break;
    }
}

- (void)constructCreateStructures {
    // creates the cancel bar button
    UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", @"Cancel") style:UIBarButtonItemStylePlain target:self action: @selector(cancelButtonClicked:extra:)];

    // creates the done button
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", @"Done") style:UIBarButtonItemStyleDone target:self action: @selector(doneButtonClicked:extra:)];

    // sets the bar buttons
    self.navigationItem.leftBarButtonItem = cancelBarButton;
    self.navigationItem.rightBarButtonItem = doneBarButton;

    // sets the table view as editing
    self.tableView.editing = YES;

    // processes the empty (data), setting the remote group
    [self processEmpty];

    // reloads the data
    [self.tableView reloadData];

    // releases the objects
    [cancelBarButton release];
    [doneBarButton release];
}

- (void)destroyCreateStructures {
    // unsets the bar buttons
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)constructReadStructures {
    // creates the edit bar button
    UIBarButtonItem *editBarButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Edit", @"Edit") style:UIBarButtonItemStylePlain target:self action: @selector(editButtonClicked:extra:)];

    // sets the bar buttons
    self.navigationItem.rightBarButtonItem = editBarButton;

    // shows the toolbar
    [self showToolbar];

    // releases the objects
    [editBarButton release];
}

- (void)destroyReadStructures {
    // sets the bar buttons
    self.navigationItem.rightBarButtonItem = nil;

    // hides the toolbar
    [self hideToolbar];
}

- (void)processEmpty {
}

- (void)processRemoteData:(NSDictionary *)remoteData {
}

- (NSMutableDictionary *)convertRemoteGroup:(HMItemOperationType)operationType; {
    // retrieves the target operation type based on the given parameter
    // checking for nulls
    HMItemOperationType operationTypeTarget = operationType == HMItemOperationUnset ? self.operationType : operationType;

    // allocates the remote data
    NSMutableDictionary *remoteData = [[NSMutableDictionary alloc] init];

    // switches over the operation type target
    switch(operationTypeTarget) {
        // in case the operation is create
        case HMItemOperationCreate:
            // converts the remote group for read
            [self convertRemoteGroupCreate:remoteData];

            // breaks the switch
            break;

        // in case the operation is read
        case HMItemOperationRead:
            // converts the remote group for read
            [self convertRemoteGroupRead:remoteData];

            // breaks the switch
            break;

        // in case the operation is update
        case HMItemOperationUpdate:
            // converts the remote group for update
            [self convertRemoteGroupUpdate:remoteData];

            // breaks the switch
            break;

        // in case the operation is delete
        case HMItemOperationDelete:
            // converts the remote group for delete
            [self convertRemoteGroupDelete:remoteData];

            // breaks the switch
            break;

        // in case it's default
        default:
            // breaks the switch
            break;
    }

    // returns the remote data in auto release
    return [remoteData autorelease];
}

- (void)convertRemoteGroupCreate:(NSMutableDictionary *)remoteData {
}

- (void)convertRemoteGroupRead:(NSMutableDictionary *)remoteData {
}

- (void)convertRemoteGroupUpdate:(NSMutableDictionary *)remoteData {
}

- (void)convertRemoteGroupDelete:(NSMutableDictionary *)remoteData {
}

- (void)updateRemote {
    // retrieves the remote url
    NSString *remoteUrl = [self getRemoteUrl];

    // creates the remote abstraction using the remote url
    HMRemoteAbstraction *remoteAbstraction = [[HMRemoteAbstraction alloc] initWithIdAndUrl:HMItemOperationRead url:remoteUrl];
    remoteAbstraction.remoteDelegate = self;
    remoteAbstraction.view = self.tableView.superview;

    // sets the attributes
    self.remoteAbstraction = remoteAbstraction;

    // oprens the remote abstraction
    [self.remoteAbstraction updateRemote];

    // releases the objects
    [remoteAbstraction release];
}

- (void)cancelRemote {
    // cancels the remote abstraction
    [self.remoteAbstraction cancelRemote];
}

- (void)showToolbar {
    // shows the navigation controller toolbar
    [self.navigationController setToolbarHidden:NO animated:YES];

    // sets the navigation toolbar tint color
    self.navigationController.toolbar.tintColor = self.navigationController.navigationBar.tintColor;

    // creates the trash item
    UIBarButtonItem *trashItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteButtonClicked:extra:)];

    // sets the trash item style
    trashItem.style = UIBarButtonItemStylePlain;

    // flexible item used to separate the left groups items and right grouped items
    UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    // create the system-defined refresh button
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshButtonClicked:extra:)];

    // sets the system item style
    refreshItem.style = UIBarButtonItemStylePlain;

    // creates the standard text color for toolbar labels
    UIColor *toolbarLabelTextColor = [UIColor whiteColor];

    // creates the standard background color for toolbar labels
    UIColor *toolbarLabelBackgroundColor = [UIColor clearColor];

    // retrieves the updated string
    NSString *updatedString = NSLocalizedString(@"Updated", @"Updated");

    // retrieves the current date
    NSDate *date = [NSDate date];

    // creates the date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    // sets the date formatter for date format
    [dateFormatter setDateFormat:@"dd/MM/yy"];

    // retrieves the date string
    NSString *dateString = [dateFormatter stringFromDate:date];

    // sets the date formatter for hour format
    [dateFormatter setDateFormat:@"HH:mm"];

    // retrieves the hour string
    NSString *hourString = [dateFormatter stringFromDate:date];

    // creates the left toolbar label
    UILabel *leftLabel = [[UILabel alloc] init];
    leftLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    leftLabel.textColor = toolbarLabelTextColor;
    leftLabel.backgroundColor = toolbarLabelBackgroundColor;
    leftLabel.textAlignment = UITextAlignmentCenter;
    leftLabel.text = updatedString;

    // sets size to fit
    [leftLabel sizeToFit];

    // creates the center toolbar label
    UILabel *centerLabel = [[UILabel alloc] init];
    centerLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    centerLabel.textColor = toolbarLabelTextColor;
    centerLabel.backgroundColor = toolbarLabelBackgroundColor;
    centerLabel.textAlignment = UITextAlignmentCenter;
    centerLabel.text = dateString;

    // sets size to fit
    [centerLabel sizeToFit];

    // creates the right toolbar label
    UILabel *rightLabel = [[UILabel alloc] init];
    rightLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    rightLabel.textColor = toolbarLabelTextColor;
    rightLabel.backgroundColor = toolbarLabelBackgroundColor;
    rightLabel.textAlignment = UITextAlignmentCenter;
    rightLabel.text = hourString;

    // sets the size to fit
    [rightLabel sizeToFit];

    // creates the bar button item to host the left label
    UIBarButtonItem *leftLabelItem = [[UIBarButtonItem alloc] initWithCustomView:leftLabel];

    // creates the bar button item to host the center label
    UIBarButtonItem *centerLabelItem = [[UIBarButtonItem alloc] initWithCustomView:centerLabel];

    // creates the bar button item to host the right label
    UIBarButtonItem *rightLabelItem = [[UIBarButtonItem alloc] initWithCustomView:rightLabel];

    // creates the toolbar items list
    NSArray *items = [NSArray arrayWithObjects: trashItem, flexibleSpaceItem, leftLabelItem, centerLabelItem, rightLabelItem, flexibleSpaceItem, refreshItem, nil];

    // sets the toolbar items in the toolbar
    [self.navigationController.toolbar setItems:items animated:NO];

    // releases the objects
    [leftLabelItem release];
    [centerLabelItem release];
    [rightLabelItem release];
    [leftLabel release];
    [centerLabel release];
    [rightLabel release];
    [dateFormatter release];
    [refreshItem release];
    [flexibleSpaceItem release];
    [trashItem release];
}

- (void)hideToolbar {
    // hides the navigation controller toolbar
    [self.navigationController setToolbarHidden:YES animated:YES];
}

- (void)editButtonClicked:(id)sender extra:(id)extra {
    // in case the table view is in editing mode
    if(self.tableView.editing) {
        // sets the table view as not editing
        [self.tableView setEditing:NO animated:YES];

        // casts the table view as item table view
        HMItemTableView *itemTableView = (HMItemTableView *) self.tableView;

        // flushes the item specification
        [itemTableView flushItemSpecification];

        // converts the remote group, retrieving the remote
        // data
        NSDictionary *remoteData = [self convertRemoteGroup:HMItemOperationUpdate];

        // creates the http data from the remote data
        NSData *httpData = [HMHttpUtil createHttpData:remoteData];

        // creates the update url
        NSString *updateUrl = [self getRemoteUrlForOperation:HMItemOperationUpdate];

        // creates the request to be used in the remote abstraction
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:updateUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:HM_REMOTE_ABSTRACTION_TIMEOUT];

        // sets the http request properties, for a post request
        [request setHTTPMethod: HTTP_POST_METHOD];
        [request setHTTPBody:httpData];
        [request setValue:HTTP_APPLICATION_URL_ENCODED forHTTPHeaderField:HTTP_CONTENT_TYPE_VALUE];

        // creates the remote abstraction
        HMRemoteAbstraction *remoteAbstraction = [[HMRemoteAbstraction alloc] initWithId:HMItemOperationUpdate];
        remoteAbstraction.remoteDelegate = self;
        remoteAbstraction.view = self.tableView;

        // updates the remote with the given request
        [remoteAbstraction updateRemoteWithRequest:request];

        // releases the remote abstraction
        [remoteAbstraction release];
    }
    // otherwise it must not be editing
    else {
        // sets the table view as editing
        [self.tableView setEditing:YES animated:YES];
    }
}

- (void)doneButtonClicked:(id)sender extra:(id)extra {
    // in case the table view is not in editing mode (ignore)
    if(!self.tableView.editing) {
        // returns immediately
        return;
    }

    // sets the table view as not editing
    [self.tableView setEditing:NO animated:YES];

    // casts the table view as item table view
    HMItemTableView *itemTableView = (HMItemTableView *) self.tableView;

    // flushes the item specification
    [itemTableView flushItemSpecification];

    // converts the remote group, retrieving the remote
    // data
    NSDictionary *remoteData = [self convertRemoteGroup:HMItemOperationCreate];

    // creates the http data from the remote data
    NSData *httpData = [HMHttpUtil createHttpData:remoteData];

    // creates the create url
    NSString *createUrl = [self getRemoteUrlForOperation:HMItemOperationCreate];

    // creates the request to be used in the remote abstraction
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:createUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:HM_REMOTE_ABSTRACTION_TIMEOUT];

    // sets the http request properties, for a post request
    [request setHTTPMethod: HTTP_POST_METHOD];
    [request setHTTPBody:httpData];
    [request setValue:HTTP_APPLICATION_URL_ENCODED forHTTPHeaderField:HTTP_CONTENT_TYPE_VALUE];

    // creates the remote abstraction
    HMRemoteAbstraction *remoteAbstraction = [[HMRemoteAbstraction alloc] initWithId:HMItemOperationCreate];
    remoteAbstraction.remoteDelegate = self;
    remoteAbstraction.view = self.tableView;

    // updates the remote with the given request
    [remoteAbstraction updateRemoteWithRequest:request];

    // releases the remote abstraction
    [remoteAbstraction release];
}

- (void)cancelButtonClicked:(id)sender extra:(id)extra {
    // dismisses the modal view controller in animated mode
    [self dismissModalViewControllerAnimated:YES];
}

- (void)deleteButtonClicked:(id)sender extra:(id)extra {
    // creates the action sheet
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"ConfirmDeleteError", @"ConfirmDeleteError") delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel") destructiveButtonTitle:NSLocalizedString(@"Delete", @"Delete") otherButtonTitles:nil];
    actionSheet.alpha = 0.75;

    // sets the action sheet style
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;

    // shows the action sheet in the table view
    [actionSheet showFromToolbar:self.navigationController.toolbar];

    // releases the action sheet
    [actionSheet release];
}

- (void)refreshButtonClicked:(id)sender extra:(id)extra {
    // updates the remote provider
    [self updateRemote];
}

- (void)buttonClicked:(NSString *)buttonName {
}

- (HMNamedItemGroup *)getItemSpecification {
    return self.remoteGroup;
}

- (void)didSelectItemRowWithItem:(HMItem *)item {
}

- (void)didDeselectItemRowWithItem:(HMItem *)item {
}

- (void)processOperationRead:(NSData *)data  {
    // creates a new json parser
    SBJsonParser *jsonParser = [[SBJsonParser alloc] init];

    // parses the received (remote) data and sets it into the intance
    NSDictionary *remoteData = [jsonParser objectWithData:data];

    // processes the remote data, setting the remote group
    [self processRemoteData:remoteData];

    // sets the remote data as set
    _remoteDataIsSet = YES;

    // reloads the data
    [self.tableView reloadData];

    // constructs the delayed structures
    [self constructStructuresDelayed];

    // releases the json parser
    [jsonParser release];
}

- (void)processOperationDelete:(NSData *)data  {
    // pops the view controller
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)remoteDidSucceed:(HMRemoteAbstraction *)remoteAbstraction data:(NSData *)data connection:(NSURLConnection *)connection {
    // initializes the data string with the contents of the data
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    // logs the received data
    NSLog(@"%@", dataString);

    // switches over the remote abstraction id
    switch(remoteAbstraction.remoteAbstractionId) {
        case HMItemOperationRead:
            // processes the read operation
            [self processOperationRead:data];

            // breaks the switch
            break;
        case HMItemOperationDelete:
            // processes the delete operation
            [self processOperationDelete:data];

            // breaks the switch
            break;
    }

    // releases the objects
    [dataString release];
}

- (void)remoteDidFail:(HMRemoteAbstraction *)remoteAbstraction data:(NSData *)data error:(NSError *)error {
    // sets the remote data as not set
    _remoteDataIsSet = NO;

    // destroys the delayed structures
    [self destroyStructuresDelayed];

    // reloads the data
    [self.tableView reloadData];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // in case the button click was retry
    if(buttonIndex == 0) {
        // creates the delete url
        NSString *deleteUrl = [self getRemoteUrlForOperation:HMItemOperationDelete];

        // creates the request to be used in the remote abstraction
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:deleteUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:HM_REMOTE_ABSTRACTION_TIMEOUT];

        // sets the http request properties, for a post request
        [request setHTTPMethod: HTTP_POST_METHOD];

        // creates the remote abstraction
        HMRemoteAbstraction *remoteAbstraction = [[HMRemoteAbstraction alloc] initWithId:HMItemOperationDelete];
        remoteAbstraction.remoteDelegate = self;
        remoteAbstraction.view = self.tableView;

        // updates the remote with the given request
        [remoteAbstraction updateRemoteWithRequest:request];

        // releases the remote abstraction
        [remoteAbstraction release];
    }
    // in case the button click was cancel
    else {
    }
}

@end
