// Hive Mobile
// Copyright (C) 2008-2016 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2016 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "Dependencies.h"

#import "HMApplicationDelegate.h"
#import "HMAuthenticationDelegate.h"
#import "HMAuthenticationViewController.h"

/**
 * Provides an abstraction for coherent
 * error handling.
 */
@interface HMErrorAbstraction : NSObject {
}

/**
 * Handles the error data according to the current
 * specification for ui handling.
 *
 * @param data The error data to be handled.
 * @param authenticationDelegate The delegate to be used in case
 * authentication is necessary.
 * @param view The view to be used to present the error
 * information.
 * @param viewController The view controller to be used in ui
 * operations.
 */
+ (void)handleErrorData:(id)data authenticationDelegate:(NSObject<HMAuthenticationDelegate> *)authenticationDelegate view:(UIView *)view viewController:(UIViewController *)viewController;

@end
