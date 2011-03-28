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

#import "HMBadgeLabel.h"

/**
 * The default corner radius to be used in the
 * badge label.
 */
#define HM_BADGE_LABEL_DEFAULT_CORNER_RADIUS 5.0

@implementation HMBadgeLabel

@synthesize badgeColor = _badgeColor;

- (void)dealloc {
    // releases the background color
    [_badgeColor release];

    // calls the super
    [super dealloc];
}

- (void)drawRect:(CGRect)rect {
    // retrieves the current context
    CGContextRef context = UIGraphicsGetCurrentContext();

    // retrieves the rectangles coordinates
    CGFloat minimumX = CGRectGetMinX(self.frame);
    CGFloat middleX = CGRectGetMidX(self.frame);
    CGFloat maximumX = CGRectGetMaxX(self.frame);
    CGFloat minimumY = CGRectGetMinY(self.frame);
    CGFloat middleY = CGRectGetMidY(self.frame);
    CGFloat maximumY = CGRectGetMaxY(self.frame);

    // creates the badge border
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, minimumX, middleY);
    CGPathAddArcToPoint(path, NULL, minimumX, minimumY, middleX, minimumY, HM_BADGE_LABEL_DEFAULT_CORNER_RADIUS);
    CGPathAddArcToPoint(path, NULL, maximumX, minimumY, maximumX, middleY, HM_BADGE_LABEL_DEFAULT_CORNER_RADIUS);
    CGPathAddArcToPoint(path, NULL, maximumX, maximumY, middleX, maximumY, HM_BADGE_LABEL_DEFAULT_CORNER_RADIUS);
    CGPathAddArcToPoint(path, NULL, minimumX, maximumY, minimumX, middleY, HM_BADGE_LABEL_DEFAULT_CORNER_RADIUS);
    CGPathCloseSubpath(path);

    // draws the badge
    CGContextAddPath(context, path);
    CGPathRelease(path);
    CGContextSetFillColorWithColor(context, self.badgeColor.CGColor);
    CGContextFillPath(context);

    // calls the super
    [super drawRect:rect];
}

@end
