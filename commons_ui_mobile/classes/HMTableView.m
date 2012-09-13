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

// __author__    = João Magalhçães <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision$
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008-2012 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "HMTableView.h"

@implementation HMTableView

@synthesize viewController = _viewController;
@synthesize dirty = _dirty;

- (id)init {
    // calls the super
    self = [super init];

    // initializes the structures
    [self initStructures];

    // constructs the structures
    [self constructStructures];

    // returns self
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    // calls the super
    self = [super initWithCoder:aDecoder];

    // initializes the structures
    [self initStructures];

    // constructs the structures
    [self constructStructures];

    // returns self
    return self;
}

- (void)initStructures {
    // sets the default attributes
    self.allowsSelectionDuringEditing = YES;
}

- (void)constructStructures {
    // creates the
    UIView *backgroundView = [[UIView alloc] init];

    // sets a background view for compatibility
    // with ipad which doesn't allow customizing
    // table background without setting a background view
    self.backgroundView = backgroundView;

    // releases the background view
    [backgroundView release];
}

- (void)didAppear {
}

- (void)didDisappear {
}

- (void)willAppear {
}

- (void)willDisappear {
}

- (void)setEditing:(BOOL)editing {
    // calls the super
    [super setEditing:editing];

    // creates the block to change the editing
    void (^block)(id) = ^(id value) {
        // casts the value as cell
        HMTableViewCell *cell = value;

        // calls the change editing with argument
        [cell changeEditing:editing commit:YES];
    };

    // casts the data source as table data source
    HMTableViewDataSource *tableDataSource = (HMTableViewDataSource *) self.dataSource;

    // retrieves the cell list
    NSArray *cellList = tableDataSource.cellList;

    // calls the block for the cells
    [HMEnumerableUtil map:cellList block:block copyEnumerable:YES];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animate {
    // calls the super
    [super setEditing:editing animated:animate];

    // creates the block to change the editing
    void (^block)(id) = ^(id value) {
        // casts the value as cell
        HMTableViewCell *cell = value;

        // calls the change editing with argument
        [cell changeEditing:editing commit:YES];
    };

    // casts the data source as table data source
    HMTableViewDataSource *tableDataSource = (HMTableViewDataSource *) self.dataSource;

    // retrieves the cell list
    NSArray *cellList = tableDataSource.cellList;

    // calls the block for the cells
    [HMEnumerableUtil map:cellList block:block copyEnumerable:YES];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animate commit:(BOOL)commit {
    // calls the super for set editing
    [super setEditing:editing animated:animate];

    // creates the block to change the editing
    void (^block)(id) = ^(id value) {
        // casts the value as cell
        HMTableViewCell *cell = value;

        // calls the change editing with argument
        [cell changeEditing:editing commit:commit];
    };

    // casts the data source as table data source
    HMTableViewDataSource *tableDataSource = (HMTableViewDataSource *) self.dataSource;

    // retrieves the cell list
    NSArray *cellList = tableDataSource.cellList;

    // calls the block for the cells
    [HMEnumerableUtil map:cellList block:block copyEnumerable:YES];
}

- (void)blurAllExceptCell:(HMEditTableViewCell *)tableCellView {
    // creates the block to change the editing
    void (^block)(id) = ^(id value) {
        // casts the value as cell
        HMEditTableViewCell *cell = value;

        // checks if the cell responds to the blur selector
        BOOL cellRespondsBlur = [cell respondsToSelector:@selector(blurEditing)];

        // in case the cell is the table cell view and responds
        // to the cell blur method
        if(cell != tableCellView && cellRespondsBlur) {
            // blurs the editing
            [cell blurEditing];
        }
    };

    // casts the data source as table data source
    HMTableViewDataSource *tableDataSource = (HMTableViewDataSource *) self.dataSource;

    // retrieves the cell list
    NSArray *cellList = tableDataSource.cellList;

    // calls the block for the cells
    [HMEnumerableUtil map:cellList block:block copyEnumerable:YES];
}

- (void)invalidateCells {
    // casts the data source as table data source
    HMTableViewDataSource *tableDataSource = (HMTableViewDataSource *) self.dataSource;

    // invalidates the cell in the table data source
    [tableDataSource invalidateCells];
}

- (void)reloadDataInvalidate {
    // invalidates the cells
    [self invalidateCells];

    // reloads the data
    [self reloadData];
}

@end
