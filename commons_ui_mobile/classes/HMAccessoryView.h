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
// __revision__  = $LastChangedRevision$
// __date__      = $LastChangedDate: 2009-04-02 08:36:50 +0100 (qui, 02 Abr 2009) $
// __copyright__ = Copyright (c) 2008-2012 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "Dependencies.h"

#import "HMLabel.h"

/**
 * Represents an accessory view to be
 * set in the table view cell, for
 * every case where the accessory can
 * be represented by a label with a
 * stretchable background.
 */
@interface HMAccessoryView : UIImageView {
    @private
    HMLabel *_label;
    NSString *_text;
    UIFont *_textFont;
    UIColor *_textColorNormal;
    UIColor *_textColorHighlighted;
    UIColor *_textShadowColor;
    UIImage *_imageNormal;
    UIImage *_imageHighlighted;
    NSValue *_margin;
}

/**
 * The accessory view's label.
 */
@property (retain) HMLabel *label;

/**
 * The accessory view's text.
 */
@property (retain) NSString *text;

/**
 * The accessory view's text font.
 */
@property (retain) UIFont *textFont;

/**
 * The accessory view's normal text color.
 */
@property (retain) UIColor *textColorNormal;

/**
 * The accessory view's higlighted text color.
 */
@property (retain) UIColor *textColorHighlighted;

/**
 * The accessory view's text shadow color.
 */
@property (retain) UIColor *textShadowColor;

/**
 * The accessory view's normal image.
 */
@property (retain) UIImage *imageNormal;

/**
 * The accessory view's higlighted image.
 */
@property (retain) UIImage *imageHighlighted;

/**
 * The accessory view's margin,
 * represented with a cgpoint structure,
 * with the origin being the top right
 * corner of the parent cell.
 */
@property (retain) NSValue *margin;

/**
 * Initializes the structures.
 */
- (void)initStructures;

/**
 * Constructs the structures.
 */
- (void)constructStructures;

/**
 * Sets the accessory view's selection mode.
 *
 * @param selected: Boolean indicating if the
 * accessory is currently selected.
 */
- (void)setSelected:(BOOL)selected;

/**
 * Sets the accessory view's highlighted mode.
 *
 * @param highlighted: Boolean indicating if the
 * accessory is currently highlighted.
 */
- (void)setHighlighted:(BOOL)highlighted;

@end
