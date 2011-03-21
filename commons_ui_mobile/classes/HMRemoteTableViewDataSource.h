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

#import "HMRemoteTableViewProvider.h"

/**
 * The connection timeout for the remote table view.
 */
#define HM_REMOTE_TABLE_VIEW_CONNECTION_TIMEOUT 30.0

/**
 * Class used to represent a table view data source
 * for remote connections with serialization.
 */
@interface HMRemoteTableViewDataSource : NSObject<UITableViewDataSource, UIActionSheetDelegate> {
    @private
    NSObject<HMRemoteTableViewProvider> *_remoteTableViewProvider;
    UITableView *_tableView;
    NSURLConnection *_connection;
    NSMutableData *_receivedData;
    NSArray *_remoteData;
    BOOL remoteDirty;
}

/**
 * The remote table view provider.
 * This table view provider is used to obtain information
 * about the remote node.
 */
@property (assign) IBOutlet NSObject<HMRemoteTableViewProvider> *remoteTableViewProvider;

/**
 * The table view that is associated with this
 * data source.
 */
@property (assign) UITableView *tableView;

/**
 * The currently established connection.
 */
@property (retain) NSURLConnection *connection;

/**
 * The received data at the moment.
 */
@property (retain) NSMutableData *receivedData;

/**
 * The parsed (deserialized) of remote data.
 */
@property (retain) NSArray *remoteData;

/**
 * Constructor of the class.
 *
 * @param remoteTableViewProvider The remote table view
 * provider.
 */
- (id)initWithRemoteTableViewProvider:(NSObject<HMRemoteTableViewProvider> *)remoteTableViewProvider;

/**
 * Updates the remote data, by performing a remote
 * call to the provider.
 */
- (void)updateRemote;

/**
 * Cancels the current remote call.
 */
- (void)cancelRemote;

/**
 * Keeps the class valid for export at link time.
 */
+ (void)_keepAtLinkTime;

@end
