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

// __author__    = João Magalhães <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision: 2390 $
// __date__      = $LastChangedDate: 2009-04-02 08:36:50 +0100 (qui, 02 Abr 2009) $
// __copyright__ = Copyright (c) 2008 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "HMChartView.h"

#define MARGIN_LEFT 0.0
#define MARGIN_RIGHT 0.0
#define MARGIN_TOP 20.0
#define MARGIN_BOTTOM 10.0


#define VERTICAL_STEPS 8.0
#define HORIZONTAL_STEPS 6.0


#define CIRCLE_SIZE 12.0

#define CIRCLE_INNER_SIZE 4.0


#define MAXIMUM_VAUE 100.0

#define VALUES [NSNumber numberWithFloat:12.0], [NSNumber numberWithFloat:14.0], [NSNumber numberWithFloat:56.0], [NSNumber numberWithFloat:78.0], [NSNumber numberWithFloat:12.0], [NSNumber numberWithFloat:56.0], [NSNumber numberWithFloat:13.0]

@implementation HMChartView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    // returns the intance
    return self;
}

- (void)dealloc {
    // calls the super
    [super dealloc];
}

- (void)drawRect:(CGRect)rect {
    // calls the super
    [super drawRect:rect];

    // retrieves the frame dimensions
    CGFloat frameWidth = self.frame.size.width;
    CGFloat frameHeight = self.frame.size.height;

    printf("%f, %f\n", frameWidth, frameHeight);

    NSArray *values = [NSArray arrayWithObjects:VALUES, nil];

    NSNumber *maximumValue = [NSNumber numberWithInt:0];

    for(NSNumber *value in values) {
        if([value compare:maximumValue] > 0) {
            maximumValue = value;
        }
    }

    // calculates the vertical and horizontal margins
    CGFloat marginHorizontal = MARGIN_LEFT + MARGIN_RIGHT;
    CGFloat marginVertical = MARGIN_TOP + MARGIN_BOTTOM;

    CGFloat availableWidth = frameWidth - marginHorizontal;
    CGFloat availableHeight = frameHeight - marginVertical;

    CGFloat verticalStepSize = availableHeight / VERTICAL_STEPS;
    CGFloat horizontalStepSize = availableWidth / HORIZONTAL_STEPS;

    CGFloat maximumValueFloat = [maximumValue floatValue];

    CGFloat initialValue = (12.0 / maximumValueFloat) * availableHeight;

    printf("%f\n", initialValue);




    // retrieves the current graphics context
    CGContextRef context = UIGraphicsGetCurrentContext();

    // creates the trace color
    const CGColorRef traceColor = [[UIColor colorWithRed:53.0 / 255.0 green:127.0 / 255.0 blue:181.0 / 255.0 alpha:1.0] CGColor];


    CGContextSetStrokeColorWithColor(context, traceColor);
    CGContextSetFillColorWithColor(context, traceColor);
    CGContextSetLineWidth(context, 4);
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetShouldAntialias(context, YES);


    NSInteger index = 0;

    // iterates over all the values
    for(NSNumber *value in values) {
        if(index == 0) {
            CGContextMoveToPoint(context, MARGIN_LEFT, MARGIN_TOP + availableHeight - initialValue);
        } else {
            // retrieves the value in float
            CGFloat valueFloat = [value floatValue];

            // calculates the current y value
            CGFloat yValue = (valueFloat / maximumValueFloat) * availableHeight;

            // adds the line to the point
            CGContextAddLineToPoint(context, MARGIN_LEFT + index * horizontalStepSize, MARGIN_TOP + availableHeight - yValue);
        }

        // increments the index
        index++;
    }

    // draws the cell's border
    CGContextStrokePath(context);

    index = 0;

    // iterates over all the values
    for(NSNumber *value in values) {
        // retrieves the value in float
        CGFloat valueFloat = [value floatValue];

        // calculates the current x and y value
        CGFloat xValue = MARGIN_LEFT + index * horizontalStepSize;
        CGFloat yValue = (valueFloat / maximumValueFloat) * availableHeight;

        CGFloat realYValue = MARGIN_TOP + availableHeight - yValue;

        CGFloat circuloXInit = xValue - (CIRCLE_SIZE / 2.0);
        CGFloat circuloYInit = realYValue - (CIRCLE_SIZE / 2.0);

        CGFloat circuloInnerXInit = xValue - (CIRCLE_INNER_SIZE / 2.0);
        CGFloat circuloInnerYInit = realYValue - (CIRCLE_INNER_SIZE / 2.0);

        // CIRCULO
        const CGColorRef traceColor = [[UIColor colorWithRed:53.0 / 255.0 green:127.0 / 255.0 blue:181.0 / 255.0 alpha:1.0] CGColor];
        CGContextSetFillColorWithColor(context, traceColor);
        CGRect rectangle = CGRectMake(circuloXInit, circuloYInit, CIRCLE_SIZE, CIRCLE_SIZE);
        CGContextAddEllipseInRect(context, rectangle);
        CGContextFillPath(context);

        // CIRCULO INNER
        //    const CGColorRef whiteColor = [[UIColor colorWithRed:53.0 / 255.0 green:127.0 / 255.0 blue:181.0 / 255.0 alpha:1.0] CGColor];
        CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);

        CGRect rectangleInner = CGRectMake(circuloInnerXInit, circuloInnerYInit, CIRCLE_INNER_SIZE, CIRCLE_INNER_SIZE);
        CGContextAddEllipseInRect(context, rectangleInner);
        CGContextFillPath(context);

        // increments the index
        index++;
    }




}

@end
