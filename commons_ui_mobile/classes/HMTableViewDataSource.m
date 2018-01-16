// Hive Mobile
// Copyright (c) 2008-2018 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2018 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "HMTableViewDataSource.h"

@implementation HMTableViewDataSource

@synthesize tableView = _tableView;
@synthesize cellList = _cellList;
@synthesize cellIdentifierMap = _cellIdentifierMap;

- (id)init {
    // calls the super
    self = [super init];

    // initializes the structures
    [self initStructures];

    // returns self
    return self;
}

- (void)dealloc {
    // releases the cell list
    [_cellList release];

    // releases the cell identifier map
    [_cellIdentifierMap release];

    // calls the supper
    [super dealloc];
}

- (void)initStructures {
    // creates the item cell list to hold all
    // the created cells
    NSMutableArray *cellList = [[NSMutableArray alloc] init];

    // creates the item cell map to hold the relations
    // between the cells and the identifiers
    NSMutableDictionary *cellIdentifierMap = [[NSMutableDictionary alloc] init];

    // sets the attributes
    self.cellList = cellList;
    self.cellIdentifierMap = cellIdentifierMap;

    // releases the objects
    [cellList release];
    [cellIdentifierMap release];
}

- (void)invalidateCells {
    // removes all the object from the cell list
    [self.cellList removeAllObjects];

    // removes all object form the cell identifier map
    [self.cellIdentifierMap removeAllObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

@end
