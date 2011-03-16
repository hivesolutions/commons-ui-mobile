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

#import "HMEditTableViewCell.h"

@implementation HMEditTableViewCell

@synthesize editView = _editView;

- (id)initWithStyle:(UITableViewCellStyle)cellStyle reuseIdentifier:(NSString *)cellIdentifier name:(NSString *)name icon:(NSString *)icon highlightedIcon:(NSString *)highlightedIcon highlightable:(BOOL)highlightable accessoryType:(NSString *)accessoryType {
    // invokes the parent constructor
    self = [super initWithStyle:cellStyle reuseIdentifier:cellIdentifier name:name icon:icon highlightedIcon:highlightedIcon highlightable:highlightable accessoryType:accessoryType];

    // creates the edit view
    CGRect editViewFrame = CGRectMake(35, 5, self.frame.size.width - 92, self.contentView.frame.size.height - 10);
    UIView *editView = [[UIView alloc] initWithFrame:editViewFrame];
    editView.backgroundColor = [UIColor greenColor];
    editView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;

    // adds the text view to the edit view
    CGRect textViewFrame = CGRectMake(0, 0, editViewFrame.size.width, editViewFrame.size.height);
    UITextView *textView = [[UITextView alloc] initWithFrame:textViewFrame];
    textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin;
    textView.text = @"TEST";
    [editView addSubview:textView];

    // adds the edit view
    [self.contentView addSubview:editView];

    // sets the attributes
    self.editView = editView;

    // releases the objects
    [editView release];

    [self showEditing];

    // returns the instance
    return self;
}

- (void)dealloc {
    // releases the edit view
    [_editView release];

    // calls the super
    [super dealloc];
}

- (void)showEditing {
    // hides the contents
    self.detailTextLabel.hidden = YES;
    self.accessoryView.hidden = YES;

    // shows the edit view
    self.editView.hidden = NO;
}

- (void)hideEditing {
    return;

    // shows the edit view
    self.editView.hidden = YES;

    // hides the contents
    self.detailTextLabel.hidden = NO;
    self.accessoryView.hidden = NO;
}

- (void)setEditing:(BOOL)editing {
    // calls the super
    [super setEditing:editing];

    // in case it's editing
    if(editing) {
        // shows the editing mode
        [self showEditing];
    }
    // otherwise editing is over
    else {
        // hides the editing mode
        [self hideEditing];
    }
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    // calls the super
    [super setEditing:editing animated:animated];

    // in case it's editing
    if(editing) {
        // shows the editing mode
        [self showEditing];
    }
    // otherwise editing is over
    else {
        // hides the editing mode
        [self hideEditing];
    }
}

@end
