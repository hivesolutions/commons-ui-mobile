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

#import "HMTableViewCell.h"

@interface HMEditTableViewCell : HMTableViewCell {
    @private
    BOOL _editingDirty;
    UIView *_editView;
    NSString *_defaultValue;
    NSString *_returnType;
    BOOL _editable;
    BOOL _clearable;
}

/**
 * The value that should be used by default.
 */
@property (assign) NSString *defaultValue;

/**
 * The view that is shown when the cell
 * is in edit mode.
 */
@property (retain) UIView *editView;

/**
 * Indicates the action that is
 * represented by returning from
 * the cell's value edition.
 */
@property (retain) NSString *returnType;

/**
 * Indicates if the cell is editable.
 */
@property (assign) BOOL editable;

/**
 * Indicates if the inserted value is
 * clearable with a clear action.
 */
@property (assign) BOOL clearable;

/**
 * Creates the editing view.
 */
- (void)createEditing;

/**
 * Shows the editing view.
 */
- (void)showEditing;

/**
 * Hides the editing view.
 */
- (void)hideEditing;

/**
 * Focus in the editing view contents.
 */
- (void)focusEditing;

/**
 * Bliurs from the editing view contents.
 */
- (void)blurEditing;

@end
