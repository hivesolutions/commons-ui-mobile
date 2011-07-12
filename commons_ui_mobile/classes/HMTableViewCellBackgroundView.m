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

#import "HMTableViewCellBackgroundView.h"

@implementation HMTableViewCellBackgroundView

@synthesize position = _position;
@synthesize cornerRadius = _cornerRadius;
@synthesize gradientColors = _gradientColors;
@synthesize borderColor = _borderColor;
@synthesize topSeparatorColor = _topSeparatorColor;
@synthesize bottomSeparatorColor = _bottomSeparatorColor;
@synthesize topSeparatorStyle = _topSeparatorStyle;
@synthesize bottomSeparatorStyle = _bottomSeparatorStyle;

- (id)init {
    // invokes the parent constructor
    self = [super init];

    // initializes the structures
    [self initStructures];

    // returns the instance
    return self;
}

- (void)dealloc {
    // releases the gradient colors
    [_gradientColors release];

    // releases the border color
    [_borderColor release];

    // releases the top separator color
    [_topSeparatorColor release];

    // releases the bottom separator color
    [_bottomSeparatorColor release];

    // frees the gradient color components
    free(_gradientColorComponents);

    // frees the gradient color locations
    free(_gradientColorLocations);

    // calls the super
    [super dealloc];
}

- (void)initStructures {
    // creates the default border color
    UIColor *defaultBorderColor = [UIColor grayColor];

    // sets the default values
    self.opaque = NO;
    self.position = HMTableViewCellBackgroundViewPositionPlain;
    self.borderColor = defaultBorderColor;
    self.topSeparatorStyle = HMTableViewCellBackgroundViewSeparatorStylePlain;
    self.bottomSeparatorStyle = HMTableViewCellBackgroundViewSeparatorStylePlain;
}

- (void)drawRect:(CGRect)rectangle {
    // retrieves the current graphics context
    CGContextRef context = UIGraphicsGetCurrentContext();

    // configures the context
    CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);
    CGContextSetLineWidth(context, 1);

    // invokes the appropriate draw function
    // depending on the cell's position
    switch(self.position) {
        // in case the cell is the top cell in a grouped table
        case HMTableViewCellBackgroundViewPositionGroupedTop:
            // draws the cell as a grouped table top cell
            [self drawRectGroupedTopContext:context];

            // breaks
            break;

        // in case the cell is the bottom cell in a grouped table
        case HMTableViewCellBackgroundViewPositionGroupedBottom:
            // draws the cell as a grouped table bottom cell
            [self drawRectGroupedBottomContext:context];

            // breaks
            break;

        // in case the cell is the middle cell in a grouped table
        case HMTableViewCellBackgroundViewPositionGroupedMiddle:
            // draws the cell as a grouped table middle cell
            [self drawRectPlainContext:context];

            // breaks
            break;

        // in case the cell is a single cell in a grouped table
        case HMTableViewCellBackgroundViewPositionGroupedSingle:
            // draws the cell as a grouped table single cell
            [self drawRectGroupedSingleContext:context];

            // breaks
            break;

        // in case the cell is a cell a plain table
        case HMTableViewCellBackgroundViewPositionPlain:
            // draws the cell as a plain cell
            [self drawRectPlainContext:context];

            // breaks
            break;
    }
}

- (void)drawRectGroupedTopContext:(CGContextRef)context {
    // retrieves the view's bounds
    CGRect rectangle = self.bounds;

    // retrieves the rectangles coordinates
    CGFloat minimumX = CGRectGetMinX(rectangle);
    CGFloat middleX = CGRectGetMidX(rectangle);
    CGFloat maximumX = CGRectGetMaxX(rectangle);
    CGFloat minimumY = CGRectGetMinY(rectangle);
    CGFloat maximumY = CGRectGetMaxY(rectangle);

    // creates the cell's border
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, minimumX, maximumX);
    CGPathAddArcToPoint(path, NULL, minimumX, minimumY, middleX, minimumY, self.cornerRadius);
    CGPathAddArcToPoint(path, NULL, maximumX, minimumY, maximumX, maximumY, self.cornerRadius);
    CGPathAddLineToPoint(path, NULL, maximumX, maximumY);
    CGPathAddLineToPoint(path, NULL, minimumX, maximumY);
    CGPathCloseSubpath(path);

    // defines the gradient drawing bounds
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);

    // draws the gradient
    [self drawGradientContext:context];

    // draws the cell's border
    CGContextAddPath(context, path);
    CGPathRelease(path);
    CGContextStrokePath(context);

    // in case the bottom separator color is defined
    if(self.bottomSeparatorColor) {
        // creates the points
        CGPoint startPoint = CGPointMake(minimumX + 1, maximumY);
        CGPoint endPoint = CGPointMake(maximumX - 1, maximumY);

        // draws the separator
        [self drawSeparatorContext:context style:self.bottomSeparatorStyle color:self.bottomSeparatorColor.CGColor startPoint:startPoint endPoint:endPoint];
    }

    // restores the state
    CGContextRestoreGState(context);
}

- (void)drawRectGroupedBottomContext:(CGContextRef)context {
    // retrieves the view's bounds
    CGRect rectangle = self.bounds;

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
    CGPathAddArcToPoint(path, NULL, minimumX, maximumY, middleX, maximumY, self.cornerRadius);
    CGPathAddArcToPoint(path, NULL, maximumX, maximumY, maximumX, minimumY, self.cornerRadius);
    CGPathAddLineToPoint(path, NULL, maximumX, minimumY);
    CGPathAddLineToPoint(path, NULL, minimumX, minimumY);
    CGPathCloseSubpath(path);

    // defines the gradient drawing bounds
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);

    // draws the gradient
    [self drawGradientContext:context];

    // draws the cell's border
    CGContextAddPath(context, path);
    CGPathRelease(path);
    CGContextStrokePath(context);

    // in case the top separator color is defined
    if(self.topSeparatorColor) {
        // creates the points
        CGPoint startPoint = CGPointMake(minimumX + 1, minimumY + 1);
        CGPoint endPoint = CGPointMake(maximumX - 1, minimumY + 1);

        // draws the separator
        [self drawSeparatorContext:context style:self.topSeparatorStyle color:self.topSeparatorColor.CGColor startPoint:startPoint endPoint:endPoint];
    }

    // restores the state
    CGContextRestoreGState(context);
}

- (void)drawRectGroupedSingleContext:(CGContextRef)context {
    // retrieves the view's bounds
    CGRect rectangle = self.bounds;

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
    CGPathAddArcToPoint(path, NULL, minimumX, minimumY, middleX, minimumY, self.cornerRadius);
    CGPathAddArcToPoint(path, NULL, maximumX, minimumY, maximumX, middleY, self.cornerRadius);
    CGPathAddArcToPoint(path, NULL, maximumX, maximumY, middleX, maximumY, self.cornerRadius);
    CGPathAddArcToPoint(path, NULL, minimumX, maximumY, minimumX, middleY, self.cornerRadius);
    CGPathCloseSubpath(path);

    // defines the gradient drawing bounds
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);

    // draws the gradient
    [self drawGradientContext:context];

    // draws the cell's border
    CGContextAddPath(context, path);
    CGPathRelease(path);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

- (void)drawRectPlainContext:(CGContextRef)context {
    // retrieves the view's bounds
    CGRect rectangle = self.bounds;

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
    [self drawGradientContext:context];

    // draws the cell's border
    CGContextAddPath(context, path);
    CGPathRelease(path);
    CGContextStrokePath(context);

    // in case the top separator color is defined
    if(self.topSeparatorColor) {
        // creates the points
        CGPoint startPoint = CGPointMake(minimumX + 1, minimumY + 1);
        CGPoint endPoint = CGPointMake(maximumX - 1, minimumY + 1);

        // draws the separator
        [self drawSeparatorContext:context style:self.topSeparatorStyle color:self.topSeparatorColor.CGColor startPoint:startPoint endPoint:endPoint];
    }

    // in case the bottom separator color is defined
    if(self.bottomSeparatorColor) {
        // creates the points
        CGPoint startPoint = CGPointMake(minimumX + 1, maximumY);
        CGPoint endPoint = CGPointMake(maximumX - 1, maximumY);

        // draws the separator
        [self drawSeparatorContext:context style:self.bottomSeparatorStyle color:self.bottomSeparatorColor.CGColor startPoint:startPoint endPoint:endPoint];
    }

    // restores the state
    CGContextRestoreGState(context);
}

- (void)drawGradientContext:(CGContextRef)context {
    // in case no gradient colors are defined
    if(!self.gradientColors) {
        // returns
        return;
    }

    // retrieves the view's bounds
    CGRect rectangle = self.bounds;

    // retrieves the rectangles coordinates
    CGFloat minimumX = CGRectGetMinX(rectangle);
    CGFloat minimumY = CGRectGetMinY(rectangle);
    CGFloat maximumY = CGRectGetMaxY(rectangle);

    // retrieves the number of gradient colors
    int numberGradientColors = [self.gradientColors count];

    // draws the gradient
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, _gradientColorComponents, _gradientColorLocations, numberGradientColors);
    CGPoint minimumPoint = CGPointMake(minimumX, minimumY);
    CGPoint maximumPoint = CGPointMake(minimumX, maximumY);
    CGContextDrawLinearGradient(context, gradient, minimumPoint, maximumPoint, 0);

    // releases the objects
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
}

- (void)drawSeparatorContext:(CGContextRef)context style:(HMTableViewCellBackgroundViewSeparatorStyle)separatorStyle color:(CGColorRef)color startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    // depending on the separator style
    switch(separatorStyle) {
            // in case it's the plain style
        case HMTableViewCellBackgroundViewSeparatorStylePlain:
            // draws a plain separator
            [self drawSeparatorPlainContext:context color:color startPoint:startPoint endPoint:endPoint];
            break;
            // in case it's the dashed style
        case HMTableViewCellBackgroundViewSeparatorStyleDashed:
            // draws the dashed separator
            [self drawSeparatorDashedContext:context color:color startPoint:startPoint endPoint:endPoint];
            break;
    }
}

- (void)drawSeparatorPlainContext:(CGContextRef)context color:(CGColorRef)color startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    // defines the stroke color
    CGContextSetStrokeColorWithColor(context, color);

    // creates the separator path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
    CGPathAddLineToPoint(path, NULL, endPoint.x, endPoint.y);
    CGPathCloseSubpath(path);

    // adds the path to the context
    CGContextAddPath(context, path);

    // releases the path
    CGPathRelease(path);

    // draws the path
    CGContextStrokePath(context);
}

- (void)drawSeparatorDashedContext:(CGContextRef)context color:(CGColorRef)color startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    // defines the stroke color
    CGContextSetStrokeColorWithColor(context, color);

    // creates the path
    CGMutablePathRef path = CGPathCreateMutable();

    // initializes the coordinates
    CGFloat startX = startPoint.x + 10;
    CGFloat endX = startX + 3;

    // draws the dashed path
    while(endX < endPoint.x - 6) {
        CGPathMoveToPoint(path, NULL, startX, startPoint.y);
        CGPathAddLineToPoint(path, NULL, endX, endPoint.y);
        startX += 6;
        endX += 6;
    }

    // closes the path and adds it to the context
    CGPathCloseSubpath(path);
    CGContextAddPath(context, path);

    // releases the path
    CGPathRelease(path);

    // draws the path
    CGContextStrokePath(context);
}

- (NSArray *)gradientColors {
    return _gradientColors;
}

- (void)setGradientColors:(NSArray *)gradientColors {
    // in case the object is the same
    if(gradientColors == _gradientColors) {
        // returns immediately
        return;
    }

    // releases the object
    [_gradientColors release];

    // sets and retains the object
    _gradientColors = [gradientColors retain];

    // retrieves the number of gradient colors
    int numberGradientColors = [gradientColors count];

    // in case the gradient color
    // components are allocated
    if(_gradientColorComponents) {
        // frees the gradient color components
        free(_gradientColorComponents);
    }

    // in case the gradient color
    // locations are allocated
    if(_gradientColorLocations) {
        // frees the gradient color locations
        free(_gradientColorLocations);
    }

    // allocates the gradient lists
    _gradientColorComponents = malloc(sizeof(CGFloat) * numberGradientColors * 4);
    _gradientColorLocations = malloc(sizeof(CGFloat) * numberGradientColors);

    // populates the components list with the gradient colors
    for(int index = 0; index < numberGradientColors; index++) {
        // retrieves the gradient color
        UIColor *gradientColor = (UIColor *) [self.gradientColors objectAtIndex:index];
        const CGFloat *gradientColorComponents = CGColorGetComponents(gradientColor.CGColor);

        // retrieves the color components
        CGFloat red = gradientColorComponents[0];
        CGFloat green = gradientColorComponents[1];
        CGFloat blue = gradientColorComponents[2];
        CGFloat alpha = gradientColorComponents[3];

        // sets the color components
        _gradientColorComponents[index * 4] = red;
        _gradientColorComponents[index * 4 + 1] = green;
        _gradientColorComponents[index * 4 + 2] = blue;
        _gradientColorComponents[index * 4 + 3] = alpha;

        // sets the location for this color
        CGFloat location = index == 0 ? 0 : (index + 1) * (1.0 / numberGradientColors);
        _gradientColorLocations[index] = location;
    }
}

@end
