// Hive Mobile
// Copyright (c) 2008-2018 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2018 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "Dependencies.h"

#import "HMTableViewCell.h"

/**
 * Provides a table view cell
 * that switches visual state
 * between view and edit mode.
 */
@interface HMEditTableViewCell : HMTableViewCell {
    @protected
    BOOL _editingDirty;

    @private
    UIView *_editView;
    NSString *_defaultValue;
    NSString *_returnType;
    BOOL _clearable;
    BOOL _editAlways;
    BOOL _selectableEdit;
    BOOL _persistentEdit;
    BOOL _focusEdit;
    Class _editViewController;
    NSString *_editNibName;
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
 * Indicates if the inserted value is
 * clearable with a clear action.
 */
@property (assign) BOOL clearable;

/**
 * Indicates if the cell is meant to
 * be of type edit only.
 */
@property (assign) BOOL editAlways;

/**
 * Indicates if the button is selectable
 * in the edit mode.
 */
@property (assign) BOOL selectableEdit;

/**
 * Indicates if the edit view is persistent.
 */
@property (assign) BOOL persistentEdit;

/**
 * Indicates if the cell should focus
 * when entering edit mode.
 */
@property (assign) BOOL focusEdit;

/**
 * The view controller to use when the
 * item is selected for editing.
 */
@property (assign) Class editViewController;

/**
 * The name of the nib for the view
 * controller that will be used when
 * the item is selected for ediiting.
 */
@property (retain) NSString *editNibName;

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
 * Blurs from the editing view contents.
 */
- (void)blurEditing;

/**
 * Persists the editing view contents.
 */
- (void)persistEditing;

/**
 * Rollback the editing view contents.
 */
- (void)rollbackEditing;

/**
 * Flushes the current editing contents.
 * This method should be overriden carefully
 * because it can cause side effects.
 */
- (void)flushEditing;

@end
