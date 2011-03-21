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

@synthesize defaultValue = _defaultValue;
@synthesize editView = _editView;
@synthesize itemTableView = _itemTableView;

- (id)initWithStyle:(UITableViewCellStyle)cellStyle reuseIdentifier:(NSString *)cellIdentifier {
    // invokes the parent constructor
    self = [super initWithStyle:cellStyle reuseIdentifier:cellIdentifier];

    // sets the editing dirty
    _editingDirty = YES;

    // returns the instance
    return self;
}

- (void)dealloc {
    // releases the edit view
    [_editView release];

    // calls the super
    [super dealloc];
}

- (void)didSelectLabel {
    NSLog(@"LABEL SELECTED");
}

- (void)createEditing {
    // retrieves the associated table view (superview)
    self.itemTableView = (HMItemTableView *) self.superview;

    // starts the delta value
    float delta = 0;

    // switches over the table style
    switch(self.itemTableView.style) {
        // in case it's an ui table view style grouped
        case UITableViewStyleGrouped:
            // sets the delta to grouped
            delta = 81;

            // breaks the switch
            break;

        // in case it's an ui table view style plain
        case UITableViewStylePlain:
            // sets the delta to grouped
            delta = 105;

            // breaks the switch
            break;
    }

    // creates a label click view
    CGRect labelClickViewFrame = CGRectMake(0, 0, delta, self.contentView.frame.size.height);
    UIView *labelClickView = [[UIView alloc] initWithFrame:labelClickViewFrame];
    labelClickView.backgroundColor = [UIColor clearColor];

    // creates a tap gesture recognizer
    // for the label click view
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectLabel)];
    [labelClickView addGestureRecognizer:tapGestureRecognizer];

    // creates the edit view
    CGRect editViewFrame = CGRectMake(delta, 0, self.contentView.frame.size.width - delta, self.contentView.frame.size.height);
    UIView *editView = [[HMEditTableViewCellEditView alloc] initWithFrame:editViewFrame];
    editView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    editView.backgroundColor = [UIColor clearColor];

    // adds the label click view and the
    // edit view to the content view
    [self.contentView addSubview:labelClickView];
    [self.contentView addSubview:editView];

    // sets the attributes
    self.editingAccessoryType = UITableViewCellAccessoryNone;
    self.editView = editView;

    // releases the objects
    [labelClickView release];
    [tapGestureRecognizer release];
    [editView release];
}

- (void)showEditing {
    // hides the contents
    self.detailTextLabel.hidden = YES;
    self.accessoryView.hidden = YES;

    // shows the edit view
    self.editView.hidden = NO;
}

- (void)hideEditing {
    // shows the edit view
    self.editView.hidden = YES;

    // hides the contents
    self.accessoryView.hidden = NO;
    self.detailTextLabel.hidden = NO;
}

- (void)focusEditing {
    // blurs all the other cells except mine
    [self.itemTableView blurAllExceptCell:self];
}

- (void)blurEditing {
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

- (void)didMoveToSuperview {
    // calls the super
    [super didMoveToSuperview];

    // in case the editing is dirty
    if(_editingDirty) {
        // creates the editing (view)
        [self createEditing];

        // hides the editing
        [self hideEditing];

        // unsets the editing dirty flag
        _editingDirty = NO;
    }
}

@end
