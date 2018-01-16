// Hive Mobile
// Copyright (c) 2008-2018 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2018 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

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
 * The image to be used for the current
 * active page.
 */
@property (retain) UIImage *imageActive;

/**
 * The image to be used for the current
 * inactive page.
 */
@property (retain) UIImage *imageInactive;

/**
 * Initializes the structures.
 */
- (void)initStructures;

@end
