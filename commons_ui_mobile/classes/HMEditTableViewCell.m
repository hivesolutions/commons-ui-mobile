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
@synthesize returnType = _returnType;
@synthesize editableRow = _editableRow;
@synthesize editableCell = _editableCell;
@synthesize clearable = _clearable;
@synthesize editAlways = _editAlways;
@synthesize selectableEdit = _selectableEdit;

- (id)initWithStyle:(UITableViewCellStyle)cellStyle reuseIdentifier:(NSString *)cellIdentifier {
    // invokes the parent constructor
    self = [super initWithStyle:cellStyle reuseIdentifier:cellIdentifier];

    // sets the default attributes
    _editingDirty = YES;
    _editableRow = YES;
    _editableCell = YES;
    _editAlways = NO;

    // returns the instance
    return self;
}

- (void)dealloc {
    // releases the edit view
    [_editView release];

    // releases the return type
    [_returnType release];

    // calls the super
    [super dealloc];
}

- (void)createEditing {
}

- (void)showEditing {
    // hides the contents
    self.accessoryView.hidden = YES;

    // shows the edit view
    self.editView.hidden = NO;
}

- (void)hideEditing {
    // shows the edit view
    self.editView.hidden = YES;

    // hides the contents
    self.accessoryView.hidden = NO;
}

- (void)focusEditing {
    // blurs all the other cells except mine
    [self.itemTableView blurAllExceptCell:self];

    // sets the editing accessory type
    self.editingAccessoryType = UITableViewCellAccessoryNone;
}

- (void)blurEditing {
}

- (void)persistEditing {
}

- (void)rollbackEditing {
}

- (void)flushEditing {
}

- (void)changeEditing:(BOOL)editing commit:(BOOL)commit {
    // returns in case the cell
    // is not editable
    if(!self.editable) {
        // returns immediately (no need to edit)
        return;
    }

    // calls the super
    [super changeEditing:editing commit:commit];

    // persists the editing
    [self flushEditing];

    // returns in case its in edit mode
    if(editing == YES) {
        // shows the editing mode
        [self showEditing];

        // returns immediately (no need
        // to update internal structures)
        return;
    }

    // commits the cell's value in
    // or restores it depending on
    // the commit flag
    if(commit == YES) {
        // persists the editing
        [self persistEditing];
    } else {
        // rollsback the editing
        [self rollbackEditing];
    }

    // hides the editing mode
    [self hideEditing];
}

- (void)didMoveToSuperview {
    // calls the super
    [super didMoveToSuperview];

    // unsets the view ready flag
    self.viewReady = NO;

    // in case the editing is dirty
    if(_editingDirty) {
        // creates the editing (view)
        [self createEditing];

        // in case its meant to always
        // show the edit fields
        if(self.editAlways) {
            // shows the editing
            [self showEditing];
        }
        // otherwise its normal
        // and should be hidden
        else {
            // hides the editing
            [self hideEditing];
        }

        // unsets the editing dirty flag
        _editingDirty = NO;
    }

    // set the view ready flag
    self.viewReady = YES;
}

@end
