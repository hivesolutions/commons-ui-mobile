// Hive Mobile
// Copyright (c) 2008-2019 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2019 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "HMWeekWidgetView.h"

@implementation HMWeekWidgetView

@synthesize greenBackgroundColor = _greenBackgroundColor;
@synthesize redBackgroundColor = _redBackgroundColor;
@synthesize scrollView = _scrollView;
@synthesize styledPageControl = _styledPageControl;

- (id)init {
    // calls the super
    self = [super init];

    // initializes the structures
    [self initStructures];

    // returns self
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    // calls the super
    self = [super initWithCoder:aDecoder];

    // initializes the structures
    [self initStructures];

    // returns self
    return self;
}

- (void)dealloc {
    // releases the green background color
    [_greenBackgroundColor release];

    // releases the red background color
    [_redBackgroundColor release];

    // releases scroll view
    [_scrollView release];

    // releases the styled page control
    [_styledPageControl release];

    // calls the super
    [super dealloc];
}

- (void)initStructures {
    // initializes the background patterns
    [self initBackgroudPatterns];

    // initializes the number of pages
    _numberPages = 0;

    // sets the background color
    self.backgroundColor = [UIColor blackColor];

    // creates the scroll view
    CGRect scrollViewFrame = CGRectMake(0, 0, 320, 428);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:scrollViewFrame];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    scrollView.delegate = self;

    // creates the styled page control
    CGRect styledPageControlFrame = CGRectMake(0, 426, 320, 36);
    HMStyledPageControl *styledPageControl = [[HMStyledPageControl alloc] initWithFrame:styledPageControlFrame];
    styledPageControl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    styledPageControl.imageActive = [UIImage imageNamed:@"page_control_dot_active_white.png"];
    styledPageControl.imageInactive = [UIImage imageNamed:@"page_control_dot_inactive_white.png"];

    // adds the sub views
    [self addSubview:scrollView];
    [self addSubview:styledPageControl];

    // sets the attributes
    self.scrollView = scrollView;
    self.styledPageControl = styledPageControl;

    // releases the objects
    [scrollView release];
    [styledPageControl release];
}

- (void)initBackgroudPatterns {
    // retrieves the green background pattern image
    UIImage *greenBackgroundPatternImage = [UIImage imageNamed:@"green_screen.png"];

    // creates the green background color with the pattern image
    UIColor *greenBackgroundColor = [UIColor colorWithPatternImage:greenBackgroundPatternImage];

    // retrieves the red background pattern image
    UIImage *redBackgroundPatternImage = [UIImage imageNamed:@"red_screen.png"];

    // creates the red background color with the pattern image
    UIColor *redBackgroundColor = [UIColor colorWithPatternImage:redBackgroundPatternImage];

    // sets the attributes
    self.greenBackgroundColor = greenBackgroundColor;
    self.redBackgroundColor = redBackgroundColor;
}

- (void)doLayout {
    // retrieves the scroll view width
    CGFloat scrollViewWidth = self.scrollView.frame.size.width;
    CGFloat scrollViewHeight = self.scrollView.frame.size.height;

    // updates the scroll view content size
    self.scrollView.contentSize = CGSizeMake(_numberPages * scrollViewWidth, scrollViewHeight);

    // updates the number of pages in the styled page control
    self.styledPageControl.numberOfPages = _numberPages;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // retrieves the page width
    CGFloat pageWidth = scrollView.frame.size.width;

    // retrieves the content offset in x
    CGFloat contentOffsetX = scrollView.contentOffset.x;

    // calculates the current page based on the current x offset
    int page = floor((contentOffsetX - pageWidth / 2) / pageWidth) + 1;

    // sets the current page
    self.styledPageControl.currentPage = page;
}

- (void)addWeekWidgetPanel:(HMWeekWidgetPanelView *)weekWidgetPanel panelType:(HMWeekWidgetPanelType)panelType {
    // switches over the panel type
    switch(panelType) {
        case HMWeekWidgetGreenPanel:
            // sets the background panel color in the week widget panel
            weekWidgetPanel.backgroundColor = self.greenBackgroundColor;

            // breaks the switch
            break;

        case HMWeekWidgetRedPanel:
            // sets the background panel color in the week widget panel
            weekWidgetPanel.backgroundColor = self.redBackgroundColor;

            // breaks the switch
            break;

        default:
            // breaks the switch
            break;
    }

    // retrieves the scroll view width
    CGFloat scrollViewWidth = self.scrollView.frame.size.width;

    // retrieves the week widget panel frame
    CGRect weekWidgetPanelFrame = weekWidgetPanel.frame;

    // sets the week widget panel frame position
    weekWidgetPanelFrame.origin.x = _numberPages * scrollViewWidth;
    weekWidgetPanelFrame.origin.y = 0;

    // re-sets the week widget panel frame
    weekWidgetPanel.frame = weekWidgetPanelFrame;

    // adds the week widget panel to the scroll view
    [self.scrollView addSubview:weekWidgetPanel];

    // increments the number of pages
    _numberPages++;

    // does the layout
    [self doLayout];
}

@end
