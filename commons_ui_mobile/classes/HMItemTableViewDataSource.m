// Hive Mobile
// Copyright (C) 2008-2012 Hive Solutions Lda.
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

// __author__    = João Magalhães <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision$
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008-2012 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "HMItemTableViewDataSource.h"

@implementation HMItemTableViewDataSource

@synthesize itemTableViewProvider = _itemTableViewProvider;
@synthesize itemSpecification = _itemSpecification;

- (id)init {
    // calls the super
    self = [super init];

    // returns self
    return self;
}

- (id)initWithItemTableViewProvider:(NSObject<HMItemTableViewProvider> *)itemTableViewProvider {
    // calls the default contructor
    self = [self init];

    // sets the attributes
    self.itemTableViewProvider = itemTableViewProvider;

    // returns self
    return self;
}

- (void)dealloc {
    // releases the item specification
    [_itemSpecification release];

    // calls the supper
    [super dealloc];
}

- (void)initStructures {
    // calls the super
    [super initStructures];

    // sets the item dirty
    _itemDirty = YES;
}

- (void)flushItemSpecification {
    // flushes the item specification
    [self flushItemGroup:self.listItemGroup transient:NO];
}

- (void)flushItemSpecificationTransient:(BOOL)transient {
    // flushes the item specification
    [self flushItemGroup:self.listItemGroup transient:transient];
}

- (void)flushItemGroup:(HMItemGroup *)itemGroup transient:(BOOL)transient {
    // iterates over the item group,
    // flushing the item group's items
    for(HMItem *item in itemGroup.items) {
        // retrieves the cell for the item
        HMTableViewCell *cell = (HMTableViewCell *) [self.cellIdentifierMap objectForKey:item.identifier];

        // continues in case the cell is
        // transient and the flush is not transient
        if(item.transientState != HMItemStateNone && !transient) {
            continue;
        }

        // flushes the item group in case the
        // object if of that kind
        if([item isKindOfClass:[HMItemGroup class]]) {
            // casts the object
            HMItemGroup *itemGroup = (HMItemGroup *)item;

            // flushes the item group
            [self flushItemGroup:itemGroup transient:transient];
        } else {
            // sets the cell's description and data in the item
            item.description = transient ? cell.descriptionTransient : cell.description;
            item.data = transient ? cell.dataTransient : cell.data;
        }
    }

    // flushes the item group
    [itemGroup flush:transient];
}

- (void)updateItemSpecification {
    // in case the item dirty flag is
    // not set
    if(_itemDirty == NO) {
        // returns immeditely
        return;
    }

    // retrieves the item specification from the item table view provider
    self.itemSpecification = [self.itemTableViewProvider getItemSpecification];

    // unsets the item dirty flag
    _itemDirty = NO;
}

- (void)updateItemSpecificationForce {
    // retrieves the item specification from the item table view provider
    self.itemSpecification = [self.itemTableViewProvider getItemSpecification];

    // unsets the item dirty flag
    _itemDirty = NO;
}

- (HMNamedItemGroup *)headerNamedItemGroup {
    // retrieves the header named item group from the item specification
    HMNamedItemGroup *headerItemGroup = (HMNamedItemGroup *) [self.itemSpecification getItem:@"header"];

    // returns the header item group
    return headerItemGroup;
}

- (HMItemGroup *)listItemGroup {
    // retrieves the list item group from the item specification
    HMItemGroup *listItemGroup = (HMItemGroup *) [self.itemSpecification getItem:@"list"];

    // returns the list item group
    return listItemGroup;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // sets the table view
    self.tableView = tableView;

    // updates the item (if necessary)
    [self updateItemSpecification];

    // retrieves the menu item group items size
    NSInteger menuItemGroupItemsSize = self.listItemGroup.items.count;

    // returns the menu item group items size
    return menuItemGroupItemsSize;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [[[NSArray alloc] init] autorelease];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // retrieves the table cell item
    HMTableCellItem *tableCellItem = (HMTableCellItem *) [self.listItemGroup getItemAtIndexPath:indexPath];

    // retrieves the table view cell for the table cell item identifier
    HMTableViewCell *tableViewCell = [self.cellIdentifierMap objectForKey:tableCellItem.identifier];

    // in case the cell is not defined in the cuurrent cache
    // need to create a new cell
    if(tableViewCell == nil) {
        // prints a debug message
        NSLog(@"Creating UITableViewCell with identifier: %@", tableCellItem.identifier);

        // generates the component
        tableViewCell = (HMTableViewCell *) tableCellItem.component;

        // inserts the item cell into the cell list
        [self.cellList addObject:tableViewCell];

        // inserts the item cell identifier association into the map
        [self.cellIdentifierMap setObject:tableViewCell forKey:tableCellItem.identifier];
    }

    // returns the cell
    return tableViewCell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // in case the editing style is not delete
    if(editingStyle != UITableViewCellEditingStyleDelete) {
        // returns since all further
        // actions are for deletions
        return;
    }

    // retrieves the table cell item and the table view cell
    HMTableCellItem *tableCellItem = (HMTableCellItem *) [self.listItemGroup getItemAtIndexPath:indexPath];
    HMEditTableViewCell *editTableViewCell = (HMEditTableViewCell *) [self tableView:tableView cellForRowAtIndexPath:indexPath];

    // in case the row is not deletable
    if(!tableCellItem.deletableRow) {
        // returns without
        // performing any action
        return;
    }

    // peforms the specified delete action type
    switch(tableCellItem.deleteActionType) {
        // in case the action type is clear
        case HMTableCellItemDeleteActionTypeClear:
            // clears the table view cell's description and data
            editTableViewCell.descriptionTransient = @"";
            editTableViewCell.dataTransient = nil;

            // breaks the switch
            break;

        // in case the action type is delete
        case HMTableCellItemDeleteActionTypeDelete:
            // marks the item as deleted
            tableCellItem.transientState = HMItemStateOld;

            // deletes the row
            NSArray *indexPathArray = [NSArray arrayWithObject:indexPath];
            [tableView beginUpdates];
            [tableView deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
            [tableView endUpdates];

            // breaks the switch
            break;

        // for all other action types
        default:
            // breaks the switch
            break;
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // creates an index path
    NSIndexPath *indexPath = [[NSIndexPath alloc] initWithIndex:section];

    // retrieves the section item group
    HMItemGroup *sectionItemGroup = (HMItemGroup *) [self.listItemGroup getItemAtIndexPath:indexPath];

    // retrieves the section item group items count
    NSInteger sectionItemGroupItemsCount = sectionItemGroup.items.count;

    // figures out if the item group is mutable
    BOOL tableMutableSectionItemGroup = [sectionItemGroup isKindOfClass:[HMTableMutableSectionItemGroup class]];

    // decreases the count in case the table is not in edit mode and
    // the section is mutable, in order to hide the add line button
    if(!self.tableView.editing && tableMutableSectionItemGroup) {
        sectionItemGroupItemsCount--;
    }

    // in case the the table view is in edit mode
    if(self.tableView.editing) {
        // for every item in the section
        for(HMTableCellItem *tableCellItem in sectionItemGroup.items) {
            // in case the item is in an old transient state
            if(tableCellItem.transientState == HMItemStateOld) {
                // takes the item out of the section count
                sectionItemGroupItemsCount--;
            }
        }
    }

    // releases the objects
    [indexPath release];

    // returns the section item group items count
    return sectionItemGroupItemsCount;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return 0;
}

@end
