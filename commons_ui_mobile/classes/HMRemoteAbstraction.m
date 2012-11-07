// Hive Mobile
// Copyright (C) 2008-2012 Hive Solutions Lda.
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

#import "HMRemoteAbstraction.h"

@implementation HMRemoteAbstraction

@synthesize remoteAbstractionId = _remoteAbstractionId;
@synthesize remoteAbstractionStatus = _remoteAbstractionStatus;
@synthesize error = _error;
@synthesize view = _view;
@synthesize remoteDelegate = _remoteDelegate;
@synthesize activity = _activity;
@synthesize activityIndicator = _activityIndicator;
@synthesize url = _url;
@synthesize connection = _connection;
@synthesize receivedData = _receivedData;
@synthesize response = _response;

- (id)init {
    // calls the super
    self = [super init];

    // sets the attributes
    self.remoteAbstractionStatus = HMRemoteAbstractionStatusOpen;

    // returns self
    return self;
}

- (id)initWithId:(int)remoteAbstractionId {
    // calls the super
    self = [super init];

    // sets the attributes
    self.remoteAbstractionId = remoteAbstractionId;
    self.remoteAbstractionStatus = HMRemoteAbstractionStatusOpen;

    // returns self
    return self;
}

- (id)initWithIdAndUrl:(int)remoteAbstractionId url:(NSString *)url {
    // calls the super
    self = [super init];

    // sets the attributes
    self.remoteAbstractionId = remoteAbstractionId;
    self.remoteAbstractionStatus = HMRemoteAbstractionStatusOpen;
    self.url = url;

    // returns self
    return self;
}

- (void)dealloc {
    // releases the activity
    [_activity release];

    // releases the activity indicator
    [_activityIndicator release];

    // releases the url
    [_url release];

    // releases the connection
    [_connection release];

    // releases the connection
    [_receivedData release];

    // releases the response
    [_response release];

    // calls the super
    [super dealloc];
}

- (void)updateRemote {
    // creates the request
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:HM_REMOTE_ABSTRACTION_TIMEOUT];

    // updates the remote with the request
    [self updateRemoteWithRequest:request];
}

- (void)updateRemoteWithRequest:(NSURLRequest *)request {
    // sets the remote abstraction status to pending
    self.remoteAbstractionStatus = HMRemoteAbstractionStatusPending;

    // creates the connection with the intance as delegate
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];

    // creates the received data
    NSMutableData *receivedData = [[NSMutableData alloc] init];

    // shows the activity indicator
    [self showActivityIndicator];

    // sets the attributes
    self.connection = connection;
    self.receivedData = receivedData;

    // releases the objects
    [connection release];
    [receivedData release];
}

- (void)updateRemoteWithData:(NSDictionary *)data method:(NSString *)method setSession:(BOOL)setSession {
    // in case the set session flag is set
    if(setSession) {
        // sets the session in the data and returns
        // the new data object
        data = [self setSessionInData:data];
    }

    // creates the http data from the remote data
    NSData *httpData = [HMHttpUtil createHttpData:data];

    // updates the remote with the given http data
    [self updateRemoteWithHttpData:httpData method:method];
}

- (void)updateRemoteWithSequenceData:(NSArray *)data method:(NSString *)method setSession:(BOOL)setSession {
    // in case the set session flag is set
    if(setSession) {
        // sets the session in the data and returns
        // the new data object
        data = [self setSessionInSequenceData:data];
    }

    // creates the http data from the remote data
    NSData *httpData = [HMHttpUtil createHttpSequenceData:data];

    // updates the remote with the given http data
    [self updateRemoteWithHttpData:httpData method:method];
}

- (void)updateRemoteWithHttpData:(NSData *)httpData method:(NSString *)method {
    // sets the default "target" url
    NSString *targetUrl = self.url;

    // in case the method is get
    if([method isEqualToString:HTTP_GET_METHOD]) {
        // initializes the data string with the contents of the data
        NSString *dataString = [[NSString alloc] initWithData:httpData encoding:NSUTF8StringEncoding];

        // creates the target url with the url and the data string
        targetUrl = [NSString stringWithFormat:@"%@?%@", self.url, dataString];

        // releases the data string
        [dataString release];
    }

    // creates the request to be used in the remote abstraction
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:targetUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:HM_REMOTE_ABSTRACTION_TIMEOUT];

    // in case the method is post
    if([method isEqualToString:HTTP_POST_METHOD]) {
        // sets the http request properties, for a post request
        [request setHTTPMethod:method];
        [request setHTTPBody:httpData];
        [request setValue:HTTP_APPLICATION_URL_ENCODED forHTTPHeaderField:HTTP_CONTENT_TYPE_VALUE];
    }

    // updates the remote with the request
    [self updateRemoteWithRequest:request];
}

- (NSDictionary *)setSessionInData:(NSDictionary *)data {
    // retrieves the preferences
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];

    // sets the session id in the preferences
    NSString *sessionId = [preferences objectForKey:@"sessionId"];

    // in case the data map is not set
    if(data == nil) {
        // allocates a new data map
        data = [[[NSMutableDictionary alloc] init] autorelease];
    }

    // casts the data as a mutable dictionary
    NSMutableDictionary *mutableData = (NSMutableDictionary *) data;

    // sets the session id in the data
    [mutableData setObject:sessionId forKey:@"session_id"];

    // returns the data
    return data;
}

- (NSArray *)setSessionInSequenceData:(NSArray *)sequenceData {
    // retrieves the preferences
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];

    // sets the session id in the preferences
    NSString *sessionId = [preferences objectForKey:@"sessionId"];

    // in case the sequence data array is not set
    if(sequenceData == nil) {
        // allocates a new data array
        sequenceData = [[[NSMutableArray alloc] init] autorelease];
    }

    // casts the data as a mutable array
    NSMutableArray *mutableSequenceData = (NSMutableArray *) sequenceData;

    // adds the session id tuple to the sequence data
    [mutableSequenceData addObject:[NSArray arrayWithObjects:@"session_id", sessionId, nil]];

    // returns the sequence data
    return sequenceData;
}

- (void)cancelRemote {
    // cancels the connection
    [self.connection cancel];

    // hides the activity indicator
    [self hideActivityIndicator];
}

- (void)createActivityIndicator {
    // in case the view is not set
    if(self.view == nil) {
        // returns immediately
        return;
    }

    // creates the activity
    CGRect activityFrame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    UIView *activity = [[UIView alloc] initWithFrame:activityFrame];
    activity.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    activity.backgroundColor = [UIColor blackColor];
    activity.alpha = HM_REMOTE_ABSTRACTION_ACTIVITY_ALPHA;

    // creates the activity indicator
    CGRect activityIndicatorFrame = CGRectMake(self.view.bounds.size.width / 2 - 12, self.view.bounds.size.height / 2 - 12, 24, 24);
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:activityIndicatorFrame];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    activityIndicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;

    // creates the activity structure
    [activity addSubview:activityIndicator];
    [self.view addSubview:activity];

    // sets the attributes
    self.activity = activity;
    self.activityIndicator = activityIndicator;

    // releases the objects
    [activity release];
    [activityIndicator release];
}

- (void)showActivityIndicator {
    // in case the activity indicator is not set
    if(self.activityIndicator == nil) {
        // creates the activity indicator
        [self createActivityIndicator];
    }

    // in case the activity indicator was not created
    if(self.activityIndicator == nil) {
        // returns immediately
        return;
    }

    // shows the activity
    self.activity.hidden = NO;

    // starts animating the activity indicator
    [self.activityIndicator startAnimating];
}

- (void)hideActivityIndicator {
    // in case the activity indicator is not set
    if(self.activityIndicator == nil) {
        // creates the activity indicator
        [self createActivityIndicator];
    }

    // creates the fade out animation
    [UIView beginAnimations:@"fadeOut" context: nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(hideActivityIndicatorComplete)];
    [UIView setAnimationDuration:HM_REMOTE_ABSTRACTION_FADE_TIME];
    self.activity.alpha = 0.0;
    [UIView commitAnimations];

    // stops animating the activity indicator
    [self.activityIndicator stopAnimating];
}

- (void)hideActivityIndicatorComplete {
    // hides the activity
    self.activity.hidden = YES;

    // restores the alpha value
    self.activity.alpha = HM_REMOTE_ABSTRACTION_ACTIVITY_ALPHA;
}

- (void)showActionSheet {
    // in case the view is not set
    if(self.view == nil) {
        // returns immediately
        return;
    }

    // retrieves the (localized) base error message
    NSString *baseErrorMessage = NSLocalizedString(@"ConnectionError", @"ConnectionError");

    // retrieves the localized error description
    NSString *localizedErrorDescription = [self.error localizedDescription];

    // creates the error message from the base error message and the
    // localized error description
    NSString *errorMessage = [NSString stringWithFormat:@"%@\n%@", baseErrorMessage, localizedErrorDescription];

    // creates the action sheet containing the error message and that
    // allows the retry of the action
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:errorMessage delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel") destructiveButtonTitle:NSLocalizedString(@"Retry", @"Retry") otherButtonTitles:nil];
    actionSheet.alpha = 0.75;

    // sets the action sheet style
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;

    // shows the action sheet in the table view
    [actionSheet showInView:self.view];

    // releases the action sheet
    [actionSheet release];
}

- (void)updateView:(UIView *)view {
    // sets the new view
    self.view = view;

    // switches over the remote abstraction
    // status value
    switch(self.remoteAbstractionStatus) {
        // in case the remote abstraction status
        // is pending
        case HMRemoteAbstractionStatusPending:
            // shows the activity indicator
            [self showActivityIndicator];

            // breaks the switch
            break;

        // in case the remote abstraction status
        // is error
        case HMRemoteAbstractionStatusError:
            // shows the action sheet
            [self showActionSheet];

            // breaks the switch
            break;

        default:
            // breaks the switch
            break;
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // adds the data to the received data
    [self.receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // sets the response in the instance
    self.response = response;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // sets the remote abstraction status to closed
    self.remoteAbstractionStatus = HMRemoteAbstractionStatusClosed;

    // calls the remote did succeed method in the remote delegate
    [self.remoteDelegate remoteDidSucceed:self data:self.receivedData connection:self.connection response:self.response];

    // hides the activity indicator
    [self hideActivityIndicator];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // sets the remote abstraction status to error
    self.remoteAbstractionStatus = HMRemoteAbstractionStatusError;

    // sets the error
    self.error = error;

    // shows the action sheet
    [self showActionSheet];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // in case the button click was retry
    if(buttonIndex == 0) {
        // updates the remote
        [self updateRemote];
    }
    // in case the button click was cancel
    else {
        // calls the remote did fail method in the remote delegate
        [self.remoteDelegate remoteDidFail:self data:self.receivedData error:nil];

        // hides the activity indicator
        [self hideActivityIndicator];
    }
}

@end
