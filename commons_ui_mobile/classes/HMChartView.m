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

// __author__    = João Magalhães <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision$
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008-2015 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "HMChartView.h"

#define MARGIN_LEFT 0.0
#define MARGIN_RIGHT 0.0
#define MARGIN_TOP 20.0
#define MARGIN_BOTTOM 10.0


#define VERTICAL_STEPS 8
#define HORIZONTAL_STEPS 6


#define CIRCLE_SIZE 12.0

#define CIRCLE_INNER_SIZE 4.0

#define VALUES [NSNumber numberWithFloat:1200.0], [NSNumber numberWithFloat:400.0], [NSNumber numberWithFloat:4000.0], [NSNumber numberWithFloat:2300.0], [NSNumber numberWithFloat:130.0], [NSNumber numberWithFloat:630.0], [NSNumber numberWithFloat:1080.0]

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

    CGFloat maximumValueFloat = maximumValue.floatValue;

    CGFloat initialValue = (12.0 / maximumValueFloat) * availableHeight;




    // retrieves the current graphics context
    CGContextRef context = UIGraphicsGetCurrentContext();

    // creates the trace color
    const CGColorRef traceColor = [[UIColor colorWithRed:53.0 / 255.0 green:127.0 / 255.0 blue:181.0 / 255.0 alpha:1.0] CGColor];


    CGContextSetStrokeColorWithColor(context, traceColor);
    CGContextSetFillColorWithColor(context, traceColor);
    CGContextSetLineWidth(context, 5);
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetShouldAntialias(context, YES);





    const CGColorRef lightBlueColor = [[UIColor colorWithRed:223.0 / 255.0 green:232.0 / 255.0 blue:237.0 / 255.0 alpha:1.0] CGColor];
    CGContextSetFillColorWithColor(context, lightBlueColor);

    NSInteger index = 0;

    CGContextMoveToPoint(context, MARGIN_LEFT, MARGIN_TOP + availableHeight);

    // iterates over all the values
    for(NSNumber *value in values) {
        // retrieves the value in float
        CGFloat valueFloat = value.floatValue;

        // calculates the current y value
        CGFloat yValue = (valueFloat / maximumValueFloat) * availableHeight;

        // adds the line to the point
        CGContextAddLineToPoint(context, MARGIN_LEFT + index * horizontalStepSize, MARGIN_TOP + availableHeight - yValue);


        // increments the index
        index++;
    }

    CGContextAddLineToPoint(context, MARGIN_LEFT + HORIZONTAL_STEPS * horizontalStepSize, MARGIN_TOP + availableHeight);

    // draws the cell's border
    CGContextFillPath(context);




    CGContextSetAllowsAntialiasing(context, NO);
    CGContextSetShouldAntialias(context, NO);

    const CGColorRef lineColor = [[UIColor colorWithRed:146.0 / 255.0 green:164.0 / 255.0 blue:176.0 / 255.0 alpha:1.0] CGColor];
    CGContextSetStrokeColorWithColor(context, lineColor);
    CGContextSetLineWidth(context, 0.25);

    CGContextMoveToPoint(context, MARGIN_LEFT, MARGIN_TOP + availableHeight);
    CGContextAddLineToPoint(context, MARGIN_LEFT + availableWidth, MARGIN_TOP + availableHeight);

    // draws the cell's border
    CGContextStrokePath(context);

    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetShouldAntialias(context, YES);

    CGContextSetLineWidth(context, 5);


    // creates the trace color

    CGContextSetStrokeColorWithColor(context, traceColor);


     index = 0;

    // iterates over all the values
    for(NSNumber *value in values) {
        // retrieves the value in float
        CGFloat valueFloat = value.floatValue;

        // calculates the current y value
        CGFloat yValue = (valueFloat / maximumValueFloat) * availableHeight;

        if(index == 0) {
            CGContextMoveToPoint(context, MARGIN_LEFT, MARGIN_TOP + availableHeight - yValue);
        } else {
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
        if(index == 0 || index == HORIZONTAL_STEPS) {
            // increments the index
            index++;

            // continues the loop
            continue;
        }

        // retrieves the value in float
        CGFloat valueFloat = value.floatValue;

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
        const CGColorRef whiteColor = [[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0] CGColor];
        CGContextSetFillColorWithColor(context, whiteColor);

        CGRect rectangleInner = CGRectMake(circuloInnerXInit, circuloInnerYInit, CIRCLE_INNER_SIZE, CIRCLE_INNER_SIZE);
        CGContextAddEllipseInRect(context, rectangleInner);
        CGContextFillPath(context);

        // increments the index
        index++;
    }




    index = 0;

    // iterates over all the values
    for(NSNumber *value in values) {
        if(index == 0 || index == HORIZONTAL_STEPS) {
            // increments the index
            index++;

            // continues the loop
            continue;
        }

        NSNumber *previousValue = [values objectAtIndex:index - 1];
        NSNumber *nextValue = [values objectAtIndex:index + 1];

        // retrieves the value in float
        CGFloat valueFloat = value.floatValue;
        CGFloat previousValueFloat = previousValue.floatValue;
        CGFloat nextValueFloat = nextValue.floatValue;

        NSString *valueString = [NSString stringWithFormat:@"%2.0f", valueFloat];

        // calculates the current x and y value
        CGFloat xValue = MARGIN_LEFT + index * horizontalStepSize;
        CGFloat yValue = (valueFloat / maximumValueFloat) * availableHeight;

        CGFloat realYValue = MARGIN_TOP + availableHeight - yValue;

        UIFont *font = [UIFont fontWithName:@"Verdana-Bold" size:10];
        CGSize size = [valueString sizeWithFont:font];

        // A ESKERDA
        if(previousValueFloat < valueFloat && nextValueFloat > valueFloat) {
            xValue -= size.width;
            realYValue -= 12;
        }
        // A DIREITA
        else if(previousValueFloat > valueFloat && nextValueFloat < valueFloat) {
            realYValue -= 12;
        }
        // POR BAIXO
        else if(previousValueFloat > valueFloat && nextValueFloat > valueFloat) {
            xValue -= (size.width / 2.0);
            realYValue += 16;
        }
        // NORMAL
        else {
            xValue -= (size.width / 2.0);
            realYValue -= 12;
        }

        const CGColorRef textColor = [[UIColor colorWithRed:127.0 / 255.0 green:173.0 / 255.0 blue:207.0 / 255.0 alpha:1.0] CGColor];
        CGContextSetFillColorWithColor(context, textColor);

        CGContextSetTextDrawingMode(context, kCGTextFill);
        CGContextSelectFont(context, "Verdana-Bold", 10, kCGEncodingMacRoman);
        CGContextSetTextMatrix(context, CGAffineTransformMake(1.0,0.0, 0.0, -1.0, 0.0, 0.0));
        CGContextShowTextAtPoint(context, xValue, realYValue, [valueString cString], strlen([valueString cString]));

        index++;
    }
}

@end
