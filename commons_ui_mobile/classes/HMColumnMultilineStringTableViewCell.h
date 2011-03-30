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

#import "Dependencies.h"

#import "HMColumnEditTableViewCell.h"

/**
 * The column multiline string table view cell y margin.
 */
#define HM_COLUMN_MULTILINE_STRING_TABLE_VIEW_CELL_Y_MARGIN 12

/**
 * The column multiline string table view cell password length.
 */
#define HM_COLUMN_MULTILINE_STRING_TABLE_VIEW_CELL_PASSWORD_LENGTH 12

@interface HMColumnMultilineStringTableViewCell : HMColumnEditTableViewCell<UITextViewDelegate> {
    @private
    UITextView *_textView;
    BOOL _secure;
    BOOL _returnDisablesEdit;
}

/**
 * The textfield used to represent the cell value.
 */
@property (retain) UITextView *textView;

/**
 * Indicates if the value should be masked.
 */
@property (assign) BOOL secure;

/**
 * Indicates if the return action should
 * disable the edit mode.
 */
@property (assign) BOOL returnDisablesEdit;

@end