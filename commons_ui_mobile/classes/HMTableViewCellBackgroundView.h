// Hive Mobile
// Copyright (C) 2008-2015 Hive Solutions Lda.
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
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008-2015 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "Dependencies.h"

/**
 * Enumeration defining the various cell positions.
 */
typedef enum  {
    HMTableViewCellBackgroundViewPositionGroupedSingle = 1,
    HMTableViewCellBackgroundViewPositionGroupedTop,
    HMTableViewCellBackgroundViewPositionGroupedBottom,
    HMTableViewCellBackgroundViewPositionGroupedMiddle,
    HMTableViewCellBackgroundViewPositionPlain
} HMTableViewCellBackgroundViewPosition;

/**
 * Enumeration defining the various separator styles.
 */
typedef enum  {
    HMTableViewCellBackgroundViewSeparatorStylePlain = 1,
    HMTableViewCellBackgroundViewSeparatorStyleDashed
} HMTableViewCellBackgroundViewSeparatorStyle;

/**
 * Provides a background view meant to override
 * the table view cell's selected background view,
 * in order to bypass the customization limitations
 * in ios (customized selected background views are
 * not clipped to grouped table cell borders).
 */
@interface HMTableViewCellBackgroundView : UIView {
    @private
    HMTableViewCellBackgroundViewPosition _position;
    CGFloat _cornerRadius;
    NSArray *_gradientColors;
    UIColor *_borderColor;
    UIColor *_topSeparatorColor;
    UIColor *_bottomSeparatorColor;
    HMTableViewCellBackgroundViewSeparatorStyle _topSeparatorStyle;
    HMTableViewCellBackgroundViewSeparatorStyle _bottomSeparatorStyle;
    CGFloat *_gradientColorComponents;
    CGFloat *_gradientColorLocations;
}

/**
 * The table view cell's position in the table.
 */
@property (assign) HMTableViewCellBackgroundViewPosition position;

/**
 * The table view cell's corner radius.
 */
@property (assign) CGFloat cornerRadius;

/**
 * The table view cell's gradient colors.
 */
@property (retain) NSArray *gradientColors;

/**
 * The table view cell's border color.
 */
@property (retain) UIColor *borderColor;

/**
 * The table view cell's top separator color.
 */
@property (retain) UIColor *topSeparatorColor;

/**
 * The table view cell's bottom separator color.
 */
@property (retain) UIColor *bottomSeparatorColor;

/**
 * The table view cell's top separator style.
 */
@property (assign) HMTableViewCellBackgroundViewSeparatorStyle topSeparatorStyle;

/**
 * The table view cell's bottom separator style.
 */
@property (assign) HMTableViewCellBackgroundViewSeparatorStyle bottomSeparatorStyle;

/**
 * Initializes the structures.
 */
- (void)initStructures;

/**
 * Draws a top cell for a grouped table.
 *
 * @param context The graphics context.
 */
- (void)drawRectGroupedTopContext:(CGContextRef)context;

/**
 * Draws a bottom cell for a grouped table.
 *
 * @param context: The graphics context.
 */
- (void)drawRectGroupedBottomContext:(CGContextRef)context;

/**
 * Draws a cell that stands alone in a grouped table.
 *
 * @param context The graphics context.
 */
- (void)drawRectGroupedSingleContext:(CGContextRef)context;

/**
 * Draws a cell for a plain table.
 *
 * @param context The graphics context.
 */
- (void)drawRectPlainContext:(CGContextRef)context;

/**
 * Draws the gradient.
 *
 * @param context The graphics context.
 */
- (void)drawGradientContext:(CGContextRef)context;

/**
 * Draws the table view cell separator.
 *
 * @param context The graphics context.
 * @param style The separator line style.
 * @param color The separator line color.
 * @param startPoint The start of the separator line.
 * @param endPoint The end of the separator line.
 */
- (void)drawSeparatorContext:(CGContextRef)context style:(HMTableViewCellBackgroundViewSeparatorStyle)style color:(CGColorRef)color startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

/**
 * Draws the table view cell plain separator.
 *
 * @param context The graphics context.
 * @param color The separator line color.
 * @param startPoint The start of the separator line.
 * @param endPoint The end of the separator line.
 */
- (void)drawSeparatorPlainContext:(CGContextRef)context color:(CGColorRef)color startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

/**
 * Draws the table view cell dashed separator.
 *
 * @param context The graphics context.
 * @param color The separator line color.
 * @param startPoint The start of the separator line.
 * @param endPoint The end of the separator line.
 */
- (void)drawSeparatorDashedContext:(CGContextRef)context color:(CGColorRef)color startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

@end
