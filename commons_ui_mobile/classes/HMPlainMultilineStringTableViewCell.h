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

#import "HMPlainEditTableViewCell.h"
#import "HPGrowingTextView.h"

/**
 * The plain multiline string table view cell y margin.
 */
#define HM_PLAIN_MULTILINE_STRING_TABLE_VIEW_CELL_Y_MARGIN 12

/**
 * The plain multiline string table view cell password length.
 */
#define HM_PLAIN_MULTILINE_STRING_TABLE_VIEW_CELL_PASSWORD_LENGTH 12

/**
 * The plain multiline string table view cell extra cell height.
 */
#define HM_PLAIN_MULTILINE_STRING_TABLE_VIEW_CELL_EXTRA_CELL_HEIGHT 14

/**
 * The plain multiline string table view cell scroll margin
 */
#define HM_PLAIN_MULTILINE_STRING_TABLE_VIEW_CELL_EXTRA_SCROLL_MARGIN 11

/**
 * Provides an edit table view cell, whose
 * name is not displayed, and the description
 * takes up the whole cell, meant to display
 * and edit multiple line string values.
 */
@interface HMPlainMultilineStringTableViewCell : HMPlainEditTableViewCell<HPGrowingTextViewDelegate> {
    @private
    HPGrowingTextView *_textView;
    BOOL _secure;
    BOOL _returnDisablesEdit;
    NSString *_autocapitalizationType;
}

/**
 * The text view used to represent
 * the cell value.
 */
@property (retain) HPGrowingTextView *textView;

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
