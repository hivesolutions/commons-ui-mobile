// Hive Mobile
// Copyright (c) 2008-2020 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2020 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "Dependencies.h"

#import "HMPlainEditTableViewCell.h"

/**
 * The date table view cell x margin.
 */
#define HM_DATE_TABLE_VIEW_CELL_X_MARGIN 7

/**
 * The date table view cell y margin.
 */
#define HM_DATE_TABLE_VIEW_CELL_Y_MARGIN 12

/**
 * The date table view cell height.
 */
#define HM_DATE_TABLE_VIEW_CELL_HEIGHT 19

/**
 * Provides an edit table view cell,
 * meant to display and edit date values.
 */
@interface HMPlainDateTableViewCell : HMPlainEditTableViewCell {
    @private
    UIDatePicker *_datePicker;
    NSDate *_dateValue;
    UILabel *_label;
    NSDateFormatter *_dateFormatter;
}

/**
 * The date picker used to select the date.
 */
@property (retain) UIDatePicker *datePicker;

/**
 * The value represented in the cell.
 */
@property (retain) NSDate *dateValue;

/**
 * The label used to display the
 * string representation of the date.
 */
@property (retain) UILabel *label;

/**
 * The formatter used to convert date objects
 * to strings and strings to date objects.
 */
@property (retain) NSDateFormatter *dateFormatter;

/**
 * Constructor of the class.
 *
 * @param reuseIdentifier The cell's identifier.
 * @return The string table view cell instance.
 */
- (id)initWithReuseIdentifier:(NSString *)cellIdentifier;

/**
 * Slides up the date picker.
 */
- (void)slideUpDatePicker;

/**
 * Slides down the date picker.
 */
- (void)slideDownDatePicker;

/**
 * Hides the date picker.
 */
- (void)hideDatePicker;

/**
 * Updates the date.
 */
- (void)dateChanged;

/**
 * Returns the rect for the device's
 * screen, but with the dimensions
 * adjusted so that the width is always
 * the horizontal portion of the device
 * and the height the vertical one.
 *
 * @return The rect for the device's
 * screen with dimensions adjusted taking
 * into account the device's orientation.
 */
- (CGRect)getAdjustedDimensionsScreenRect;

@end
