// Hive Mobile
// Copyright (C) 2008-2014 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2014 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "Dependencies.h"

/**
 * The delegate class to be used in the remote
 * table view.
 */
@protocol HMRemoteTableViewDelegate<NSObject>

@required

/**
 * Called when a row is selected for a data in
 * the virtual data set.
 *
 * @param data The data in the virtual set for the
 * selected row.
 */
- (void)didSelectRemoteRowWithData:(NSDictionary *)data;

/**
 * Called when a row is deselected for a data in
 * the virtual data set.
 *
 * @param data The data in the virtual set for the
 * deselected row.
 */
- (void)didDeselectRemoteRowWithData:(NSDictionary *)data;

@end
