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

// __author__    = Tiago Silva <tsilva@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision$
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008-2014 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "Dependencies.h"

#import "HMTabBarController.h"

/**
 * A tab controller essential for propagating
 * the interface orientation change request,
 * to allow child view controller to decide
 * by themselves.
 */
@interface HMTabBarController : UITabBarController {
    @private
    UIButton *_mainButton;
}

/**
 * The tab bar's main button, which will
 * appear in the center of the tab bar.
 */
@property (retain) UIButton *mainButton;

/**
 * Callback called when main button was clicked.
 *
 * @param sender The sender of the event.
 * @param extra Extra parameter for the event.
 */
- (void)mainButtonClicked:(id)sender extra:(id)extra;

@end
