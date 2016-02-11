// Hive Mobile
// Copyright (c) 2008-2016 Hive Solutions Lda.
//
// This file is part of Hive Mobile.
//
// Hive Mobile is free software: you can redistribute it and/or modify
// it under the terms of the Apache License as published by the Apache
// Foundation, either version 2.0 of the License, or (at your option) any
// later version.
//
// Hive Mobile is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// Apache License for more details.
//
// You should have received a copy of the Apache License along with
// Hive Mobile. If not, see <http://www.apache.org/licenses/>.

// __author__    = João Magalhães <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision$
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008-2016 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "HMGradientView.h"

@implementation HMGradientView

@synthesize gradientColors = _gradientColors;

- (void)dealloc {
    // releases the gradient colors
    [_gradientColors release];

    // calls the super
    [super dealloc];
}

+ (Class)layerClass {
    return [CAGradientLayer class];
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

    // retrieves the gradient layer
    CAGradientLayer *gradientLayer = (CAGradientLayer *) self.layer;

    // creates a list of gradient color refs
    NSMutableArray *gradientColorRefs = [[NSMutableArray alloc] init];

    // converts the gradient colors to color references
    for(UIColor *gradientColor in gradientColors) {
        // retrieves the gradient color reference
        CGColorRef gradientColorRef = gradientColor.CGColor;

        // adds the reference to the list
        [gradientColorRefs addObject:(id)gradientColorRef];
    }

    // sets the gradient color references in the gradient layer
    gradientLayer.colors = gradientColorRefs;

    // releases the gradient color refs
    [gradientColorRefs release];
}

@end
