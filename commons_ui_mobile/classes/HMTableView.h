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

// __author__    = João Magalhães <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision: 2390 $
// __date__      = $LastChangedDate: 2009-04-02 08:36:50 +0100 (qui, 02 Abr 2009) $
// __copyright__ = Copyright (c) 2008 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "Dependencies.h"

#import "HMTableViewDataSource.h"

@interface HMTableView : UITableView {
    BOOL _dirty;
}

/**
 * Flag controlling the status of the current view.
 * In case this view is dirty it should be redraw.
 */
@property (assign) BOOL dirty;

/**
 * Called when the view did appear.
 */
- (void)didAppear;

/**
 * Called when the view did disappear.
 */
- (void)didDisappear;

/**
 * Called when the view will appear.
 */
- (void)willAppear;

/**
 * Called when the view will disappear.
 */
- (void)willDisappear;

/**
 * Method used to set editing value, providing a
 * commit flag that is used to control the persistence
 * of the value.
 *
 * @param editing The value of the editing.
 * @param animate If the editing should be animated.
 * @param commit The value for the commit.
 */
- (void)setEditing:(BOOL)editing animated:(BOOL)animate commit:(BOOL)commit;

/**
 * Blurs all the edit table view cells in the table
 * except the one given.
 *
 * @param tableCellView The table cell view not to be hidden.
 */
- (void)blurAllExceptCell:(HMEditTableViewCell *)tableCellView;

/**
 * Invalidates the cells clearing all the internal
 * supporting data structures.
 */
- (void)invalidateCells;

/**
 * Reloads the table data flushing the current
 * cell by invalidation.
 * This method is much heavier than the reload data
 * as it constructs the cells again.
 * As a comparision calling this method is almost the same
 * thing as constructing the table all over again.
 */
- (void)reloadDataInvalidate;

@end
