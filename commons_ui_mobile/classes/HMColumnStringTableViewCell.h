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
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "Dependencies.h"

#import "HMColumnEditTableViewCell.h"

/**
 * The column string table view cell x margin.
 */
#define HM_COLUMN_STRING_TABLE_VIEW_CELL_X_MARGIN 6

/**
 * The column string table view cell height.
 */
#define HM_COLUMN_STRING_TABLE_VIEW_CELL_HEIGHT 19

/**
 * The column string table view cell password length.
 */
#define HM_COLUMN_STRING_TABLE_VIEW_CELL_PASSWORD_LENGTH 12

/**
 * Provides a edit table view cell,
 * whose name and description
 * are displayed side by side, meant
 * to display and edit string values.
 */
@interface HMColumnStringTableViewCell : HMColumnEditTableViewCell<UITextFieldDelegate> {
    @private
    UITextField *_textField;
    BOOL _secure;
    BOOL _returnDisablesEdit;
    NSString *_autocapitalizationType;
}

/**
 * The textfield used to represent the cell value.
 */
@property (retain) UITextField *textField;

/**
 * Indicates if the value should be masked.
 */
@property (assign) BOOL secure;

/**
 * Indicates if the return action should
 * disable the edit mode.
 */
@property (assign) BOOL returnDisablesEdit;

/**
 * Indicates the cell's auto capitalization type.
 */
@property (retain) NSString *autocapitalizationType;

@end
