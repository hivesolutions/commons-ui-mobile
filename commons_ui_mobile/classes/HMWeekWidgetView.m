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

    // sets the background color
    self.backgroundColor = [UIColor blackColor];

    // creates the scroll view
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 428)];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    scrollView.delegate = self;

    int NUMBER_PAGES = 3;

    // THIS IS AN HARDCODE !!!!!
    scrollView.contentSize = CGSizeMake(NUMBER_PAGES * 320, 428);

    // creates the styled page control
    HMStyledPageControl *styledPageControl = [[HMStyledPageControl alloc] initWithFrame:CGRectMake(0, 426, 320, 36)];
    styledPageControl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    styledPageControl.imageActive = [UIImage imageNamed:@"page_control_dot_active_white.png"];
    styledPageControl.imageInactive = [UIImage imageNamed:@"page_control_dot_inactive_white.png"];

    // THIS IS AN HARDCODE !!!!!
    styledPageControl.numberOfPages = NUMBER_PAGES;

    // creates the panel view
    UIView *panelView1 = [self createPanelView:0 panelType:HMWeekWidgetGreenPanel];
    UIView *panelView2 = [self createPanelView:320 panelType:HMWeekWidgetRedPanel];
    UIView *panelView3 = [self createPanelView:640 panelType:HMWeekWidgetGreenPanel];

    // adds the panel view to the scroll view
    [scrollView addSubview:panelView1];
    [scrollView addSubview:panelView2];
    [scrollView addSubview:panelView3];

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

    // releases the objects
    [greenBackgroundColor release];
    [redBackgroundColor release];
}

- (UIView *)createPanelView:(CGFloat)xPosition panelType:(HMWeekWidgetPanelType)panelType {
    // creates the panel view
    UIView *panelView = [[UIView alloc] initWithFrame:CGRectMake(xPosition, 0, 320, 428)];

    // switches over the panel type
    switch(panelType) {
        // in case the widget is of type green
        case HMWeekWidgetGreenPanel:
            // sets the panel view background color as green
            panelView.backgroundColor = self.greenBackgroundColor;

            // breaks the switch
            break;

        // in case the widget is of type red
        case HMWeekWidgetRedPanel:
            // sets the panel view background color as red
            panelView.backgroundColor = self.redBackgroundColor;

            // breaks the switch
            break;

        default:
            // breaks the switch
            break;
    }

    // creates the title label
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, 124, 160, 26)];
    titleLabel.text = @"Lugar da Joia";
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:21];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.shadowColor = [UIColor blackColor];
    titleLabel.shadowOffset = CGSizeMake(0, 1);

    // creates the sub title label
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, 104, 150, 20)];
    subTitleLabel.text = @"Loja";
    subTitleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    subTitleLabel.textColor = [UIColor colorWithRed:0.84 green:0.92 blue:0.85 alpha:1.0];
    subTitleLabel.backgroundColor = [UIColor clearColor];
    subTitleLabel.shadowColor = [UIColor blackColor];
    subTitleLabel.shadowOffset = CGSizeMake(0, 1);

    // creates the value label
    UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(188, 124, 104, 26)];
    valueLabel.text = @"2.500 EUR";
    valueLabel.textAlignment = UITextAlignmentRight;
    valueLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:21];
    valueLabel.textColor = [UIColor whiteColor];
    valueLabel.backgroundColor = [UIColor clearColor];
    valueLabel.shadowColor = [UIColor blackColor];
    valueLabel.shadowOffset = CGSizeMake(0, 1);

    // creates the field key label
    UILabel *fieldKeyLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, 172, 160, 20)];
    fieldKeyLabel.text = @"Terca-Feira";
    fieldKeyLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    fieldKeyLabel.textColor = [UIColor whiteColor];
    fieldKeyLabel.backgroundColor = [UIColor clearColor];
    fieldKeyLabel.shadowColor = [UIColor blackColor];
    fieldKeyLabel.shadowOffset = CGSizeMake(0, 1);

    // creates the field value label
    UILabel *fieldValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(188, 172, 104, 20)];
    fieldValueLabel.text = @"1.400 EUR";
    fieldValueLabel.textAlignment = UITextAlignmentRight;
    fieldValueLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    fieldValueLabel.textColor = [UIColor whiteColor];
    fieldValueLabel.backgroundColor = [UIColor clearColor];
    fieldValueLabel.shadowColor = [UIColor blackColor];
    fieldValueLabel.shadowOffset = CGSizeMake(0, 1);

    // creates the field key label
    UILabel *fieldKeyLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(28, 208, 160, 20)];
    fieldKeyLabel1.text = @"Quarta-Feira";
    fieldKeyLabel1.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    fieldKeyLabel1.textColor = [UIColor whiteColor];
    fieldKeyLabel1.backgroundColor = [UIColor clearColor];
    fieldKeyLabel1.shadowColor = [UIColor blackColor];
    fieldKeyLabel1.shadowOffset = CGSizeMake(0, 1);

    // creates the field value label
    UILabel *fieldValueLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(188, 208, 104, 20)];
    fieldValueLabel1.text = @"400 EUR";
    fieldValueLabel1.textAlignment = UITextAlignmentRight;
    fieldValueLabel1.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    fieldValueLabel1.textColor = [UIColor whiteColor];
    fieldValueLabel1.backgroundColor = [UIColor clearColor];
    fieldValueLabel1.shadowColor = [UIColor blackColor];
    fieldValueLabel1.shadowOffset = CGSizeMake(0, 1);

    // creates the field key label
    UILabel *fieldKeyLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(28, 244, 160, 20)];
    fieldKeyLabel2.text = @"Quinta-Feira";
    fieldKeyLabel2.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    fieldKeyLabel2.textColor = [UIColor whiteColor];
    fieldKeyLabel2.backgroundColor = [UIColor clearColor];
    fieldKeyLabel2.shadowColor = [UIColor blackColor];
    fieldKeyLabel2.shadowOffset = CGSizeMake(0, 1);

    // creates the field value label
    UILabel *fieldValueLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(188, 244, 104, 20)];
    fieldValueLabel2.text = @"2.200 EUR";
    fieldValueLabel2.textAlignment = UITextAlignmentRight;
    fieldValueLabel2.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    fieldValueLabel2.textColor = [UIColor whiteColor];
    fieldValueLabel2.backgroundColor = [UIColor clearColor];
    fieldValueLabel2.shadowColor = [UIColor blackColor];
    fieldValueLabel2.shadowOffset = CGSizeMake(0, 1);

    // creates the field key label
    UILabel *fieldKeyLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(28, 280, 160, 20)];
    fieldKeyLabel3.text = @"Sexta-Feira";
    fieldKeyLabel3.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    fieldKeyLabel3.textColor = [UIColor whiteColor];
    fieldKeyLabel3.backgroundColor = [UIColor clearColor];
    fieldKeyLabel3.shadowColor = [UIColor blackColor];
    fieldKeyLabel3.shadowOffset = CGSizeMake(0, 1);

    // creates the field value label
    UILabel *fieldValueLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(188, 280, 104, 20)];
    fieldValueLabel3.text = @"30 EUR";
    fieldValueLabel3.textAlignment = UITextAlignmentRight;
    fieldValueLabel3.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    fieldValueLabel3.textColor = [UIColor whiteColor];
    fieldValueLabel3.backgroundColor = [UIColor clearColor];
    fieldValueLabel3.shadowColor = [UIColor blackColor];
    fieldValueLabel3.shadowOffset = CGSizeMake(0, 1);

    // creates the field key label
    UILabel *fieldKeyLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(28, 316, 160, 20)];
    fieldKeyLabel4.text = @"Sabado";
    fieldKeyLabel4.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    fieldKeyLabel4.textColor = [UIColor whiteColor];
    fieldKeyLabel4.backgroundColor = [UIColor clearColor];
    fieldKeyLabel4.shadowColor = [UIColor blackColor];
    fieldKeyLabel4.shadowOffset = CGSizeMake(0, 1);

    // creates the field value label
    UILabel *fieldValueLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(188, 316, 104, 20)];
    fieldValueLabel4.text = @"1.340 EUR";
    fieldValueLabel4.textAlignment = UITextAlignmentRight;
    fieldValueLabel4.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    fieldValueLabel4.textColor = [UIColor whiteColor];
    fieldValueLabel4.backgroundColor = [UIColor clearColor];
    fieldValueLabel4.shadowColor = [UIColor blackColor];
    fieldValueLabel4.shadowOffset = CGSizeMake(0, 1);

    // creates the field key label
    UILabel *fieldKeyLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(28, 352, 160, 20)];
    fieldKeyLabel5.text = @"Domingo";
    fieldKeyLabel5.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    fieldKeyLabel5.textColor = [UIColor whiteColor];
    fieldKeyLabel5.backgroundColor = [UIColor clearColor];
    fieldKeyLabel5.shadowColor = [UIColor blackColor];
    fieldKeyLabel5.shadowOffset = CGSizeMake(0, 1);

    // creates the field value label
    UILabel *fieldValueLabel5 = [[UILabel alloc] initWithFrame:CGRectMake(188, 352, 104, 20)];
    fieldValueLabel5.text = @"23.020 EUR";
    fieldValueLabel5.textAlignment = UITextAlignmentRight;
    fieldValueLabel5.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    fieldValueLabel5.textColor = [UIColor whiteColor];
    fieldValueLabel5.backgroundColor = [UIColor clearColor];
    fieldValueLabel5.shadowColor = [UIColor blackColor];
    fieldValueLabel5.shadowOffset = CGSizeMake(0, 1);

    // creates the standard text color for toolbar labels
    UIColor *toolbarLabelTextColor = [UIColor whiteColor];

    // creates the standard background color for toolbar labels
    UIColor *toolbarLabelBackgroundColor = [UIColor clearColor];

    // retrieves the updated string
    NSString *updatedString = NSLocalizedString(@"Updated", @"Updated");

    // retrieves the current date
    NSDate *date = [NSDate date];

    // creates the date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    // sets the date formatter for date format
    [dateFormatter setDateFormat:@"dd/MM/yy"];

    // retrieves the date string
    NSString *dateString = [dateFormatter stringFromDate:date];

    // sets the date formatter for hour format
    [dateFormatter setDateFormat:@"HH:mm"];

    // retrieves the hour string
    NSString *hourString = [dateFormatter stringFromDate:date];

    // creates the left toolbar label
    UILabel *leftLabel = [[UILabel alloc] init];
    leftLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    leftLabel.textColor = toolbarLabelTextColor;
    leftLabel.backgroundColor = toolbarLabelBackgroundColor;
    leftLabel.textAlignment = UITextAlignmentCenter;
    leftLabel.text = updatedString;
    leftLabel.shadowColor = [UIColor blackColor];
    leftLabel.shadowOffset = CGSizeMake(0, 1);

    // sets size to fit
    [leftLabel sizeToFit];

    // creates the center toolbar label
    UILabel *centerLabel = [[UILabel alloc] init];
    centerLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    centerLabel.textColor = toolbarLabelTextColor;
    centerLabel.backgroundColor = toolbarLabelBackgroundColor;
    centerLabel.textAlignment = UITextAlignmentCenter;
    centerLabel.text = dateString;
    centerLabel.shadowColor = [UIColor blackColor];
    centerLabel.shadowOffset = CGSizeMake(0, 1);

    // sets size to fit
    [centerLabel sizeToFit];

    // creates the right toolbar label
    UILabel *rightLabel = [[UILabel alloc] init];
    rightLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    rightLabel.textColor = toolbarLabelTextColor;
    rightLabel.backgroundColor = toolbarLabelBackgroundColor;
    rightLabel.textAlignment = UITextAlignmentCenter;
    rightLabel.text = hourString;
    rightLabel.shadowColor = [UIColor blackColor];
    rightLabel.shadowOffset = CGSizeMake(0, 1);

    // sets the size to fit
    [rightLabel sizeToFit];

    // creates the bar button item to host the left label
    UIBarButtonItem *leftLabelItem = [[UIBarButtonItem alloc] initWithCustomView:leftLabel];

    // creates the bar button item to host the center label
    UIBarButtonItem *centerLabelItem = [[UIBarButtonItem alloc] initWithCustomView:centerLabel];

    // creates the bar button item to host the right label
    UIBarButtonItem *rightLabelItem = [[UIBarButtonItem alloc] initWithCustomView:rightLabel];

    // creates the toolbar items list
    /*NSArray *items = [NSArray arrayWithObjects:leftLabelItem, centerLabelItem, rightLabelItem];

     // sets the toolbar items in the toolbar
     [self.navigationController.toolbar setItems:items animated:NO];
     */

    CGFloat spacing = 6.0;

    CGFloat leftLabelWidth = leftLabel.frame.size.width;
    CGFloat centerLabelWidth = centerLabel.frame.size.width;
    CGFloat rightLabelWidth = rightLabel.frame.size.width;

    CGFloat totalWidth = leftLabelWidth + centerLabelWidth + rightLabelWidth + 2 * spacing;

    CGFloat currentWidth = self.frame.size.width;

    CGFloat margin = (currentWidth - totalWidth) / 2.0;

    CGRect leftLabelFrame = leftLabel.frame;
    CGRect centerLabelFrame = centerLabel.frame;
    CGRect rightLabelFrame = rightLabel.frame;

    leftLabelFrame.origin.x = margin;
    leftLabelFrame.origin.y = 390;
    centerLabelFrame.origin.x = margin + leftLabelWidth + spacing;
    centerLabelFrame.origin.y = 390;
    rightLabelFrame.origin.x = margin + leftLabelWidth + spacing + centerLabelWidth + spacing;
    rightLabelFrame.origin.y = 390;

    leftLabel.frame = leftLabelFrame;
    centerLabel.frame = centerLabelFrame;
    rightLabel.frame = rightLabelFrame;

    [panelView addSubview:leftLabel];
    [panelView addSubview:centerLabel];
    [panelView addSubview:rightLabel];

    // creates the image
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(132, 30, 58, 58)];
    image.image = [UIImage imageNamed:@"plus_widget.png"];

    // adds the subviews
    [panelView addSubview:titleLabel];
    [panelView addSubview:subTitleLabel];
    [panelView addSubview:valueLabel];
    [panelView addSubview:fieldKeyLabel];
    [panelView addSubview:fieldValueLabel];
    [panelView addSubview:fieldKeyLabel1];
    [panelView addSubview:fieldValueLabel1];
    [panelView addSubview:fieldKeyLabel2];
    [panelView addSubview:fieldValueLabel2];
    [panelView addSubview:fieldKeyLabel3];
    [panelView addSubview:fieldValueLabel3];
    [panelView addSubview:fieldKeyLabel4];
    [panelView addSubview:fieldValueLabel4];
    [panelView addSubview:fieldKeyLabel5];
    [panelView addSubview:fieldValueLabel5];
    [panelView addSubview:image];

    // releases the objects
    [leftLabelItem release];
    [centerLabelItem release];
    [rightLabelItem release];
    [leftLabel release];
    [centerLabel release];
    [rightLabel release];
    [dateFormatter release];

    [titleLabel release];
    [subTitleLabel release];
    [valueLabel release];
    [fieldKeyLabel release];
    [fieldValueLabel release];
    [fieldKeyLabel1 release];
    [fieldValueLabel1 release];
    [fieldKeyLabel2 release];
    [fieldValueLabel2 release];
    [fieldKeyLabel3 release];
    [fieldValueLabel3 release];
    [fieldKeyLabel4 release];
    [fieldValueLabel4 release];
    [fieldKeyLabel5 release];
    [fieldValueLabel5 release];
    [image release];

    // returns the panel view
    return [panelView autorelease];
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
