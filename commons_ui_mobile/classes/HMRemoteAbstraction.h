// Hive Mobile
// Copyright (c) 2008-2016 Hive Solutions Lda.
//
// This file is part of Hive Mobile.
//
// Hive Mobile is free software: you can redistribute it and/or modify
// it under the terms of the Apache License as published by the Apache
// Foundation, either version 2.0 of the License, or (at your option) any
// later version.
//
// Hive Mobile is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// Apache License for more details.
//
// You should have received a copy of the Apache License along with
// Hive Mobile. If not, see <http://www.apache.org/licenses/>.

// __author__    = João Magalhães <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision$
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008-2016 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "Dependencies.h"

#import "HMRemoteDelegate.h"

/**
 * The http get method name.
 */
#define HTTP_GET_METHOD @"GET"

/**
 * The http post method name.
 */
#define HTTP_POST_METHOD @"POST"

/**
 * The http valid status code.
 */
#define HTTP_VALID_STATUS_CODE 200

/**
 * The http application url encoded mime type.
 */
#define HTTP_APPLICATION_URL_ENCODED @"application/x-www-form-urlencoded"

/**
 * The http content type value.
 */
#define HTTP_CONTENT_TYPE_VALUE @"content-type"

/**
 * The connection timeout for the remote abstraction
 * connection.
 */
#define HM_REMOTE_ABSTRACTION_TIMEOUT 30.0

/**
 * The alpha value to be used in the activity.
 */
#define HM_REMOTE_ABSTRACTION_ACTIVITY_ALPHA 0.75

/**
 * The fade time to be used in the activity.
 */
#define HM_REMOTE_ABSTRACTION_FADE_TIME 0.5

/**
 * Enumeration defining the various status
 * for the remote abstraction.
 */
typedef enum {
    HMRemoteAbstractionStatusOpen = 1,
    HMRemoteAbstractionStatusPending,
    HMRemoteAbstractionStatusClosed,
    HMRemoteAbstractionStatusError
} HMRemoteAbstractionStatus;

/**
 * Provides an abstraction for interacting with a remote host.
 */
@interface HMRemoteAbstraction : NSObject<UIActionSheetDelegate> {
    @private
    int _remoteAbstractionId;
    HMRemoteAbstractionStatus _remoteAbstractionStatus;
    NSError *_error;
    UIView *_view;
    NSObject<HMRemoteDelegate> *_remoteDelegate;
    UIView *_activity;
    UIActivityIndicatorView *_activityIndicator;
    NSString *_url;
    NSURLConnection *_connection;
    NSMutableData *_receivedData;
    NSURLResponse *_response;
}

/**
 * The associated remote abstraction id.
 */
@property (assign) int remoteAbstractionId;

/**
 * The associated remote abstraction status.
 */
@property (assign) HMRemoteAbstractionStatus remoteAbstractionStatus;

/**
 * The error associated with the last call.
 */
@property (retain) NSError *error;

/**
 * The associated view.
 */
@property (assign) UIView *view;

/**
 * The associated remote delegate.
 */
@property (assign) NSObject<HMRemoteDelegate> *remoteDelegate;

/**
 * The view to be used as loading mask during
 * the remote call process.
 */
@property (retain) UIView *activity;

/**
 * The activity indicator used for the loading
 * mask information.
 */
@property (retain) UIActivityIndicatorView *activityIndicator;

/**
 * The associated url.
 */
@property (retain) NSString *url;

/**
 * The currently established connection.
 */
@property (retain) NSURLConnection *connection;

/**
 * The received data at the moment.
 */
@property (retain) NSMutableData *receivedData;

/**
 * The received response from the connection.
 */
@property (retain) NSURLResponse *response;

/**
 * Constructor fo the class.
 *
 * @param remoteAbstractionId The id describing the remote abstraction.
 * @return The created instance.
 */
- (id)initWithId:(int)remoteAbstractionId;

/**
 * Constructor fo the class.
 *
 * @param remoteAbstractionId The id describing the remote abstraction.
 * @param url The url to be used by the remote abstraction.
 * @return The created instance.
 */
- (id)initWithIdAndUrl:(int)remoteAbstractionId url:(NSString *)url;

/**
 * Updates the remote data, by performing a remote
 * call to the provider.
 */
- (void)updateRemote;

/**
 * Updates the remote data, using the given
 * request.
 *
 * @param request The request to be in the
 * update of the data.
 */
- (void)updateRemoteWithRequest:(NSURLRequest *)request;

/**
 * Updates the remote data, using the given
 * http data.
 *
 * @param httpData The http data to be used in the update.
 * @param method The http method to be used to perform the request.
 */
- (void)updateRemoteWithHttpData:(NSData *)httpData method:(NSString *)method;

/**
 * Updates the remote data, using the given
 * data.
 *
 * @param data The data to be used in the update.
 * @param method The http method to be used to perform the request.
 * @param setSession If the session information should be set in the data.
 */
- (void)updateRemoteWithData:(NSDictionary *)data method:(NSString *)method setSession:(BOOL)setSession;

/**
 * Updates the remote data, using the given
 * sequence data.
 *
 * @param data The data to be used in the update.
 * @param method The http method to be used to perform the request.
 * @param setSession If the session information should be set in the data.
 */
- (void)updateRemoteWithSequenceData:(NSArray *)data method:(NSString *)method setSession:(BOOL)setSession;

/**
 * Sets the session information in the data map.
 *
 * @param data The map to hold the data information.
 * @return The new data map with the session information.
 */
- (NSDictionary *)setSessionInData:(NSDictionary *)data;

/**
 * Sets the session information in the sequence data array.
 *
 * @param data The array to hold the data information.
 * @return The new data map with the session information.
 */
- (NSArray *)setSessionInSequenceData:(NSArray *)sequenceData;

/**
 * Updates the view associated with the remote
 * abstraction this update triggers the activity indicator
 * or the activity sheet in case it's necessary.
 *
 * @param view The view to be used in the update.
 */
- (void)updateView:(UIView *)view;

/**
 * Cancels the current remote call.
 */
- (void)cancelRemote;

/**
 * Creates the activity indicator to be used
 * in the current remote table context.
 */
- (void)createActivityIndicator;

/**
 * Shows the current activity indicator.
 */
- (void)showActivityIndicator;

/**
 * Hides the current activity indicator.
 */
- (void)hideActivityIndicator;

/**
 * Called uppon the end of the hiding of the
 * activity indicator.
 */
- (void)hideActivityIndicatorComplete;

/**
 * Shows the action sheet modal box for retry.
 */
- (void)showActionSheet;

@end
