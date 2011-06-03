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

#define MARGIN_LEFT 10
#define MARGIN_RIGHT 10
#define MARGIN_TOP 10
#define MARGIN_BOTTOM 10


#define VERTICAL_STEPS 8
#define HORIZONTAL_STEPS 6


#define MAXIMUM_VAUE 100


#define VALUES [NSNumber numberWithInt:12], [NSNumber numberWithInt:34], [NSNumber numberWithInt:56], [NSNumber numberWithInt:78], [NSNumber numberWithInt:12], [NSNumber numberWithInt:56]

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
    NSInteger frameWidth = self.frame.size.width;
    NSInteger frameHeight = self.frame.size.height;

    printf("%d, %d\n", frameWidth, frameHeight);

    NSArray *values = [NSArray arrayWithObjects:VALUES, nil];

    NSNumber *maximumValue = [NSNumber numberWithInt:0];

    for (NSNumber *value in values) {
        if(value > maximumValue) {
            maximumValue = value;
        }
    }

    // calculates the vertical and horizontal margins
    NSInteger marginHorizontal = MARGIN_LEFT + MARGIN_RIGHT;
    NSInteger marginVertical = MARGIN_TOP + MARGIN_BOTTOM;

    NSInteger availableWidth = frameWidth - marginHorizontal;
    NSInteger availableHeight = frameHeight - marginVertical;


    NSInteger verticalStepSize = availableHeight / VERTICAL_STEPS;
    NSInteger horizontalStepSize = availableWidth / HORIZONTAL_STEPS;








    // retrieves the current graphics context
    CGContextRef context = UIGraphicsGetCurrentContext();

    // creates the trace color
    const CGColorRef traceColor = [[UIColor colorWithRed:53.0 / 255.0 green:127.0 / 255.0 blue:181.0 / 255.0 alpha:1.0] CGColor];


    CGContextSetStrokeColorWithColor(context, traceColor);
    CGContextSetLineWidth(context, 4);
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetShouldAntialias(context, YES);








    // creates the cell's border
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, MARGIN_LEFT, MARGIN_BOTTOM + ((((float) 12) / [maximumValue floatValue]) * availableHeight));
    CGPathAddLineToPoint(path, NULL, MARGIN_LEFT + 1 * horizontalStepSize, 40);
    CGPathCloseSubpath(path);

    // draws the cell's border
    CGContextAddPath(context, path);
    CGPathRelease(path);
    CGContextStrokePath(context);
}

@end
