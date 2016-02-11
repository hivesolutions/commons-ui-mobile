// Hive Mobile
// Copyright (c) 2008-2016 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2016 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "Dependencies.h"

#import "HMTableView.h"
#import "HMTableViewCell.h"
#import "HMEntityDelegate.h"
#import "HMEntityProvider.h"
#import "HMItemTableViewDelegate.h"
#import "HMItemTableViewProvider.h"
#import "HMEntityProviderDelegate.h"
#import "HMItemTableViewDataSource.h"

/**
 * The item table view header offset.
 */
#define HM_ITEM_TABLE_VIEW_HEADER_OFFSET 30

/**
 * The item table view footer offset.
 */
#define HM_ITEM_TABLE_VIEW_FOOTER_OFFSET 30

// avoids circular dependency
@class HMLabelItem;

/**
 * The item table view to be used to display object items.
 */
@interface HMItemTableView : HMTableView<UITableViewDelegate, HMEntityProviderDelegate> {
    @private
    HMItemTableViewDataSource *_itemDataSource;
    NSObject<HMItemTableViewDelegate> *_itemDelegate;
    NSObject<HMItemTableViewProvider> *_itemTableViewProvider;
}

/**
 * The data source provider to be used
 * to retrieve object information.
 */
@property (retain) HMItemTableViewDataSource *itemDataSource;

/**
 * The delegate to be used to handle the
 * changes in the table.
 */
@property (assign) IBOutlet NSObject<HMItemTableViewDelegate> *itemDelegate;

/**
 * The table view provider used to retrieve
 * configuration on the object.
 */
@property (assign) IBOutlet NSObject<HMItemTableViewProvider> *itemTableViewProvider;

/**
 * Flushes the item specification, converting the current ui component
 * values with new object items.
 * This method should be called before persisting any data represented
 * in the ui.
 */
- (void)flushItemSpecification;

/**
 * Flushes the item specification, converting the current ui component
 * values with new object items.
 * This method should be called before persisting any data represented
 * in the ui.
 *
 * @param transient Indicates if the cell's transient value,
 * the value that is currently displayed, should be flushed,
 * or if the commited value should be flushed instead.
 */
- (void)flushItemSpecificationTransient:(BOOL)transient;

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
