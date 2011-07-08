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

#import "HMPlainDateTableViewCell.h"

@implementation HMPlainDateTableViewCell

@synthesize datePicker = _datePicker;
@synthesize dateValue = _dateValue;
@synthesize label = _label;
@synthesize dateFormatter = _dateFormatter;

- (id)initWithReuseIdentifier:(NSString *)cellIdentifier {
    // invokes the parent constructor
    self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier];

    // creates the date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setLocale:[NSLocale currentLocale]];

    // sets the attributes
    self.dateFormatter = dateFormatter;

    // releases the objects
    [dateFormatter release];

    self.descriptionLabel.text = @"3/14/11 5:32 PM";

    // returns self
    return self;
}

- (void)dealloc {
    // releases the date picker
    [_datePicker release];

    // releases the date label
    [_label release];

    // releases the date formatter
    [_dateFormatter release];

    // calls the super
    [super dealloc];
}

- (void)slideUpDatePicker {
    // creates a date picker frame with the updated position
    CGRect screenRect = [self getAdjustedDimensionsScreenRect];
    CGRect datePickerFrame = self.datePicker.frame;
    datePickerFrame.origin.y = screenRect.size.height - datePickerFrame.size.height + 20;

    // shows the date picker
    self.datePicker.hidden = NO;

    // updates the item table view's scrolling area
    self.itemTableView.contentInset = UIEdgeInsetsMake(0, 0, datePickerFrame.size.height, 0);
    self.itemTableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, datePickerFrame.size.height, 0);

    // creates the slide up animation
    [UIView beginAnimations:@"slideUp" context:nil];
    [UIView setAnimationDuration:0.3];

    // updates the date picker's position
    self.datePicker.frame = datePickerFrame;

    // commits the animation
    [UIView commitAnimations];
}

- (void)slideDownDatePicker {
    // creates a date picker frame with the updated position
    CGRect screenRect = [self getAdjustedDimensionsScreenRect];
    CGRect datePickerFrame = self.datePicker.frame;
    datePickerFrame.origin.y = screenRect.size.height;

    // updates the item table view's scrolling area
    self.itemTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.itemTableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);

    // creates the slide down animation
    [UIView beginAnimations:@"slideDown" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(hideDatePicker)];
    [UIView setAnimationDuration:0.3];

    // updates the date picker's position
    self.datePicker.frame = datePickerFrame;

    // commits the animation
    [UIView commitAnimations];
}

- (void)hideDatePicker {
    // hides the date picker
    self.datePicker.hidden = YES;
}

- (void)dateChanged {
    // stores the date picker's date
    self.dateValue = self.datePicker.date;
}

- (CGRect)getAdjustedDimensionsScreenRect {
    // retrieves the device
    UIDevice *device = [UIDevice currentDevice];

    // retrieves the screen rect
    UIScreen *screen = [UIScreen mainScreen];
    CGRect screenRect = screen.applicationFrame;

    // swaps the device's dimensions in case
    // the device is in landscape mode
    if(device.orientation == UIDeviceOrientationLandscapeLeft || device.orientation == UIDeviceOrientationLandscapeRight) {
        CGFloat width = screenRect.size.width;
        screenRect.size.width = screenRect.size.height;
        screenRect.size.height = width;
    }

    // returns the screen rect
    return screenRect;
}

- (void)createEditing {
    // invokes the super
    [super createEditing];

    // creates the date picker
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    [datePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];

    // positions the date picker at the bottom of the screen
    CGRect screenRect = [self getAdjustedDimensionsScreenRect];
    CGSize pickerSize = [datePicker sizeThatFits:CGSizeZero];
    datePicker.frame = CGRectMake(0.0, screenRect.size.height, pickerSize.width, pickerSize.height);
    datePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;

    // creates the label and adds it to the edit view
    CGRect editViewFrame = self.editView.frame;
    CGRect labelFrame = CGRectMake(HM_DATE_TABLE_VIEW_CELL_X_MARGIN, HM_DATE_TABLE_VIEW_CELL_Y_MARGIN, editViewFrame.size.width - HM_DATE_TABLE_VIEW_CELL_X_MARGIN * 2, HM_DATE_TABLE_VIEW_CELL_HEIGHT);
    UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.font = self.descriptionLabel.font;
    label.backgroundColor = [UIColor clearColor];

    // converts the date string to a
    // date and stores it in the date value
    self.dateValue = [self.dateFormatter dateFromString:self.descriptionLabel.text];

    // adds the date picker to the window
    [[self.window.subviews objectAtIndex:0] addSubview:datePicker];

    // adds the label as subview
    [self.editView addSubview:label];

    // sets the attributes
    self.datePicker = datePicker;
    self.label = label;

    // releases the objects
    [datePicker release];
    [label release];
}

- (void)hideEditing {
    // slides down the date picker
    if(self.datePicker.hidden == YES) {
        [self slideDownDatePicker];
    }

    // calls the super
    [super hideEditing];
}

- (void)focusEditing {
    // calls the super
    [super focusEditing];

    // slides up the date picker
    [self slideUpDatePicker];
}

- (void)blurEditing {
    // slides down the date picker
    [self slideDownDatePicker];

    // calls the super
    [super blurEditing];
}

- (void)persistEditing {
    // calls the super
    [super persistEditing];

    // converts the date to a string and stores it in the detail text label
    self.descriptionLabel.text = [self.dateFormatter stringFromDate:self.dateValue];
}

- (void)rollbackEditing {
    // converts the date string to a date and stores it in the date value
    self.dateValue = [self.dateFormatter dateFromString:self.descriptionLabel.text];

    // calls the super
    [super rollbackEditing];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    // calls the super
    [super setSelected:selected animated:animated];

    // returns in case the cell is not
    // selected or isn't in editing mode
    if(self.editing == NO || selected == NO) {
        return;
    }

    // focuses the editing
    [self focusEditing];

    // disables the highlighting
    [super setSelected:false animated:NO];
}

- (NSDate *)dateValue {
    return _dateValue;
}

- (void)setDateValue:(NSDate *)dateValue {
    // in case the object is the same
    if(dateValue == _dateValue) {
        // returns immediately
        return;
    }

    // releases the object
    [_dateValue release];

    // sets and retains the object
    _dateValue = [dateValue retain];

    // converts the date to a string
    NSString *dateString = [self.dateFormatter stringFromDate:dateValue];

    // sets the date string in the detail text label
    self.label.text = dateString;
}

- (NSString *)descriptionTransient {
    return self.label.text;
}

- (void)setDescriptionTransient:(NSString *)descriptionTransient {
    self.label.text = descriptionTransient;
}

@end
