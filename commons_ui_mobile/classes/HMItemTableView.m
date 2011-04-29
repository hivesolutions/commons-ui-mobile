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

#import "HMItemTableView.h"

@implementation HMItemTableView

@synthesize itemDataSource = _itemDataSource;
@synthesize itemDelegate = _itemDelegate;

- (id)init {
    // calls the super
    self = [super init];

    // returns self
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    // calls the super
    self = [super initWithCoder:aDecoder];

    // returns self
    return self;
}

- (void)dealloc {
    // releases the item data source
    [_itemDataSource release];

    // calls the super
    [super dealloc];
}

- (void)flushItemSpecification {
    // flushes the item specification in the item
    // data source (changing) the item specification
    // values with the current ui component ones,
    // in this case the item data source is not
    // called directly because it would stop
    // the behaviour from the flush item specification
    // implementation of inheriting classes to be avoided
    [self flushItemSpecificationTransient:NO];
}

- (void)flushItemSpecificationTransient:(BOOL)transient {
    // flushes the item specification in the item
    // data source (changing) the item specification
    // values with the current ui component ones
    [self.itemDataSource flushItemSpecificationTransient:transient];
}

- (UIView *)tableView:(UITableView *)tableView sectionViewForLabelItem:(HMLabelItem *)labelItem {
    // retrieves the size occupied by the font
    UIFont *font = [UIFont fontWithName:labelItem.descriptionFont size:labelItem.descriptionFontSize];
    CGSize maximumSize = CGSizeMake(tableView.frame.size.width, NSUIntegerMax);
    CGSize size = [labelItem.description sizeWithFont:font constrainedToSize:maximumSize lineBreakMode:UILineBreakModeWordWrap];

    // retrieves the description color
    HMColor *descriptionColor = labelItem.descriptionColor;

    // creates a label
    CGRect labelFrame = CGRectMake(10, 0, tableView.frame.size.width - 20, size.height);
    UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
    label.text = labelItem.description;
    label.lineBreakMode = UILineBreakModeWordWrap;
    label.numberOfLines = 0;
    label.font = font;
    label.backgroundColor = [UIColor clearColor];
    label.shadowOffset = CGSizeMake(1, 1);
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    label.textColor = [UIColor colorWithRed:descriptionColor.red green:descriptionColor.green blue:descriptionColor.blue alpha:descriptionColor.alpha];

    // sets the label's text alignment
    switch (labelItem.textAlignment) {
        case HMLabelItemTextAlignmentLeft:
            label.textAlignment = UITextAlignmentLeft;
            break;
        case HMLabelItemTextAlignmentCenter:
            label.textAlignment = UITextAlignmentCenter;
            break;
        case HMLabelItemTextAlignmentRight:
            label.textAlignment = UITextAlignmentRight;
            break;
    }

    // sets the label shadow color
    if(labelItem.descriptionShadowColor) {
        HMColor *descriptionShadowColor = labelItem.descriptionShadowColor;
        label.shadowColor = [UIColor colorWithRed:descriptionShadowColor.red green:descriptionShadowColor.green blue:descriptionShadowColor.blue alpha:descriptionShadowColor.alpha];
    }

    // creates a wrapper view
    CGRect wrapperViewFrame = CGRectMake(0, 0, tableView.frame.size.width, size.height);
    UIView *wrapperView = [[[UIView alloc] initWithFrame:wrapperViewFrame] autorelease];
    wrapperView.backgroundColor = [UIColor clearColor];
    wrapperView.autoresizesSubviews = YES;
    [wrapperView addSubview:label];

    // releases the objects
    [label release];

    // returns the wrapper view
    return wrapperView;
}

- (NSObject<HMItemTableViewProvider> *)itemTableViewProvider {
    return _itemTableViewProvider;
}

- (void)setItemTableViewProvider:(NSObject<HMItemTableViewProvider> *)itemTableViewProvider {
    // sets the object
    _itemTableViewProvider = itemTableViewProvider;

    // creates and sets the item table view data source
    // from the item table view provider
    HMItemTableViewDataSource *itemDataSource = [[HMItemTableViewDataSource alloc] initWithItemTableViewProvider:itemTableViewProvider];

    // updates the item specification
    [itemDataSource updateItemSpecification];

    // sets the attributes
    self.itemDataSource = itemDataSource;
    self.dataSource = itemDataSource;

    // sets the current instance as the delegate to the table view
    self.delegate = self;

    // releases the objects
    [itemDataSource release];
}

- (void)reloadData {
    // updates the item specification in forced mode
    [self.itemDataSource updateItemSpecificationForce];

    // calls the super
    [super reloadData];
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    // retrieves the list item group
    HMItemGroup *listItemGroup = self.itemDataSource.listItemGroup;

    // retrieves the table cell item
    HMTableCellItem *tableCellItem = (HMTableCellItem *) [listItemGroup getItemAtIndexPath:indexPath];

    // returns the table cell item's
    // indentable attribute
    return tableCellItem.indentable;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    // retrieves the list item group
    HMItemGroup *listItemGroup = self.itemDataSource.listItemGroup;

    // retrieves the table cell item
    HMTableCellItem *tableCellItem = (HMTableCellItem *) [listItemGroup getItemAtIndexPath:indexPath];

    // returns in case the table view
    // is not in editing mode
    if(!self.editing) {
        return UITableViewCellEditingStyleNone;
    }

    // returns the insert style in
    // case the row is insertable
    if(tableCellItem.insertableRow) {
        return UITableViewCellEditingStyleInsert;
    }

    // returns the delete style in
    // case the row is deletable
    if(tableCellItem.deletableRow) {
        return UITableViewCellEditingStyleDelete;
    }

    // returns the default value
    return UITableViewCellEditingStyleNone;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // retrieves the table cell item
    HMTableCellItem *tableCellItem = (HMTableCellItem *) [self.itemDataSource.listItemGroup getItemAtIndexPath:indexPath];

    // returns the table cell item's height
    return tableCellItem.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    // creates an index path
    NSIndexPath *indexPath = [[NSIndexPath alloc] initWithIndex:section];

    // retrieves the table section item group
    HMTableSectionItemGroup *tableSectionItemGroup = (HMTableSectionItemGroup *) [self.itemDataSource.listItemGroup getItemAtIndexPath:indexPath];

    // retrieves the header label item
    HMLabelItem *headerLabelItem = tableSectionItemGroup.header;

    // retrieves the height occupied by the font
    UIFont *font = [UIFont fontWithName:headerLabelItem.descriptionFont size:headerLabelItem.descriptionFontSize];
    CGSize maximumSize = CGSizeMake(tableView.frame.size.width, NSUIntegerMax);
    CGSize size = [headerLabelItem.description sizeWithFont:font constrainedToSize:maximumSize lineBreakMode:UILineBreakModeWordWrap];
    CGFloat height = size.height + HM_ITEM_TABLE_VIEW_HEADER_OFFSET;

    // releases the objects
    [indexPath release];

    // returns the height
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // creates an index path
    NSIndexPath *indexPath = [[NSIndexPath alloc] initWithIndex:section];

    // retrieves the table section item group
    HMTableSectionItemGroup *tableSectionItemGroup = (HMTableSectionItemGroup *) [self.itemDataSource.listItemGroup getItemAtIndexPath:indexPath];

    // retrieves the footer label item
    HMLabelItem *footerLabelItem = tableSectionItemGroup.footer;

    // retrieves the height occupied by the font
    UIFont *font = [UIFont fontWithName:footerLabelItem.descriptionFont size:footerLabelItem.descriptionFontSize];
    CGSize maximumSize = CGSizeMake(tableView.frame.size.width, NSUIntegerMax);
    CGSize size = [footerLabelItem.description sizeWithFont:font constrainedToSize:maximumSize lineBreakMode:UILineBreakModeWordWrap];
    CGFloat height = size.height + HM_ITEM_TABLE_VIEW_FOOTER_OFFSET;

    // releases the objects
    [indexPath release];

    // returns the height
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // creates an index path
    NSIndexPath *indexPath = [[NSIndexPath alloc] initWithIndex:section];

    // retrieves the table section item group
    HMTableSectionItemGroup *tableSectionItemGroup = (HMTableSectionItemGroup *) [self.itemDataSource.listItemGroup getItemAtIndexPath:indexPath];

    // retrieves the header label item
    HMLabelItem *headerLabelItem = tableSectionItemGroup.header;

    // initializes the section view
    UIView *sectionView = nil;

    // creates the section view, in case
    // the header label item is defined
    if(headerLabelItem) {
        // creates the section view
        sectionView = [self tableView:tableView sectionViewForLabelItem:headerLabelItem];
    }

    // releases the objects
    [indexPath release];

    // returns the section view
    return sectionView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    // creates an index path
    NSIndexPath *indexPath = [[NSIndexPath alloc] initWithIndex:section];

    // retrieves the table section item group
    HMTableSectionItemGroup *tableSectionItemGroup = (HMTableSectionItemGroup *) [self.itemDataSource.listItemGroup getItemAtIndexPath:indexPath];

    // retrieves the footer label item
    HMLabelItem *footerLabelItem = tableSectionItemGroup.footer;

    // initializes the section view
    UIView *sectionView = nil;

    // creates the section view, in case
    // the footer label item is defined
    if(footerLabelItem) {
        // creates the section view
        sectionView = [self tableView:tableView sectionViewForLabelItem:footerLabelItem];
    }

    // releases the objects
    [indexPath release];

    // returns the section view
    return sectionView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // rettrieves the list item group
    HMItemGroup *listItemGroup = self.itemDataSource.listItemGroup;

    // retrieves the button item
    HMButtonItem *buttonItem = (HMButtonItem *) [listItemGroup getItemAtIndexPath:indexPath];

    // retrieves the table view cell
    HMTableViewCell *tableViewCell = (HMTableViewCell *) [self cellForRowAtIndexPath:indexPath];

    // returns in case selection is disabled
    if(tableViewCell.selectionStyle == UITableViewCellSelectionStyleNone) {
        return;
    }

    // in case the table is in editing mode and
    // edit view controller is defined
    if(self.editing && buttonItem.editViewController) {
        // initializes the view controller
        UIViewController<HMEntityProvider> *viewControllerInstance = [[buttonItem.editViewController alloc] initWithNibName:buttonItem.editNibName bundle:[NSBundle mainBundle]];
        viewControllerInstance.entityProviderDelegate = self;

        // pushes the view controller instance
        [self.viewController.navigationController pushViewController:viewControllerInstance animated:YES];

        // releases the view controller reference
        [viewControllerInstance release];
    }
    // in case the table is not in editing mode
    // and a read view controller is defined
    else if(!self.editing && buttonItem.readViewController) {
        // initializes the view controller
        UIViewController<HMEntityDelegate, HMEntityProvider> *viewControllerInstance = [[buttonItem.readViewController alloc] initWithNibName:buttonItem.readNibName bundle:[NSBundle mainBundle]];
        viewControllerInstance.entityProviderDelegate = self;

        // retrieves the entity data
        NSDictionary *entityData = (NSDictionary *) buttonItem.data;

        // changes the entity
        [viewControllerInstance changeEntity:entityData];

        // pushes the view controller instance
        [self.viewController.navigationController pushViewController:viewControllerInstance animated:YES];

        // releases the view controller reference
        [viewControllerInstance release];
    }
    // otherwise the button is normal and the handling
    // should be taken from the item delegate
    else {
        // calls the did select item row with item method
        [self.itemDelegate didSelectItemRowWithItem:buttonItem];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    // rettrieves the list item group
    HMItemGroup *listItemGroup = self.itemDataSource.listItemGroup;

    // retrieves the button item
    HMButtonItem *buttonItem = (HMButtonItem *) [listItemGroup getItemAtIndexPath:indexPath];

    // calls the did deselect item row with item method
    [self.itemDelegate didDeselectItemRowWithItem:buttonItem];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    // calls the super
    [super setEditing:editing animated:animated];

    // checks if the item delegate responds to the set editing changed selector
    BOOL respondsToSelector = [self.itemDelegate respondsToSelector:@selector(setEditingChanged:)];

    // in case the item delegate responds
    // to the set editing changed selector
    if(respondsToSelector) {
        // calls the set editing changed in the item delegate
        [self.itemDelegate setEditingChanged:editing];
    }

    // checks if the root is a mutable parent
    BOOL isMutableParent = self.itemDataSource.listItemGroup.mutableParent;

    // reloads the data to take into account table
    // changes that are related with the edit mode
    if(isMutableParent) {
        // reloads the data
        [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(reloadData) userInfo:nil repeats:NO];
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animate commit:(BOOL)commit {
    // calls the super for set editing
    [super setEditing:editing animated:animate commit:commit];

    // checks if the root is a mutable parent
    BOOL isMutableParent = self.itemDataSource.listItemGroup.mutableParent;

    // in case the list item group
    // is not a mutable parent
    if(!isMutableParent) {
        // returns
        return;
    }

    // in case the table is
    // exiting edit mode
    if(!editing) {
        // in case a commit
        // is being done
        if(commit) {
            // commits the item group
            [self.itemDataSource.listItemGroup commit];
        }
        // in case a rollback
        // is being done
        else {
            // rollsback the item group
            [self.itemDataSource.listItemGroup rollback];
        }
    }

    // reloads the data to take into account table
    // changes that are related with the edit mode
    [self reloadData];
}

- (void)updateEntity:(NSDictionary *)entity entityName:(NSString *)entityName entityKey:(NSString *)entityKey {
    // retrieves the entity value
    NSString *entityValue = [entity objectForKey:entityKey];

    // retrieves the item
    HMItem *item = (HMItem *) [self.itemDataSource.listItemGroup search:entityName];

    // creates an item and adds it to the section in case
    // the item is a table mutable section item group
    if([item isKindOfClass:[HMTableMutableSectionItemGroup class]]) {
        // casts the item to a table mutable section item group
        HMTableMutableSectionItemGroup *tableMutableSectionItemGroup = (HMTableMutableSectionItemGroup *) item;

        // creates the table cell item for the entity
        HMTableCellItem *tableCellItem = [tableMutableSectionItemGroup.tableCellItemCreationDelegate createTableCellItem:entity];

        // adds the table cell item to the table mutable section item group
        [tableMutableSectionItemGroup addItem:tableCellItem];

        // reloads the data
        [self reloadData];
    } else {
        // retrieves the cell identifier map
        NSMutableDictionary *cellIdentifierMap = self.itemDataSource.cellIdentifierMap;

        // retrieves the table cell view for the entity name
        HMTableViewCell *tableViewCell = [cellIdentifierMap objectForKey:entityName];

        // updates the table view cell
        tableViewCell.descriptionTransient = entityValue;
        tableViewCell.dataTransient = entity;
    }
}

@end
