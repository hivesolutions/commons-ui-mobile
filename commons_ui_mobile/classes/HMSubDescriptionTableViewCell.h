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
// GNU General Public License for more subDescriptions.
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

/**
 * The sub description table view cell name font size.
 */
#define HM_SUB_DESCRIPTION_TABLE_VIEW_CELL_SUB_DESCRIPTION_FONT_SIZE 13

@interface HMSubDescriptionTableViewCell : HMTableViewCell {
    @private
    NSString *_subDescription;
    UILabel *_subDescriptionLabel;
    UIFont *_subDescriptionFont;
    UIColor *_subDescriptionColor;
    CGFloat _subDescriptionWidth;
    UITextAlignment _subDescriptionTextAlignment;
    UIColor *_subDescriptionShadowColor;
    NSValue *_subDescriptionPosition;
    HMTableViewCellHorizontalAnchor _subDescriptionHorizontalAnchor;
    HMTableViewCellVerticalAnchor _subDescriptionVerticalAnchor;
    NSUInteger _subDescriptionNumberLines;
}

/**
 * The cell's sub description that will be set
 * as its label.
 */
@property (retain) NSString *subDescription;

/**
 * The cell's sub description label.
 */
@property (retain) UILabel *subDescriptionLabel;

/**
 * The table cell's sub description font.
 */
@property (retain) UIFont *subDescriptionFont;

/**
 * The table cell's sub description color.
 */
@property (retain) UIColor *subDescriptionColor;

/**
 * The table cell's sub description width.
 */
@property (assign) CGFloat subDescriptionWidth;

/**
 * The table cell's sub description text alignment.
 */
@property (assign) UITextAlignment subDescriptionTextAlignment;

/**
 * The table cell's sub description shadow color.
 */
@property (retain) UIColor *subDescriptionShadowColor;

/**
 * The table cell's sub description position,
 * represented in a cgpoint structure.
 */
@property (retain) NSValue *subDescriptionPosition;

/**
 * The table cell's sub description horizontal anchor.
 */
@property (assign) HMTableViewCellHorizontalAnchor subDescriptionHorizontalAnchor;

/**
 * The table cell's sub description vertical anchor.
 */
@property (assign) HMTableViewCellVerticalAnchor subDescriptionVerticalAnchor;

/**
 * The table cell's sub description number of lines.
 */
@property (assign) NSUInteger subDescriptionNumberLines;

@end
