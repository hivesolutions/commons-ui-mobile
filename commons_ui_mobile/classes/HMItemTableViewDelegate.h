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

/**
 * The delegate class to be used in the item
 * table view.
 */
@protocol HMItemTableViewDelegate<NSObject>

@optional

/**
 * Called when a button is clicked.
 *
 * @param buttonName The name of the button
 * that has been clicked.
 */
- (void)buttonClicked:(NSString *)buttonName;

/**
 * Called when the editing status is changed.
 *
 * @param editing The current editing status.
 */
- (void)setEditingChanged:(BOOL)editing;

@required

/**
 * Called when a row is selected for an item in
 * the virtual data set.
 *
 * @param item The item in the virtual set for the
 * selected row.
 */
- (void)didSelectItemRowWithItem:(HMItem *)item;

/**
 * Called when a row is deselected for an item in
 * the virtual data set.
 *
 * @param item The item in the virtual set for the
 * deselected row.
 */
- (void)didDeselectItemRowWithItem:(HMItem *)item;

@end
