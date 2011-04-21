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

// __author__    = Jo‹o Magalh‹es <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision: 2390 $
// __date__      = $LastChangedDate: 2009-04-02 08:36:50 +0100 (qui, 02 Abr 2009) $
// __copyright__ = Copyright (c) 2008 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "HMOptionsView.h"

@implementation HMOptionsView

@synthesize optionsButtons = _optionsButtons;
@synthesize searchBar = _searchBar;
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
    // releases the options buttons
    [_optionsButtons release];

    // releases the search bar
    [_searchBar release];

    // releases scroll view
    [_scrollView release];

    // releases the styled page control
    [_styledPageControl release];

    // calls the super
    [super dealloc];
}

- (void)initStructures {
    // creates tje options buttons
    NSMutableArray *optionsButtons = [[NSMutableArray alloc] init];

    // creates the search bar
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    searchBar.barStyle = UIBarStyleBlackTranslucent;
    searchBar.tintColor = [UIColor colorWithRed:0.48 green:0.48 blue:0.48 alpha:1.0];

    // creates the scroll view
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, 320, 336)];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    scrollView.delegate = self;

    // creates the styled page control
    HMStyledPageControl *styledPageControl = [[HMStyledPageControl alloc] initWithFrame:CGRectMake(0, 380, 320, 36)];
    styledPageControl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;

    // adds the subviews
    [self addSubview:searchBar];
    [self addSubview:scrollView];
    [self addSubview:styledPageControl];

    // sets the attributes
    self.optionsButtons = optionsButtons;
    self.searchBar = searchBar;
    self.scrollView = scrollView;
    self.styledPageControl = styledPageControl;

    // releases the objects
    [styledPageControl release];
    [scrollView release];
    [searchBar release];
    [optionsButtons release];
}

- (void)doLayout {
    // in case the scroll view is not set
    if(!self.scrollView) {
        // returns immediately
        return;
    }

    // retrieves the width
    CGFloat width = self.frame.size.width;

    // retrieves the height
    CGFloat height = self.frame.size.height;

    // starts the item margin
    CGFloat itemMargin = 0;

    // retrieves the line margin
    CGFloat lineMargin = [self getLineMargin];

    // retrieves the scroll view width
    CGFloat scrollViewWidth = self.scrollView.frame.size.width;

    // retrieves the scroll view height
    CGFloat scrollViewHeight = self.scrollView.frame.size.height;

    // sets the remaining width the scroll view width
    CGFloat remainingWidth = scrollViewWidth;

    // sets the remaining height the scroll view width
    CGFloat remainingHeight = scrollViewHeight;

    // sets the initial current x position
    CGFloat currentX = 0;

    // sets the initial current y position
    CGFloat currentY = 0;

    // sets the initial current page x position
    CGFloat currentPageX = 0;

    // sets the initial current page position
    CGFloat currentPage = 0;

    // in case the height is greater than
    if(height > HM_OPTIONS_VIEW_MAXIMUM_HEIGHT_MARGIN) {
        // sets the item margin
        itemMargin = HM_OPTIONS_VIEW_VERTICAL_MARGIN;
    }

    // iterates over all the option buttons
    for(HMOptionsButtonView *optionsButton in self.optionsButtons) {
        // retrieves the options button frame
        CGRect optionsButtonFrame = optionsButton.frame;

        // retrieves the options button width
        CGFloat optionsButtonWidth = optionsButtonFrame.size.width;

        // retrieves the options button height
        CGFloat optionsButtonHeight = optionsButtonFrame.size.height;

        // in case the remaining scroll view width is not enought
        // to hold the options button view (new line)
        if(remainingWidth < optionsButtonWidth) {
            // resets the remaining view width
            remainingWidth = scrollViewWidth;

            // decrements the options button height
            // from the remaining height
            remainingHeight -= optionsButtonHeight;

            // increments the current y position
            currentY += optionsButtonHeight + itemMargin;

            // in case the remaining scroll view height is not enought
            // to hold the options button view (new page)
            if(remainingHeight < optionsButtonHeight) {
                // resets the remaining view height
                remainingHeight = scrollViewHeight;

                // updates the current page x position
                currentPageX = currentPageX + scrollViewWidth;

                // resets the current y position
                currentY = 0;

                // increments the current page
                currentPage += 1;
            }

            // resets the current x position
            currentX = currentPageX;
        }

        // sets the options button frame origin
        optionsButtonFrame.origin.x = currentX + lineMargin;
        optionsButtonFrame.origin.y = currentY;

        // replaces the options button frame
        optionsButton.frame = optionsButtonFrame;

        // decrements the options button width
        // from the remaining width
        remainingWidth -= optionsButtonWidth;

        // increments the current x position
        currentX += optionsButtonWidth;
    }

    // calculates the number of pages
    CGFloat numberPages = currentPage + 1;

    // updates the scroll view content size
    self.scrollView.contentSize = CGSizeMake(width * numberPages, height - HM_OPTIONS_VIEW_EXTRA_HEIGHT);

    // updates the number of pages
    self.styledPageControl.numberOfPages = numberPages;
}

- (void)addOptionsButton:(HMOptionsButtonView *)optionsButton {
    // adds the options butotn to the options buttons list
    [self.optionsButtons addObject:optionsButton];

    // adds the options button as sub view
    // of the scroll view
    [self.scrollView addSubview:optionsButton];

    // redoes the layout
    [self doLayout];
}

- (CGFloat)getLineMargin {
    // in case there are no buttons in the
    // options buttons list
    if([self.optionsButtons count] < 1) {
        // returns immediately (invalid state)
        return 0.0;
    }

    // retrieves the options button to be the reference
    // for marign calculation
    HMOptionsButtonView *referenceOptionsButton = [self.optionsButtons objectAtIndex:0];

    // retrieves the width
    CGFloat width = self.frame.size.width;

    // retrieves the reference options buttn width
    CGFloat referenceOptionsButtonWidth = referenceOptionsButton.frame.size.width;

    // calculates the width modulus from
    // the with and the reference opti
    int widthModulus = (int) width % (int) referenceOptionsButtonWidth;

    // divides the width modulus by two to get the line margin
    CGFloat lineMargin = round((CGFloat) widthModulus / 2.0);

    // returns the line margin
    return lineMargin;
}

- (void)setFrame:(CGRect)frame {
    // calls the super
    [super setFrame:frame];

    // does the layout of the view
    // in order to expand the option items
    [self doLayout];
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

+ (void)_keepAtLinkTime {
}

@end
