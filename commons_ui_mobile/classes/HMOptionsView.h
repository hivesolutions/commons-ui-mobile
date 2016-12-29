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

#import "HMOptionsButtonView.h"
#import "HMStyledPageControl.h"

/**
 * The value to be used as maximum to activate
 * vertical margin.
 */
#define HM_OPTIONS_VIEW_MAXIMUM_HEIGHT_MARGIN 268

/**
 * The value to be used as vertical margin.
 */
#define HM_OPTIONS_VIEW_VERTICAL_MARGIN 14

/**
 * The extra heigh representing the heights of the
 * search bar and the styled page control.
 */
#define HM_OPTIONS_VIEW_EXTRA_HEIGHT 80

/**
 * View aimed at providing a menu with
 * optimized (big buttons) experience.
 * This view works perfectly in both horizontal
 * and vertical orientations.
 */
@interface HMOptionsView : UIView<UIScrollViewDelegate> {
    @private
    NSMutableArray *_optionsButtons;
    UISearchBar *_searchBar;
    UIScrollView *_scrollView;
    HMStyledPageControl *_styledPageControl;
}

/**
 * The list of options buttons.
 */
@property (retain) NSMutableArray *optionsButtons;

/**
 * The search bar component.
 */
@property (retain) UISearchBar *searchBar;

/**
 * The scroll view component.
 */
@property (retain) UIScrollView *scrollView;

/**
 * The styled page control component.
 */
@property (retain) HMStyledPageControl *styledPageControl;

/**
 * Initializes the structures.
 */
- (void)initStructures;

/**
 * Does the layout of the view repositioning
 * all the items.
 */
- (void)doLayout;

/**
 * Adds the given options button to the options
 * button view.
 *
 * @param optionsButton The options button to be
 * added to the options button view.
 */
- (void)addOptionsButton:(HMOptionsButtonView *)optionsButton;

/**
 * Retrieves the line margin for the
 * current options view state.
 *
 * @return The line margin for the
 * current options view state.
 */
- (CGFloat)getLineMargin;

@end
