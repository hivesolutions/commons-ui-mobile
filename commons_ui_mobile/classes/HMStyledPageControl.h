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

// __author__    = Jo‹o Magalh‹es <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision: 2390 $
// __date__      = $LastChangedDate: 2009-04-02 08:36:50 +0100 (qui, 02 Abr 2009) $
// __copyright__ = Copyright (c) 2008 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "Dependencies.h"

/**
 * The styled page control dot active.
 */
#define HM_STYLED_PAGE_CONTROL_DOT_ACTIVE @"page_control_dot_active.png"

/**
 * The styled page control dot inactive.
 */
#define HM_STYLED_PAGE_CONTROL_DOT_INACTIVE @"page_control_dot_inactive.png"

/**
 * A composite page control component that
 * allows a custom image to be used as the
 * page control token.
 */
@interface HMStyledPageControl : UIPageControl {
    @private
    int _currentCachePage;
    UIImage *_imageActive;
    UIImage *_imageInactive;
}

/**
 * Controls the cache of the current page.
 * This avoids extra drawing.
 */
@property (assign) int currentCachePage;

/**
 * Keeps the class valid for export at link time.
 */
+ (void)_keepAtLinkTime;

@end
