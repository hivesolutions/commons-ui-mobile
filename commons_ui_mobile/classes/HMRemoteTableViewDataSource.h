// Hive Mobile
// Copyright (c) 2008-2017 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2017 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "Dependencies.h"

#import "HMTableViewCell.h"
#import "HMRemoteDelegate.h"
#import "HMRemoteAbstraction.h"
#import "HMApplicationDelegate.h"
#import "HMTableViewDataSource.h"
#import "HMAuthenticationDelegate.h"
#import "HMRemoteTableViewProvider.h"
#import "HMAuthenticationViewController.h"

/**
 * Represents a table view data source
 * for remote connections with serialization.
 */
@interface HMRemoteTableViewDataSource : HMTableViewDataSource<HMRemoteDelegate, HMAuthenticationDelegate> {
    @private
    NSObject<HMRemoteTableViewProvider> *_remoteTableViewProvider;
    HMRemoteAbstraction *_remoteAbstraction;
    NSArray *_remoteData;
    NSString *_filterType;
    NSString *_filterName;
    NSString *_filterValue;
    BOOL _remoteDirty;
}

/**
 * The remote table view provider.
 * This table view provider is used to obtain information
 * about the remote node.
 */
@property (assign) IBOutlet NSObject<HMRemoteTableViewProvider> *remoteTableViewProvider;

/**
 * The remote abstraction to be used for controlling
 * the remote calls.
 */
@property (retain) HMRemoteAbstraction *remoteAbstraction;

/**
 * The parsed (deserialized) of remote data.
 */
@property (retain) NSArray *remoteData;

/**
 * The type to be used to filter the values.
 */
@property (retain) NSString *filterType;

/**
 * The name to be used to filter the values.
 */
@property (retain) NSString *filterName;

/**
 * The value to be used to filter the values.
 */
@property (retain) NSString *filterValue;

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
 * Updates the remote data, by performing a remote
 * call to the provider.
 * This method forces the update remote behaviour (ignoring
 * the current flag value).
 */
- (void)updateRemoteForced;

/**
 * Cancels the current remote call.
 */
- (void)cancelRemote;

@end
