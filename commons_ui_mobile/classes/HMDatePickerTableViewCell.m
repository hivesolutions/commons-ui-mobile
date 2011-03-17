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

- (id)initWithReuseIdentifier:(NSString *)cellIdentifier name:(NSString *)name icon:(NSString *)icon highlightedIcon:(NSString *)highlightedIcon highlightable:(BOOL)highlightable accessoryType:(NSString *)accessoryType {
    // invokes the parent constructor
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier name:name icon:icon highlightedIcon:highlightedIcon highlightable:highlightable accessoryType:accessoryType];

    // returns self
    return self;
}

- (void)dealloc {
    // releases the date picker
    [_datePicker release];

    // calls the super
    [super dealloc];
}

- (void)shrinkTable {
    // resizes the table to use the space left by the date picker
    UITableView *tableView = (UITableView *) self.superview;
    tableView.frame = CGRectMake(0, 0, tableView.frame.size.width, tableView.superview.frame.size.height - self.datePicker.frame.size.height);
}

- (void)hideDatePicker {
    // hides the date picker
    self.datePicker.hidden = YES;
}

- (void)dateChanged {
    // stores the date picker's date
    self.dateValue = self.datePicker.date;
}

- (void)createEditing {
    // creates the date picker
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    [datePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];

    // positions the date picker at the bottom of the screen
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGSize pickerSize = [datePicker sizeThatFits:CGSizeZero];
    datePicker.frame =  CGRectMake(0.0, screenRect.size.height, pickerSize.width, pickerSize.height);
    datePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;

    // adds the date picker to the table view's parent
    UITableView *tableView = (UITableView *) self.superview;
    [tableView.superview addSubview:datePicker];

    // sets the attributes
    self.datePicker = datePicker;

    // releases the objects
    [datePicker release];
}

- (void)hideEditing {
    // returns in case the date
    // picker is already hidden
    if(self.datePicker.hidden) {
        return;
    }

    // resizes the table back to its original size
    UITableView *tableView = (UITableView *) self.superview;
    tableView.frame = CGRectMake(0, 0, tableView.superview.frame.size.width, tableView.superview.frame.size.height);

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

    // calls the super
    [super hideEditing];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    // calls the super
    [super setSelected:selected animated:animated];

    // returns in case the cell is not
    // selected or isn't in editing mode
    if(!self.editing || !selected) {
        return;
    }

    // shows the date picker
    self.datePicker.hidden = NO;

    // retrieves the screen rect and the date picker frame
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGRect datePickerFrame = self.datePicker.frame;

    // creates the slide up animation
    [UIView beginAnimations:@"slideUp" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(shrinkTable)];
    [UIView setAnimationDuration:0.75];

    // updates the date picker's position
    datePickerFrame.origin.y = screenRect.size.height - datePickerFrame.size.height - 44;
    self.datePicker.frame = datePickerFrame;

    // commits the animation
    [UIView commitAnimations];
}

@end
