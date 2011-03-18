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

#include "HMDatePickerTableViewCell.h"

@implementation HMDatePickerTableViewCell

@synthesize datePicker = _datePicker;
@synthesize dateValue = _dateValue;
@synthesize label = _label;

- (id)initWithReuseIdentifier:(NSString *)cellIdentifier name:(NSString *)name icon:(NSString *)icon highlightedIcon:(NSString *)highlightedIcon highlightable:(BOOL)highlightable accessoryType:(NSString *)accessoryType {
    // invokes the parent constructor
    self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier name:name icon:icon highlightedIcon:highlightedIcon highlightable:highlightable accessoryType:accessoryType];

    // returns self
    return self;
}

- (void)dealloc {
    // releases the date picker
    [_datePicker release];

    // releases the date label
    [_label release];

    // calls the super
    [super dealloc];
}

- (void)slideUpDatePicker {
    // shows the date picker
    self.datePicker.hidden = NO;

    // retrieves the screen rect and the date picker frame
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGRect datePickerFrame = self.datePicker.frame;
    datePickerFrame.origin.y = screenRect.size.height - datePickerFrame.size.height + 20;

    // creates the slide up animation
    [UIView beginAnimations:@"slideUp" context:nil];
    [UIView setAnimationDuration:0.25];

    // updates the date picker's position
    self.datePicker.frame = datePickerFrame;

    // commits the animation
    [UIView commitAnimations];
}

- (void)slideDownDatePicker {
    // resizes the table back to its original size
    self.itemTableView.frame = CGRectMake(0, 0, self.itemTableView.frame.size.width, self.itemTableView.frame.size.height);

    // retrieves the screen rect and the date picker frame
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGRect datePickerFrame = self.datePicker.frame;

    // creates the slide down animation
    [UIView beginAnimations:@"slideDown" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(hideDatePicker)];
    [UIView setAnimationDuration:0.25];

    // updates the date picker's position
    datePickerFrame.origin.y = screenRect.size.height;
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

    // converts the date to a string
    NSString *dateString = [self formatDate:self.dateValue];

    // sets the date string in the detail text label
    self.label.text = dateString;
}

- (NSString *)formatDate:(NSDate *)date {
    // creates the date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];

    // sets the current locale in the date formatter
    NSLocale *currentLocale = [NSLocale currentLocale];
    [dateFormatter setLocale:currentLocale];

    // converts the date to a string
    NSString *dateString = [dateFormatter stringFromDate:date];

    // releases the date formatter
    [dateFormatter release];

    // returns the date string
    return dateString;
}

- (void)createEditing {
    // invokes the super
    [super createEditing];

    // creates the date picker
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    [datePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
    
    // positions the date picker at the bottom of the screen
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGSize pickerSize = [datePicker sizeThatFits:CGSizeZero];
    datePicker.frame = CGRectMake(0.0, screenRect.size.height, pickerSize.width, pickerSize.height);
    datePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;

    // creates the label and adds it to the edit view
    CGRect editViewFrame = self.editView.frame;
    CGRect labelFrame = CGRectMake(HM_DATE_PICKER_TABLE_VIEW_CELL_X_MARGIN, HM_DATE_PICKER_TABLE_VIEW_CELL_Y_MARGIN, editViewFrame.size.width - HM_DATE_PICKER_TABLE_VIEW_CELL_X_MARGIN * 2, HM_DATE_PICKER_TABLE_VIEW_CELL_HEIGHT);
    UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    label.backgroundColor = [UIColor clearColor];

    // adds the date picker to the window
    [self.window addSubview:datePicker];

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
    // returns in case the date
    // picker is already hidden
    if(self.datePicker.hidden) {
        return;
    }

    // converts the date to a string
    NSString *dateString = [self formatDate:self.dateValue];

    // sets the detail text label text
    self.detailTextLabel.text = dateString;

    // slides down the date picker
    [self slideDownDatePicker];

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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    // calls the super
    [super setSelected:selected animated:animated];

    // returns in case the cell is not
    // selected or isn't in editing mode
    if(!self.editing || !selected) {
        return;
    }

    // focuses the editing
    [self focusEditing];

    // disables the highlighting
    [super setSelected:false animated:NO];
}

@end
