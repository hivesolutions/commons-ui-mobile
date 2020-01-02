// Hive Mobile
// Copyright (c) 2008-2020 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2020 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "HMWeekWidgetPanelView.h"

@implementation HMWeekWidgetPanelView

@synthesize titleLabel = _titleLabel;
@synthesize subTitleLabel = _subTitleLabel;
@synthesize valueLabel = _valueLabel;
@synthesize imageView = _imageView;
@synthesize weekItemLabels = _weekItemLabels;
@synthesize leftLabel = _leftLabel;
@synthesize centerLabel = _centerLabel;
@synthesize rightLabel = _rightLabel;

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

- (id)initWithFrame:(CGRect)frame {
    // calls the super
    self = [super initWithFrame:frame];

    // initializes the structures
    [self initStructures];

    // returns self
    return self;
}

- (void)dealloc {
    // releases the title label
    [_titleLabel release];

    // releases the sub title label
    [_subTitleLabel release];

    // releases the value label
    [_valueLabel release];

    // releases the image view
    [_imageView release];

    // releases the week item labels
    [_weekItemLabels release];

    // releases the left label
    [_leftLabel release];

    // releases the center label
    [_centerLabel release];

    // releases the right label
    [_rightLabel release];

    // calls the super
    [super dealloc];
}

- (void)initStructures {
    // creates the title label
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, 124, 160, 26)];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:21];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.shadowColor = [UIColor blackColor];
    titleLabel.shadowOffset = CGSizeMake(0, 1);

    // creates the sub title label
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, 104, 150, 20)];
    subTitleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    subTitleLabel.textColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    subTitleLabel.backgroundColor = [UIColor clearColor];
    subTitleLabel.shadowColor = [UIColor blackColor];
    subTitleLabel.shadowOffset = CGSizeMake(0, 1);

    // creates the value label
    UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(188, 124, 104, 26)];
    valueLabel.textAlignment = UITextAlignmentRight;
    valueLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:21];
    valueLabel.textColor = [UIColor whiteColor];
    valueLabel.backgroundColor = [UIColor clearColor];
    valueLabel.shadowColor = [UIColor blackColor];
    valueLabel.shadowOffset = CGSizeMake(0, 1);

    // creates the image view
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(132, 30, 58, 58)];

    // creates the week item labels list
    NSMutableArray *weekItemLabels = [[NSMutableArray alloc] init];

    // starts the current y position
    CGFloat currentY = 172.0;

    // iterates over the items
    for(int index = 0; index < 6; index++) {
        // creates the week item key label
        UILabel *weekItemKeyLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, currentY, 160, 20)];
        weekItemKeyLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        weekItemKeyLabel.textColor = [UIColor whiteColor];
        weekItemKeyLabel.backgroundColor = [UIColor clearColor];
        weekItemKeyLabel.shadowColor = [UIColor blackColor];
        weekItemKeyLabel.shadowOffset = CGSizeMake(0, 1);

        // creates the week item value label
        UILabel *weekItemValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(188, currentY, 104, 20)];
        weekItemValueLabel.textAlignment = UITextAlignmentRight;
        weekItemValueLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        weekItemValueLabel.textColor = [UIColor whiteColor];
        weekItemValueLabel.backgroundColor = [UIColor clearColor];
        weekItemValueLabel.shadowColor = [UIColor blackColor];
        weekItemValueLabel.shadowOffset = CGSizeMake(0, 1);

        // adds the labels to the week item labels list
        [weekItemLabels addObject:weekItemKeyLabel];
        [weekItemLabels addObject:weekItemValueLabel];

        // adds the subviews
        [self addSubview:weekItemKeyLabel];
        [self addSubview:weekItemValueLabel];

        // releases the objects
        [weekItemKeyLabel release];
        [weekItemValueLabel release];

        // increments the curren y position value
        currentY += 35;
    }

    // creates the left toolbar label
    UILabel *leftLabel = [[UILabel alloc] init];
    leftLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    leftLabel.textColor = [UIColor whiteColor];
    leftLabel.backgroundColor = [UIColor clearColor];
    leftLabel.textAlignment = UITextAlignmentCenter;
    leftLabel.shadowColor = [UIColor blackColor];
    leftLabel.shadowOffset = CGSizeMake(0, 1);

    // creates the center toolbar label
    UILabel *centerLabel = [[UILabel alloc] init];
    centerLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    centerLabel.textColor = [UIColor whiteColor];;
    centerLabel.backgroundColor = [UIColor clearColor];
    centerLabel.textAlignment = UITextAlignmentCenter;
    centerLabel.shadowColor = [UIColor blackColor];
    centerLabel.shadowOffset = CGSizeMake(0, 1);

    // creates the right toolbar label
    UILabel *rightLabel = [[UILabel alloc] init];
    rightLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    rightLabel.textColor = [UIColor whiteColor];;
    rightLabel.backgroundColor = [UIColor clearColor];
    rightLabel.textAlignment = UITextAlignmentCenter;
    rightLabel.shadowColor = [UIColor blackColor];
    rightLabel.shadowOffset = CGSizeMake(0, 1);

    // adds the subviews
    [self addSubview:titleLabel];
    [self addSubview:subTitleLabel];
    [self addSubview:valueLabel];
    [self addSubview:imageView];
    [self addSubview:leftLabel];
    [self addSubview:centerLabel];
    [self addSubview:rightLabel];

    // sets the attributes
    self.titleLabel = titleLabel;
    self.subTitleLabel = subTitleLabel;
    self.valueLabel = valueLabel;
    self.imageView = imageView;
    self.weekItemLabels = weekItemLabels;
    self.leftLabel = leftLabel;
    self.centerLabel = centerLabel;
    self.rightLabel = rightLabel;

    // releases the objects
    [titleLabel release];
    [subTitleLabel release];
    [valueLabel release];
    [imageView release];
    [weekItemLabels release];
    [leftLabel release];
    [centerLabel release];
    [rightLabel release];
}

- (void)doLayoutStatus {
    // sizes the labels to fit
    [self.rightLabel sizeToFit];
    [self.centerLabel sizeToFit];
    [self.leftLabel sizeToFit];

    // retrieves the label frames
    CGRect leftLabelFrame = self.leftLabel.frame;
    CGRect centerLabelFrame = self.centerLabel.frame;
    CGRect rightLabelFrame = self.rightLabel.frame;

    // retrieves the label width (after the size to fit)
    CGFloat leftLabelWidth = leftLabelFrame.size.width;
    CGFloat centerLabelWidth = centerLabelFrame.size.width;
    CGFloat rightLabelWidth = rightLabelFrame.size.width;

    // calculats the total width required to position the labels
    CGFloat totalWidth = leftLabelWidth + centerLabelWidth + rightLabelWidth + 2 * HM_WEEK_WIDGET_PANEL_VIEW_STATUS_LABEL_SPACING;

    // retrieves the current (available) width
    CGFloat currentWidth = self.frame.size.width;

    // calculates the margin
    CGFloat margin = (currentWidth - totalWidth) / 2.0;

    // calculates the new frames
    leftLabelFrame.origin.x = margin;
    leftLabelFrame.origin.y = HM_WEEK_WIDGET_PANEL_VIEW_STATUS_LABEL_Y;
    centerLabelFrame.origin.x = margin + leftLabelWidth + HM_WEEK_WIDGET_PANEL_VIEW_STATUS_LABEL_SPACING;
    centerLabelFrame.origin.y = HM_WEEK_WIDGET_PANEL_VIEW_STATUS_LABEL_Y;
    rightLabelFrame.origin.x = margin + leftLabelWidth + centerLabelWidth + 2 * HM_WEEK_WIDGET_PANEL_VIEW_STATUS_LABEL_SPACING;
    rightLabelFrame.origin.y = HM_WEEK_WIDGET_PANEL_VIEW_STATUS_LABEL_Y;

    // sets the (new) frames in the labels
    self.leftLabel.frame = leftLabelFrame;
    self.centerLabel.frame = centerLabelFrame;
    self.rightLabel.frame = rightLabelFrame;
}

- (void)updateStatus {
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

    // updats the status labels values
    self.leftLabel.text = updatedString;
    self.centerLabel.text = dateString;
    self.rightLabel.text = hourString;

    // does the layout in the status
    [self doLayoutStatus];

    // releases the objects
    [dateFormatter release];
}

- (NSString *)title {
    return _title;
}

- (void)setTitle:(NSString *)title {
    // sets the value
    _title = title;

    // sets the title in the title label
    self.titleLabel.text = title;
}

- (NSString *)subTitle {
    return _title;
}

- (void)setSubTitle:(NSString *)subTitle {
    // sets the value
    _subTitle = subTitle;

    // sets the sub title in the sub title label
    self.subTitleLabel.text = subTitle;
}

- (NSString *)value {
    return _value;
}

- (void)setValue:(NSString *)value {
    // sets the value
    _value = value;

    // sets the value in the value label
    self.valueLabel.text = value;
}

- (UIImage *)image {
    return _image;
}

- (void)setImage:(UIImage *)image {
    // sets the value
    _image = image;

    // sets the image in the image view
    self.imageView.image = image;
}

- (NSArray *)weekItems {
    return _weekItems;
}

- (void)setWeekItems:(NSArray *)weekItems {
    // sets the value
    _weekItems = weekItems;

    // retrieves the week items count
    int weekItemsCount = weekItems.count;

    // iterates over all the items
    for(int index = 0; index < weekItemsCount; index += 2) {
        // retrieves the week item key and value
        NSString *weekItemKey = (NSString *) [weekItems objectAtIndex:index];
        NSString *weekItemValue = (NSString *) [weekItems objectAtIndex:index + 1];

        // retrieves the week item key and value labels
        UILabel *weekItemKeyLabel = (UILabel *) [self.weekItemLabels objectAtIndex:index];
        UILabel *weekItemValueLabel = (UILabel *) [self.weekItemLabels objectAtIndex:index + 1];

        // sets the label values
        weekItemKeyLabel.text = weekItemKey;
        weekItemValueLabel.text = weekItemValue;
    }
}

@end
