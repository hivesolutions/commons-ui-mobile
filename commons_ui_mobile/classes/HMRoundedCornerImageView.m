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

#define DEFAULT_CORNER_RADIUS 10.0
#define IMAGE_BITS_PER_COMPONENT 8
#define IMAGE_BYTES_PER_ROW 4

#import "HMRoundedCornerImageView.h"

@implementation HMRoundedCornerImageView

- (void)setImage:(UIImage *)image {
    // retrieves the image's dimensions
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    CGRect imageRect = CGRectMake(0, 0, imageWidth, imageHeight);

    // creates a bitmap context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, imageWidth, imageHeight, IMAGE_BITS_PER_COMPONENT, IMAGE_BYTES_PER_ROW * imageWidth, colorSpace, kCGImageAlphaPremultipliedFirst);

    // configures the context
    const CGColorRef grayColor = [[UIColor grayColor] CGColor];
    CGContextSetStrokeColorWithColor(context, grayColor);
    CGContextSetLineWidth(context, 1);
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetShouldAntialias(context, YES);

    // retrieves the rectangles coordinates
    CGFloat minimumX = CGRectGetMinX(imageRect);
    CGFloat middleX = CGRectGetMidX(imageRect);
    CGFloat maximumX = CGRectGetMaxX(imageRect);
    CGFloat minimumY = CGRectGetMinY(imageRect);
    CGFloat middleY = CGRectGetMidY(imageRect);
    CGFloat maximumY = CGRectGetMaxY(imageRect);

    // creates the image's border
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, minimumX, middleY);
    CGPathAddArcToPoint(path, NULL, minimumX, minimumY, middleX, minimumY, DEFAULT_CORNER_RADIUS);
    CGPathAddArcToPoint(path, NULL, maximumX, minimumY, maximumX, middleY, DEFAULT_CORNER_RADIUS);
    CGPathAddArcToPoint(path, NULL, maximumX, maximumY, middleX, maximumY, DEFAULT_CORNER_RADIUS);
    CGPathAddArcToPoint(path, NULL, minimumX, maximumY, minimumX, middleY, DEFAULT_CORNER_RADIUS);
    CGPathCloseSubpath(path);

    // defines the gradient drawing bounds
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);

    // draws the image
    CGContextDrawImage(context, imageRect, image.CGImage);

    // draws the image's border
    CGContextAddPath(context, path);
    CGPathRelease(path);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);

    // replaces the image with the bitmap context
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    image = [UIImage imageWithCGImage:imageMasked];

    // releases the objects
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageMasked);

    // calls the super
    [super setImage:image];
}

@end
