// Hive Mobile
// Copyright (C) 2008-2012 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2012 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "HMRoundedCornerImageView.h"

@implementation HMRoundedCornerImageView

- (void)setImage:(UIImage *)image {
    // retrieves the image view's attributes
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;

    // retrieves the image's attributes
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    CGFloat imageScale = image.scale;
    CGRect imageRect = CGRectMake(0, 0, imageWidth * imageScale, imageHeight * imageScale);
    CGImageRef imageRef = image.CGImage;
    int imageBitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    CGColorSpaceRef imageColorSpaceRef = CGImageGetColorSpace(imageRef);

    // resizes the image
    CGContextRef context = CGBitmapContextCreate(NULL, imageWidth * imageScale, imageHeight * imageScale, imageBitsPerComponent, 0, imageColorSpaceRef, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, imageRect, image.CGImage);
    CGImageRef imageResized = CGBitmapContextCreateImage(context);
    image = [UIImage imageWithCGImage:imageResized];

    // releases the objects
    CGContextRelease(context);
    CGImageRelease(imageResized);

    // configures the context
    context = CGBitmapContextCreate(NULL, width * imageScale, height * imageScale, imageBitsPerComponent, 0, imageColorSpaceRef, kCGImageAlphaPremultipliedFirst);
    const CGColorRef grayColor = [[UIColor grayColor] CGColor];
    CGContextSetStrokeColorWithColor(context, grayColor);
    CGContextSetLineWidth(context, 1.0 * imageScale);
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetShouldAntialias(context, YES);

    // retrieves the rectangles coordinates
    CGRect resizedImageRect = CGRectMake(0, 0, width * imageScale, height * imageScale);
    CGFloat minimumX = CGRectGetMinX(resizedImageRect);
    CGFloat middleX = CGRectGetMidX(resizedImageRect);
    CGFloat maximumX = CGRectGetMaxX(resizedImageRect);
    CGFloat minimumY = CGRectGetMinY(resizedImageRect);
    CGFloat middleY = CGRectGetMidY(resizedImageRect);
    CGFloat maximumY = CGRectGetMaxY(resizedImageRect);

    // creates the image's border
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, minimumX, middleY);
    CGPathAddArcToPoint(path, NULL, minimumX, minimumY, middleX, minimumY, HM_ROUNDED_CORNER_DEFAULT_CORNER_RADIUS * imageScale);
    CGPathAddArcToPoint(path, NULL, maximumX, minimumY, maximumX, middleY, HM_ROUNDED_CORNER_DEFAULT_CORNER_RADIUS * imageScale);
    CGPathAddArcToPoint(path, NULL, maximumX, maximumY, middleX, maximumY, HM_ROUNDED_CORNER_DEFAULT_CORNER_RADIUS * imageScale);
    CGPathAddArcToPoint(path, NULL, minimumX, maximumY, minimumX, middleY, HM_ROUNDED_CORNER_DEFAULT_CORNER_RADIUS * imageScale);
    CGPathCloseSubpath(path);

    // defines the gradient drawing bounds
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);

    // draws the image
    CGContextDrawImage(context, resizedImageRect, image.CGImage);

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
    CGImageRelease(imageMasked);

    // calls the super
    [super setImage:image];
}

@end
