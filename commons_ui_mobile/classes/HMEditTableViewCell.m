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

#import "HMEditTableViewCell.h"

@implementation HMEditTableViewCell

@synthesize defaultValue = _defaultValue;
@synthesize editView = _editView;
@synthesize returnType = _returnType;
@synthesize clearable = _clearable;
@synthesize editAlways = _editAlways;
@synthesize selectableEdit = _selectableEdit;
@synthesize persistentEdit = _persistentEdit;
@synthesize focusEdit = _focusEdit;
@synthesize editViewController = _editViewController;
@synthesize editNibName = _editNibName;

- (id)initWithStyle:(UITableViewCellStyle)cellStyle reuseIdentifier:(NSString *)cellIdentifier {
    // invokes the parent constructor
    self = [super initWithStyle:cellStyle reuseIdentifier:cellIdentifier];

    // sets the default attributes
    _editingDirty = YES;
    _persistentEdit = NO;
    _editAlways = NO;

    // returns the instance
    return self;
}

- (void)dealloc {
    // releases the edit view
    [_editView release];

    // releases the return type
    [_returnType release];

    // releases the edit nib name
    [_editNibName release];

    // calls the super
    [super dealloc];
}

- (void)createEditing {
}

- (void)showEditing {
    // shows the edit view
    self.editView.hidden = NO;

    // sets the cell as selectable in case it is entering edit mode
    // and the cell is selectable in edit mode
    self.selectionStyle = self.selectableEdit ? UITableViewCellSelectionStyleBlue : UITableViewCellSelectionStyleNone;
}

- (void)hideEditing {
    // returns in case the edit
    // view is persistent
    if(self.persistentEdit) {
        return;
    }

    // shows the edit view
    self.editView.hidden = YES;

    // checks if the data exists in case a read view controller was defined
    // or if the read view controller is undefined
    BOOL validData = self.readViewController == nil || (self.readViewController != nil && self.data != nil);

    // sets the cell as selectable in case it is exiting edit mode
    // and no read view controller is defined, or is defined along
    // with the respective data
    self.selectionStyle = self.selectable && validData ? UITableViewCellSelectionStyleBlue : UITableViewCellSelectionStyleNone;
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
    // sets the transient data in
    // the data property to persist it
    self.data = self.dataTransient;
}

- (void)rollbackEditing {
}

- (void)flushEditing {
}

- (void)changeEditing:(BOOL)editing commit:(BOOL)commit {
    // in case the "new" editing value is the same
    // as the current change editing status (nothing changes)
    if(editing == self.changeEditingStatus) {
        // returns immediately
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

    // in case the item table view is in editing mode
    BOOL itemTableViewEditing = self.itemTableView.editing;

    // in case the item table view is
    // in editing mode, there's a need to change
    // the editing mode in the cell
    if(itemTableViewEditing) {
        // changes the editing mode
        [self changeEditing:YES commit:YES];
    }

    // set the view ready flag
    self.viewReady = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    // calls the super
    [super setSelected:selected animated:animated];

    // in case it's not selectable
    if((!self.editing && !self.selectable) || (self.editing && !self.selectableEdit)) {
        // returns immediately
        // to avoid bluring all
        return;
    }

    // focuses the editing
    [self focusEditing];
}

@end
