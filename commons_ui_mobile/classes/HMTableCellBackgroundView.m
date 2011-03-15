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

#define DEFAULT_MARGIN 10
#define DEFAULT_GRADIENT_LOCATIONS {0.0, 1.0}
#define DEFAULT_GRADIENT_COLORS {0.66, 0.85, 0.36, 1, 0.23, 0.62, 0.27, 1}

#import "HMTableCellBackgroundView.h"

@implementation HMTableCellBackgroundView

@synthesize position = _position;
@synthesize gradientColors = _gradientColors;
 
- (BOOL) isOpaque {
    return NO;
}

-(void)drawRect:(CGRect)rectangle {
    // retrieves the current graphics context
    CGContextRef context = UIGraphicsGetCurrentContext();	
    
    // configures the context
    const CGColorRef grayColor = [[UIColor grayColor] CGColor];
    CGContextSetStrokeColorWithColor(context, grayColor);
    CGContextSetLineWidth(context, 1);
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetShouldAntialias(context, YES);
     
    // invokes the appropriate draw function
    // depending on the cell's position
    switch(self.position) {
        case HMTableCellBackgroundViewPositionGroupedTop:
            [self drawRectGroupedTop];
            break;
        case HMTableCellBackgroundViewPositionGroupedBottom:
            [self drawRectGroupedBottom];
            break;
        case HMTableCellBackgroundViewPositionGroupedMiddle:
            [self drawRectGroupedMiddle];
            break;
        case HMTableCellBackgroundViewPositionGroupedSingle:
            [self drawRectGroupedSingle];
            break;
        case HMTableCellBackgroundViewPositionNormal:
            [self drawRectNormal];
            break;
    }
}

- (void)drawRectGroupedTop {
    // retrieves the current graphics context
    CGContextRef context = UIGraphicsGetCurrentContext();	
    
    // retrieves the view's bounds
    CGRect rectangle = [self bounds];	
    
    // retrieves the rectangles coordinates
    CGFloat minimumX = CGRectGetMinX(rectangle);
    CGFloat middleX = CGRectGetMidX(rectangle);
    CGFloat maximumX = CGRectGetMaxX(rectangle);
    CGFloat minimumY = CGRectGetMinY(rectangle);
    CGFloat maximumY = CGRectGetMaxY(rectangle);
    
    // creates the cell's border
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, minimumX, maximumX);
    CGPathAddArcToPoint(path, NULL, minimumX, minimumY, middleX, minimumY, DEFAULT_MARGIN);
    CGPathAddArcToPoint(path, NULL, maximumX, minimumY, maximumX, maximumY, DEFAULT_MARGIN);
    CGPathAddLineToPoint(path, NULL, maximumX, maximumY);
    CGPathAddLineToPoint(path, NULL, minimumX, maximumY);
    CGPathCloseSubpath(path);
    
    // defines the gradient drawing bounds
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    
    // draws the gradient
    CGFloat locations[2] = DEFAULT_GRADIENT_LOCATIONS;
    CGFloat components[8] = DEFAULT_GRADIENT_COLORS;
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, 2);
    CGPoint minimumPoint = CGPointMake(minimumX, minimumY);
    CGPoint maximumPoint = CGPointMake(minimumX, maximumY);
    CGContextDrawLinearGradient(context, gradient, minimumPoint, maximumPoint, 0);
    
    // releases the colorspace and the gradient
    CGColorSpaceRelease(colorspace);
    CGGradientRelease(gradient);
    
    // draws the cell's border
    CGContextAddPath(context, path);
    CGPathRelease(path);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

- (void)drawRectGroupedBottom {
    // retrieves the current graphics context
    CGContextRef context = UIGraphicsGetCurrentContext();	
   
    // retrieves the view's bounds
    CGRect rectangle = [self bounds];	
    
    // retrieves the rectangles coordinates
    CGFloat minimumX = CGRectGetMinX(rectangle);
    CGFloat middleX = CGRectGetMidX(rectangle);
    CGFloat maximumX = CGRectGetMaxX(rectangle);
    CGFloat minimumY = CGRectGetMinY(rectangle);
    CGFloat maximumY = CGRectGetMaxY(rectangle);
    
    // decreases the minimum y
    minimumY -= 1;
    
    // creates the cell's border
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, minimumX, minimumY);
    CGPathAddArcToPoint(path, NULL, minimumX, maximumY, middleX, maximumY, DEFAULT_MARGIN);
    CGPathAddArcToPoint(path, NULL, maximumX, maximumY, maximumX, minimumY, DEFAULT_MARGIN);
    CGPathAddLineToPoint(path, NULL, maximumX, minimumY);
    CGPathAddLineToPoint(path, NULL, minimumX, minimumY);
    CGPathCloseSubpath(path);

    // defines the gradient drawing bounds
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);

    // draws the gradient
    CGFloat locations[2] = DEFAULT_GRADIENT_LOCATIONS;
    CGFloat components[8] = DEFAULT_GRADIENT_COLORS;
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, 2);
    CGPoint minimumPoint = CGPointMake(minimumX, minimumY);
    CGPoint maximumPoint = CGPointMake(minimumX, maximumY);
    CGContextDrawLinearGradient(context, gradient, minimumPoint, maximumPoint, 0);
    
    // releases the colorspace and the gradient
    CGColorSpaceRelease(colorspace);
    CGGradientRelease(gradient);
    
    // draws the cell's border
    CGContextAddPath(context, path);
    CGPathRelease(path);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

- (void)drawRectGroupedMiddle {
    // retrieves the current graphics context
    CGContextRef context = UIGraphicsGetCurrentContext();	

    // retrieves the view's bounds
    CGRect rectangle = [self bounds];	
    
    // retrieves the rectangles coordinates
    CGFloat minimumX = CGRectGetMinX(rectangle);
    CGFloat maximumX = CGRectGetMaxX(rectangle);
    CGFloat minimumY = CGRectGetMinY(rectangle);
    CGFloat maximumY = CGRectGetMaxY(rectangle);
    
    // decreases the minimum y
    minimumY -= 1;
    
    // creates the cell's border
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, minimumX, minimumY);
    CGPathAddLineToPoint(path, NULL, maximumX, minimumY);
    CGPathAddLineToPoint(path, NULL, maximumX, maximumY);
    CGPathAddLineToPoint(path, NULL, minimumX, maximumY);
    CGPathAddLineToPoint(path, NULL, minimumX, minimumY);
    CGPathCloseSubpath(path);
    
    // defines the gradient drawing bounds
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    
    // draws the gradient
    CGFloat locations[2] = DEFAULT_GRADIENT_LOCATIONS;
    CGFloat components[8] = DEFAULT_GRADIENT_COLORS;
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, 2);
    CGPoint minimumPoint = CGPointMake(minimumX, minimumY);
    CGPoint maximumPoint = CGPointMake(minimumX, maximumY);
    CGContextDrawLinearGradient(context, gradient, minimumPoint, maximumPoint, 0);
    
    // releases the colorspace and the gradient
    CGColorSpaceRelease(colorspace);
    CGGradientRelease(gradient);

    // draws the cell's border
    CGContextAddPath(context, path);
    CGPathRelease(path);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

- (void)drawRectGroupedSingle {
    // retrieves the current graphics context
    CGContextRef context = UIGraphicsGetCurrentContext();	
    
    // retrieves the view's bounds
    CGRect rectangle = [self bounds];	
    
    // retrieves the rectangles coordinates
    CGFloat minimumX = CGRectGetMinX(rectangle);
    CGFloat middleX = CGRectGetMidX(rectangle);
    CGFloat maximumX = CGRectGetMaxX(rectangle);
    CGFloat minimumY = CGRectGetMinY(rectangle);
    CGFloat middleY = CGRectGetMidY(rectangle);
    CGFloat maximumY = CGRectGetMaxY(rectangle);
    
    // creates the cell's border
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, minimumX, middleY);
    CGPathAddArcToPoint(path, NULL, minimumX, minimumY, middleX, minimumY, DEFAULT_MARGIN);
    CGPathAddArcToPoint(path, NULL, maximumX, minimumY, maximumX, middleY, DEFAULT_MARGIN);
    CGPathAddArcToPoint(path, NULL, maximumX, maximumY, middleX, maximumY, DEFAULT_MARGIN);
    CGPathAddArcToPoint(path, NULL, minimumX, maximumY, minimumX, middleY, DEFAULT_MARGIN);
    CGPathCloseSubpath(path);
    
    // defines the gradient drawing bounds
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    
    // draws the gradient
    CGFloat locations[2] = DEFAULT_GRADIENT_LOCATIONS;
    CGFloat components[8] = DEFAULT_GRADIENT_COLORS;
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, 2);
    CGPoint minimumPoint = CGPointMake(minimumX, minimumY);
    CGPoint maximumPoint = CGPointMake(minimumX, maximumY);
    CGContextDrawLinearGradient(context, gradient, minimumPoint, maximumPoint, 0);
    
    // releases the colorspace and the gradient
    CGColorSpaceRelease(colorspace);
    CGGradientRelease(gradient);
    
    // draws the cell's border
    CGContextAddPath(context, path);
    CGPathRelease(path);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

- (void)drawRectNormal {
    // retrieves the current graphics context
    CGContextRef context = UIGraphicsGetCurrentContext();	
    
    // retrieves the view's bounds
    CGRect rectangle = [self bounds];	
    
    // retrieves the rectangles coordinates
    CGFloat minimumX = CGRectGetMinX(rectangle);
    CGFloat minimumY = CGRectGetMinY(rectangle);
    CGFloat maximumY = CGRectGetMaxY(rectangle);
    
    // draws the gradient
    CGFloat locations[2] = DEFAULT_GRADIENT_LOCATIONS;
    CGFloat components[8] = DEFAULT_GRADIENT_COLORS;
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, 2);
    CGPoint minimumPoint = CGPointMake(minimumX, minimumY);
    CGPoint maximumPoint = CGPointMake(minimumX, maximumY);
    CGContextDrawLinearGradient(context, gradient, minimumPoint, maximumPoint, 0);
    
    // releases the colorspace and the gradient
    CGColorSpaceRelease(colorspace);
    CGGradientRelease(gradient);
}

- (void)setCellPosition:(HMTableCellBackgroundViewPosition)position {
    // returns in case the position hasn't changed
    if (self.position == position) {
        return;
    }    
    
    // stores the new position
    self.position = position;
    
    // sets the cell to be re-rendered
    [self setNeedsDisplay];
}

@end
