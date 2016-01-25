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
// __date__      = $LastChangedDate: 2009-04-02 08:36:50 +0100 (qui, 02 Abr 2009) $
// __copyright__ = Copyright (c) 2008-2016 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "Dependencies.h"

#import "HMStyledPageControl.h"
#import "HMWeekWidgetPanelView.h"

/**
 * Enumeration defining the
 * various week widget panel types.
 */
typedef enum {
    HMWeekWidgetNonePanel = 1,
    HMWeekWidgetGreenPanel,
    HMWeekWidgetRedPanel
} HMWeekWidgetPanelType;

/**
 * The widget component that represents
 * a week based set of key value pairs.
 */
@interface HMWeekWidgetView : UIView<UIScrollViewDelegate> {
    @private
    int _numberPages;
    UIColor *_greenBackgroundColor;
    UIColor *_redBackgroundColor;
    UIScrollView *_scrollView;
    HMStyledPageControl *_styledPageControl;
}

/**
 * The green (background) color pattern.
 */
@property (retain) UIColor *greenBackgroundColor;

/**
 * The red (background) color pattern.
 */
@property (retain) UIColor *redBackgroundColor;

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
 * Initializes the background patterns.
 */
- (void)initBackgroudPatterns;

/**
 * Does the layout.
 */
- (void)doLayout;

/**
 * Add a week wiget panel view to the current view.
 *
 * @param weekWidgetPanel The week widget panel to be added.
 * @param panelType The type of panel to be added (color).
 */
- (void)addWeekWidgetPanel:(HMWeekWidgetPanelView *)weekWidgetPanel panelType:(HMWeekWidgetPanelType)panelType;

@end
