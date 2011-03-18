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

// __author__    = Tiago Silva <tsilva@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision: 2390 $
// __date__      = $LastChangedDate: 2009-04-02 08:36:50 +0100 (qui, 02 Abr 2009) $
// __copyright__ = Copyright (c) 2008 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import <Foundation/Foundation.h>

#include "HMEditTableViewCell.h"

/**
 * The date picker table view cell x margin.
 */
#define HM_DATE_PICKER_TABLE_VIEW_CELL_X_MARGIN 6

/**
 * The date picker table view cell y margin.
 */
#define HM_DATE_PICKER_TABLE_VIEW_CELL_Y_MARGIN 13

/**
 * The date picker table view cell height.
 */
#define HM_DATE_PICKER_TABLE_VIEW_CELL_HEIGHT 19

@interface HMDatePickerTableViewCell : HMEditTableViewCell {
    @private UIDatePicker *_datePicker;
    @private NSDate *_dateValue;
    @private UILabel *_label;
}

@property (retain) UIDatePicker *datePicker;
@property (retain) NSDate *dateValue;
@property (retain) UILabel *label;

/**
 * Initializes the string table view cell.
 *
 * @param cellStyle The cell's style.
 * @param reuseIdentifier The cell's identifier.
 * @param name The cell's name that will be set
 * as its label.
 * @param icon The identifier of the normal icon
 * resource.
 * @param highlightedIcon The identifier of the
 * highlighted icon resource.
 * @param highlightable Indicates if the table
 * view cell is highlightable.
 * @param accessoryType The type of accessory
 * view to use.
 * @return The string table view cell instance.
 */
- (id)initWithReuseIdentifier:(NSString *)cellIdentifier name:(NSString *)name icon:(NSString *)icon highlightedIcon:(NSString *)highlightedIcon highlightable:(BOOL)highlightable accessoryType:(NSString *)accessoryType;

/**
 * Slides up the date picker.
 */
- (void)slideUpDatePicker;

/**
 * Slides down the date picker.
 */
- (void)slideDownDatePicker;

/**
 * Shrinks the table to give
 * space for the date picker.
 */
- (void)shrinkTable;

/**
 * Hides the date picker.
 */
- (void)hideDatePicker;

/**
 * Updates the date.
 */
- (void)dateChanged;

/**
 * Converts the date to a string
 * representation in the current locale.
 * @param date The date to format.
 * @return The string with the formatted
 * date.
 */
- (NSString *)formatDate:(NSDate *)date;

@end