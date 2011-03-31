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

#import "HMTableView.h"
#import "HMEditTableViewCell.h"
#import "HMItemTableViewDelegate.h"
#import "HMItemTableViewProvider.h"
#import "HMItemTableViewDataSource.h"

/**
 * The item table view header offset.
 */
#define HM_ITEM_TABLE_VIEW_HEADER_OFFSET 30

/**
 * The item table view footer offset.
 */
#define HM_ITEM_TABLE_VIEW_FOOTER_OFFSET 30

/**
 * The item table view to be used to display object items.
 */
@interface HMItemTableView : HMTableView<UITableViewDelegate> {
    @private
    HMItemTableViewDataSource *_itemDataSource;
    NSObject<HMItemTableViewDelegate> *_itemDelegate;
    NSObject<HMItemTableViewProvider> *_itemTableViewProvider;
}

@property (retain) HMItemTableViewDataSource *itemDataSource;
@property (assign) IBOutlet NSObject<HMItemTableViewDelegate> *itemDelegate;
@property (assign) IBOutlet NSObject<HMItemTableViewProvider> *itemTableViewProvider;

/**
 * Flushes the item specification, converting the current ui component
 * values with new object items.
 * This method should be called before persisting any data represented
 * in the ui.
 */
- (void)flushItemSpecification;

/**
 * Keeps the class valid for export at link time.
 */
+ (void)_keepAtLinkTime;

/**
 * Creates a view representing a label item
 * that is meant to be inserted in a table section.
 *
 * @param tableView The table view where the section
 * view will be inserted.
 * @param labelItem The label item that will be
 * represented in the section view.
 * @return The section view.
 */
- (UIView *)tableView:(UITableView *)tableView sectionViewForLabelItem:(HMLabelItem *)labelItem;

@end
