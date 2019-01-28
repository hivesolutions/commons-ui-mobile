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

#import "HMEditTableViewCell.h"

/**
 * Provides an edit table view cell,
 * whose name and description
 * are displayed side by side.
 */
@interface HMColumnEditTableViewCell : HMEditTableViewCell {
    @private
    UIView *_nameLabelClickView;
    UIView *_columnSeparatorView;
    BOOL _drawColumnSeparator;
}

/**
 * The label used to handle name label clicks.
 */
@property (retain) UIView *nameLabelClickView;

/**
 * The view representing the column separator.
 */
@property (retain) UIView *columnSeparatorView;

/**
 * Boolean indicating if column separators
 * should be drawn.
 */
@property (assign) BOOL drawColumnSeparator;

/**
 * Initializes the cell with the default style.
 *
 * @param cellIdentifier: The cell's identifier.
 */
- (id)initWithReuseIdentifier:(NSString *)cellIdentifier;

/**
 * Indicates that the label
 * was selected.
 */
- (void)didSelectLabel;

@end
