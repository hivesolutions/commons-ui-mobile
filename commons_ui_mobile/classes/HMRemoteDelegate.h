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

@class HMRemoteAbstraction;

/**
 * Delegate for objects that can handle
 * the result of remote operations.
 */
@protocol HMRemoteDelegate<NSObject>

@required

/**
 * Called when a remote call succeeds.
 *
 * @param remoteAbstraction The associated remote abstraction.
 * @param data The data associated with the remote call.
 * @param connection The connection associated with the remote call.
 * @param response The response associated with the remote call.
 */
- (void)remoteDidSucceed:(HMRemoteAbstraction *)remoteAbstraction data:(NSData *)data connection:(NSURLConnection *)connection response:(NSURLResponse *)response;

/**
 * Called when a remote call fails.
 * The failure may come from different possibilities.
 *
 * @param remoteAbstraction The associated remote abstraction.
 * @param data The data associated with the remote call.
 * @param error The error associated with the failure.
 */
- (void)remoteDidFail:(HMRemoteAbstraction *)remoteAbstraction data:(NSData *)data error:(NSError *)error;

@end
