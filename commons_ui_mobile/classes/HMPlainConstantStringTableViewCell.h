// Hive Mobile
// Copyright (c) 2008-2019 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2019 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "Dependencies.h"

#import "HMPlainEditTableViewCell.h"

/**
 * The plain constant string table view cell x margin.
 */
#define HM_PLAIN_CONSTANT_STRING_TABLE_VIEW_CELL_X_MARGIN 6

/**
 * The plain constant string table view cell height.
 */
#define HM_PLAIN_CONSTANT_STRING_TABLE_VIEW_CELL_HEIGHT 19

/**
 * Provides an edit table view cell,
 * whose name is not displayed, and
 * the description takes up the whole cell,
 * meant to display and edit string values.
 */
@interface HMPlainConstantStringTableViewCell : HMPlainEditTableViewCell {
    UILabel *_label;
}

/**
 * The cell's label.
 */
@property (retain) UILabel *label;

@end
