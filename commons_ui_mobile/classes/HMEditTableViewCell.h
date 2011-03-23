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

// avoids circular dependency
@class HMItemTableView;

@interface HMEditTableViewCell : HMTableViewCell {
    @private
    NSString *_defaultValue;
    UIView *_editView;
    HMItemTableView *_itemTableView;
    BOOL _editingDirty;
    BOOL _clearable;
}

@property (assign) NSString *defaultValue;
@property (retain) UIView *editView;
@property (assign) HMItemTableView *itemTableView;
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
