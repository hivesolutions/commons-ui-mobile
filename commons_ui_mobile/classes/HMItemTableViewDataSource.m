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

// __author__    = João Magalhães <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision: 2390 $
// __date__      = $LastChangedDate: 2009-04-02 08:36:50 +0100 (qui, 02 Abr 2009) $
// __copyright__ = Copyright (c) 2008 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "HMItemTableViewDataSource.h"

@implementation HMItemTableViewDataSource

@synthesize itemTableViewProvider = _itemTableViewProvider;
@synthesize tableView = _tableView;
@synthesize itemSpecification = _itemSpecification;
@synthesize cellIdentifierMap = _cellIdentifierMap;

- (id)init {
    // calls the super
    self = [super init];

    // initializes the structures
    [self initStructures];

    // returns self
    return self;
}

- (id)initWithItemTableViewProvider:(NSObject<HMItemTableViewProvider> *)itemTableViewProvider {
    // calls the default contructor
    self = [self init];

    // sets the attributes
    self.itemTableViewProvider = itemTableViewProvider;

    // initializes the structures
    [self initStructures];

    // returns self
    return self;
}

- (void)dealloc {
    // releases the item specification
    [_itemSpecification release];

    // releases the cell identifier map
    [_cellIdentifierMap release];

    // calls the supper
    [super dealloc];
}

- (void)initStructures {
    // sets the item dirty
    _itemDirty = YES;

    // creates the item cell map to hold the relations
    // between the cells and the identifiers
    NSMutableDictionary *cellIdentifierMap = [[NSMutableDictionary alloc] init];

    // sets the attributes
    self.cellIdentifierMap = cellIdentifierMap;

    // releases the objects
    [cellIdentifierMap release];
}

- (void)flushItemSpecification {
    // retrieves the list item group
    HMItemGroup *listItemGroup = (HMItemGroup *) [self.listItemGroup getItem:0];

    // retrieves the list item group items
    NSArray *listItemGroupItems = listItemGroup.items;

    // retrieves the list item group items count
    int listItemGroupItemsCount = [listItemGroupItems count];

    // iterates over all the list items in the list item group items
    for(int index = 0; index < listItemGroupItemsCount; index++) {
        // retrieves the list item at the index
        HMTableCellItem *listItem = (HMTableCellItem *) [listItemGroupItems objectAtIndex:index];

        // retrieves the cell for the list item identifier
        HMTableViewCell *cell = (HMTableViewCell *) [_cellIdentifierMap objectForKey:listItem.identifier];

        // sets the adapted values
        listItem.description = cell.description;
    }

    // retrieves the list item group
    listItemGroup = (HMItemGroup *) [self.listItemGroup getItem:1];

    // retrieves the list item group items
    listItemGroupItems = listItemGroup.items;

    // retrieves the list item group items count
    listItemGroupItemsCount = [listItemGroupItems count];

    // iterates over all the list items in the list item group items
    for(int index = 0; index < listItemGroupItemsCount; index++) {
        // retrieves the list item at the index
        HMTableCellItem *listItem = (HMTableCellItem *) [listItemGroupItems objectAtIndex:index];

        // retrieves the cell for the list item identifier
        HMTableViewCell *cell = (HMTableViewCell *) [_cellIdentifierMap objectForKey:listItem.identifier];

        // sets the adapted values
        listItem.description = cell.description;
    }
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
    NSInteger menuItemGroupItemsSize = [self.listItemGroup.items count];

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
    // creates the cell identifier
    static NSString *cellIdentifier = @"Cell";

    // retrieves the button item
    HMTableCellItem *tableCellItem = (HMTableCellItem *) [self.listItemGroup getItemAtIndexPath:indexPath];

    // tries to retrives the cell from cache (reusable)
    HMTableViewCell *cell = (HMTableViewCell *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    // in case the cell is not defined in the cuurrent cache
    // need to create a new cell
    if (cell == nil) {
        // retrieves the object class name
        const char *objectClassName = object_getClassName(tableCellItem);

        // retrieves the object class name string
        NSString *objectClassNameString = [NSString stringWithCString:objectClassName encoding:NSASCIIStringEncoding];

        if([objectClassNameString isEqualToString:@"HMTableCellItem"]) {
            // creates the new cell with the given reuse identifier
            cell = [[[HMTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier] autorelease];

            // sets the cell attributes
            cell.name = tableCellItem.name;
            cell.description = tableCellItem.description;
            cell.icon = tableCellItem.icon;
            cell.highlightedIcon = tableCellItem.highlightedIcon;
            cell.highlightable = tableCellItem.highlightable;
            cell.accessoryTypeString = tableCellItem.accessoryType;
        } else if([objectClassNameString isEqualToString:@"HMStringTableCellItem"]) {
            // casts the table cell item to a string table cell item
            HMStringTableCellItem *stringTableCellItem = (HMStringTableCellItem *) tableCellItem;

            // creates the appropriate string table view cell
            if(stringTableCellItem.name) {
                HMColumnStringTableViewCell *columnStringTableViewCell = [[[HMColumnStringTableViewCell alloc] initWithReuseIdentifier:cellIdentifier] autorelease];
                columnStringTableViewCell.defaultValue = stringTableCellItem.defaultValue;
                columnStringTableViewCell.secure = stringTableCellItem.secure;
                cell = columnStringTableViewCell;
            } else {
                HMPlainStringTableViewCell *plainStringTableViewCell = [[[HMPlainStringTableViewCell alloc] initWithReuseIdentifier:cellIdentifier] autorelease];
                plainStringTableViewCell.defaultValue = stringTableCellItem.defaultValue;
                plainStringTableViewCell.secure = stringTableCellItem.secure;
                cell = plainStringTableViewCell;
            }

            // sets the cell's attributes
            cell.name = stringTableCellItem.name;
            cell.description = stringTableCellItem.description;
            cell.icon = stringTableCellItem.icon;
            cell.highlightedIcon = stringTableCellItem.highlightedIcon;
            cell.highlightable = stringTableCellItem.highlightable;
            cell.accessoryTypeString = stringTableCellItem.accessoryType;
        }
    }

    // inserts the item cell identifier association into the map
    [_cellIdentifierMap setObject:cell forKey:tableCellItem.identifier];

    // sets the button item's attributes in the cell
    cell.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];

    // returns the cell
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // creates an index path
    NSIndexPath *indexPath = [[NSIndexPath alloc] initWithIndex:section];

    // retrieves the section item group
    HMItemGroup *sectionItemGroup = (HMItemGroup *) [self.listItemGroup getItemAtIndexPath:indexPath];

    // retrieves the section item group items count
    NSInteger sectionItemGroupItemsCount = [sectionItemGroup.items count];

    // releases the index path
    [indexPath release];

    // returns the section item group items count
    return sectionItemGroupItemsCount;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    // creates an index path
    NSIndexPath *indexPath = [[NSIndexPath alloc] initWithIndex:section];

    // retrieves the table section item group
    HMTableSectionItemGroup *tableSectionItemGroup = (HMTableSectionItemGroup *) [self.listItemGroup getItemAtIndexPath:indexPath];

    // releases the index path
    [indexPath release];

    // returns the table section item group's footer
    return tableSectionItemGroup.footer;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // creates an index path
    NSIndexPath *indexPath = [[NSIndexPath alloc] initWithIndex:section];

    // retrieves the table section item group
    HMTableSectionItemGroup *tableSectionItemGroup = (HMTableSectionItemGroup *) [self.listItemGroup getItemAtIndexPath:indexPath];

    // releases the index path
    [indexPath release];

    // returns the table section item group's header
    return tableSectionItemGroup.header;
}

+ (void)_keepAtLinkTime {
}

@end
