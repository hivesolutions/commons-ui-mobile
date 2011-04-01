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

/**
 * The table view cell height.
 */
#define HM_TABLE_VIEW_CELL_HEIGHT 50

/**
 * The horizontal margin between the badge
 * label's text and the badge.
 */
#define BADGE_LABEL_ACCESSORY_VALUE_X_MARGIN 5

/**
 * The horizontal margin between the badge
 * label and the cell.
 */
#define BADGE_LABEL_ACCESSORY_X_MARGIN 11

/**
 * The vertical margin between the badge
 * label and the cell.
 */
#define BADGE_LABEL_ACCESSORY_Y_MARGIN 15

// avoids circular dependency
@class HMItemTableView;

@interface HMTableViewCell : UITableViewCell<HMView> {
    @protected
    NSString *_description;

    @private
    HMItem *_item;
    NSString *_name;
    NSString *_icon;
    NSString *_highlightedIcon;
    BOOL _highlightable;
    NSString *_accessoryTypeString;
    NSString *_accessoryValue;
    float _height;
    HMItemTableView *_itemTableView;
}

/**
 * The cell's name that will be set
 * as its label.
 */
@property (retain) NSString *name;

/**
 * The cell's description that will be set
 * as its detail text label.
 */
@property (retain) NSString *description;

/**
 * The identifier of the icon resource.
 */
@property (retain) NSString *icon;

/**
 * The identifier of the highlighted icon resource.
 */
@property (retain) NSString *highlightedIcon;

/**
 * Indicates if the table view cell is highlightable.
 */
@property (assign) BOOL highlightable;

/**
 * The type of accessory (string mode).
 */
@property (retain) NSString *accessoryTypeString;

/**
 * The accessory value.
 */
@property (retain) NSString *accessoryValue;

/**
 * The table view cell's height.
 */
@property (assign) float height;

/**
 * The item table view this cell belongs to.
 */
@property (assign) HMItemTableView *itemTableView;

/**
 * Called when the edinting mode is going to be changed.
 * The commit argument defined if the edit operation should
 * be persisted (commited).
 *
 * @param editing If the editing mode is going to enter.
 * @param commit If the edit should be persisted.
 */
- (void)changeEditing:(BOOL)editing commit:(BOOL)commit;

/**
 * Updates the table data according to the new
 * specification.
 * This method should be used carefully as it wastes
 * a lot of resource in order to update the table
 * contents.
 */
- (void)updateTableData;

@end
