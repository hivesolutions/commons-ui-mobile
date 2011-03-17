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

- (void)createEditing {
    // creates the date picker
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.hidden = YES;

    // positions the date picker at the bottom of the screen
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    CGSize pickerSize = [datePicker sizeThatFits:CGSizeZero];
    CGRect pickerRect = CGRectMake(0.0, screenRect.size.height - pickerSize.height - 44, pickerSize.width, pickerSize.height);
    datePicker.frame = pickerRect;
    datePicker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;

    // adds the date picker to the table view's parent
    UITableView *tableView = (UITableView *) self.superview;
    [tableView.superview addSubview:datePicker];

    // sets the attributes
    self.datePicker = datePicker;

    // releases the objects
    [datePicker release];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    // calls the super
    [super setSelected:selected animated:animated];

    // shows the date picker in case the cell was selected
    if(selected) {
        // resizes the table to give space for the date picker
        UITableView *tableView = (UITableView *) self.superview;
        tableView.frame = CGRectMake(0,0, tableView.frame.size.width, tableView.superview.frame.size.height - self.datePicker.frame.size.height);

        // shows the date picker
        self.datePicker.hidden = NO;
    }
}

@end
