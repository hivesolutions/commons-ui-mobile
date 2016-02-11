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

#import "HMStyledPageControl.h"

@implementation HMStyledPageControl

@synthesize currentCachePage = _currentCachePage;
@synthesize imageActive = _imageActive;
@synthesize imageInactive = _imageInactive;

- (id)init {
    // initializes the structures
    [self initStructures];

    // calls the super
    self = [super init];

    // returns self
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    // initializes the structures
    [self initStructures];

    // calls the super
    self = [super initWithFrame:frame];

    // returns self
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    // initializes the structures
    [self initStructures];

    // calls the super
    self = [super initWithCoder:aDecoder];

    // returns self
    return self;
}

- (void)dealloc {
    // releases the image active
    [_imageActive release];

    // releases the image inactive
    [_imageInactive release];

    // calls the super
    [super dealloc];
}

- (void)initStructures {
    // loads the dot images
    self.imageActive = [UIImage imageNamed:HM_STYLED_PAGE_CONTROL_DOT_ACTIVE];
    self.imageInactive = [UIImage imageNamed:HM_STYLED_PAGE_CONTROL_DOT_INACTIVE];
}

- (void)setCurrentPage:(NSInteger)page {
    // calls the super
    [super setCurrentPage:page];

    // in case the page is already cached
    if(page == self.currentCachePage) {
        // returns immediately
        return;
    }

    // retrieves the subviews count
    NSUInteger subviewsCount = self.subviews.count;

    // iterates over all the subviews to update the images
    for(NSUInteger subviewIndex = 0; subviewIndex < subviewsCount; subviewIndex++) {
        // retrieves the current subview
        UIImageView *subview = [self.subviews objectAtIndex:subviewIndex];

        // in case the subview represents the currently
        // selected page sets the active image in the
        // subview otherwise sets the inactive image in the subview
        subview.image = subviewIndex == page ? self.imageActive : self.imageInactive;
    }

    // sets the current cache page
    self.currentCachePage = page;
}

- (void)setNumberOfPages:(NSInteger)pages {
    // calls the super
    [super setNumberOfPages:pages];

    // retrieves the first subview and sets the active
    // image for it (selected page controls)
    UIImageView *subview = [self.subviews objectAtIndex:0];
    subview.image = self.imageActive;

    // retrieves the subviews count
    NSUInteger subviewsCount = self.subviews.count;

    // iterates over all the other subviews to set the
    // inactive image (unselected page controls)
    for(NSUInteger subviewIndex = 1; subviewIndex < subviewsCount; subviewIndex++) {
        // retrieves the current subview
        UIImageView *subview = [self.subviews objectAtIndex:subviewIndex];

        // sets the inactive image in the subview
        subview.image = self.imageInactive;
    }
}

@end
