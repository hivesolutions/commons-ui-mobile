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
    // values with the current ui component ones
    [self.itemDataSource flushItemSpecification];
}

- (UIView *)tableView:(UITableView *)tableView sectionViewForLabelItem:(HMLabelItem *)labelItem {
    // retrieves the size occupied by the font
    UIFont *font = [UIFont fontWithName:labelItem.fontName size:labelItem.fontSize];
    CGSize maximumSize = CGSizeMake(tableView.frame.size.width, NSUIntegerMax);
    CGSize size = [labelItem.description sizeWithFont:font constrainedToSize:maximumSize lineBreakMode:UILineBreakModeWordWrap];

    // creates a label
    CGRect labelFrame = CGRectMake(10, 0, tableView.frame.size.width - 20, size.height);
    UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
    label.text = labelItem.description;
    label.textAlignment = UITextAlignmentCenter;
    label.lineBreakMode = UILineBreakModeWordWrap;
    label.numberOfLines = 0;
    label.font = font;
    label.backgroundColor = [UIColor clearColor];
    label.shadowOffset = CGSizeMake(1, 1);
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    // retrieves the label colors
    HMColor *textColor = labelItem.textColor;
    HMColor *shadowColor = labelItem.shadowColor;

    // sets the label text color
    if(textColor) {
        label.textColor = [UIColor colorWithRed:textColor.red green:textColor.green blue:textColor.blue alpha:textColor.alpha];
    }

    // sets the label shadow color
    if(shadowColor) {
        label.shadowColor = [UIColor colorWithRed:shadowColor.red green:shadowColor.green blue:shadowColor.blue alpha:shadowColor.alpha];
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

    // returns the editing style in case the table is
    // being edited and the table cell item is indentable
    if(self.editing && tableCellItem.indentable) {
        // returns with editing style
        return UITableViewCellEditingStyleDelete;
    }

    // returns no editing style
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

    // releases the index path
    [indexPath release];

    // retrieves the header label item
    HMLabelItem *headerLabelItem = tableSectionItemGroup.header;

    // retrieves the height occupied by the font
    UIFont *font = [UIFont fontWithName:headerLabelItem.fontName size:headerLabelItem.fontSize];
    CGSize maximumSize = CGSizeMake(tableView.frame.size.width, NSUIntegerMax);
    CGSize size = [headerLabelItem.description sizeWithFont:font constrainedToSize:maximumSize lineBreakMode:UILineBreakModeWordWrap];
    CGFloat height = size.height + HM_ITEM_TABLE_VIEW_HEADER_OFFSET;

    // returns the height
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // creates an index path
    NSIndexPath *indexPath = [[NSIndexPath alloc] initWithIndex:section];

    // retrieves the table section item group
    HMTableSectionItemGroup *tableSectionItemGroup = (HMTableSectionItemGroup *) [self.itemDataSource.listItemGroup getItemAtIndexPath:indexPath];

    // releases the index path
    [indexPath release];

    // retrieves the footer label item
    HMLabelItem *footerLabelItem = tableSectionItemGroup.footer;

    // retrieves the height occupied by the font
    UIFont *font = [UIFont fontWithName:footerLabelItem.fontName size:footerLabelItem.fontSize];
    CGSize maximumSize = CGSizeMake(tableView.frame.size.width, NSUIntegerMax);
    CGSize size = [footerLabelItem.description sizeWithFont:font constrainedToSize:maximumSize lineBreakMode:UILineBreakModeWordWrap];
    CGFloat height = size.height + HM_ITEM_TABLE_VIEW_FOOTER_OFFSET;

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

    // calls the did select item row with item method
    [self.itemDelegate didSelectItemRowWithItem:buttonItem];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    // rettrieves the list item group
    HMItemGroup *listItemGroup = self.itemDataSource.listItemGroup;

    // retrieves the button item
    HMButtonItem *buttonItem = (HMButtonItem *) [listItemGroup getItemAtIndexPath:indexPath];

    // calls the did deselect item row with item method
    [self.itemDelegate didDeselectItemRowWithItem:buttonItem];
}

+ (void)_keepAtLinkTime {
}

@end
