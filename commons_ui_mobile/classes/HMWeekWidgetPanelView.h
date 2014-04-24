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
 * The week widget panel view status label spacing.
 */
#define HM_WEEK_WIDGET_PANEL_VIEW_STATUS_LABEL_SPACING 6.0

/**
 * The week widget panel view status label y (position).
 */
#define HM_WEEK_WIDGET_PANEL_VIEW_STATUS_LABEL_Y 390.0

/**
 * Represents a component which displays
 * aggregated values for each week day.
 */
@interface HMWeekWidgetPanelView : UIView<UIScrollViewDelegate> {
    @private
    NSString *_title;
    NSString *_subTitle;
    NSString *_value;
    UIImage *_image;
    NSArray *_weekItems;
    UILabel *_titleLabel;
    UILabel *_subTitleLabel;
    UILabel *_valueLabel;
    UIImageView *_imageView;
    NSMutableArray *_weekItemLabels;
    UILabel *_leftLabel;
    UILabel *_centerLabel;
    UILabel *_rightLabel;
}

/**
 * The title value.
 */
@property (assign) NSString *title;

/**
 * The sub title value.
 */
@property (assign) NSString *subTitle;

/**
 * The value value.
 */
@property (assign) NSString *value;

/**
 * The image to represent widget panel.
 */
@property (assign) UIImage *image;

/**
 * The list of items representing the
 * various week days.
 */
@property (assign) NSArray *weekItems;

/**
 * The title label.
 */
@property (retain) UILabel *titleLabel;

/**
 * The sub title label.
 */
@property (retain) UILabel *subTitleLabel;

/**
 * The value label.
 */
@property (retain) UILabel *valueLabel;

/**
 * The image view.
 */
@property (retain) UIImageView *imageView;

/**
 * The week item labels.
 */
@property (retain) NSMutableArray *weekItemLabels;

/**
 * The left (status) labels.
 */
@property (retain) UILabel *leftLabel;

/**
 * The center (status) labels.
 */
@property (retain) UILabel *centerLabel;

/**
 * The right (status) labels.
 */
@property (retain) UILabel *rightLabel;

/**
 * Initializes the structures.
 */
- (void)initStructures;

/**
 * Does the layout in the status labels.
 */
- (void)doLayoutStatus;

/**
 * Updates the status value.
 */
- (void)updateStatus;

@end
