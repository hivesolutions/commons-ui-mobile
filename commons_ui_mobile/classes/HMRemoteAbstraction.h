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

#import "Dependencies.h"

#import "HMRemoteDelegate.h"

/**
 * The connection timeout for the remote abstraction
 * connection.
 */
#define HM_REMOTE_ABSTRACTION_TIMEOUT 30.0

@interface HMRemoteAbstraction : NSObject<UIActionSheetDelegate> {
    @private
    int _remoteAbstractionId;
    UIView *_view;
    NSObject<HMRemoteDelegate> *_remoteDelegate;
    UIView *_activity;
    UIActivityIndicatorView *_activityIndicator;
    NSString *_url;
    NSURLConnection *_connection;
    NSMutableData *_receivedData;
}

/**
 * The associated remote abstraction id.
 */
@property (assign) int remoteAbstractionId;

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

@end
