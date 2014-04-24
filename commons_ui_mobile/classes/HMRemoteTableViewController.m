// Hive Mobile
// Copyright (C) 2008-2014 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2014 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "HMRemoteTableViewController.h"

@implementation HMRemoteTableViewController

@synthesize entityAbstraction = _entityAbstraction;
@synthesize entityProviderDelegate = _entityProviderDelegate;
@synthesize createEntityHidden = _createEntityHidden;
@synthesize searchBarHidden = _searchBarHidden;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    // calls the super
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    // initializes the structures
    [self initStructures];

    // returns self
    return self;
}

- (void)dealloc {
    // releases the entity abstraction
    [_entityAbstraction release];

    // calls the super
    [super dealloc];
}

- (void)initStructures {
    // sets the attributes
    self.title = [self getTitle];

    // initializes the create entity (button)
    [self initCreateEntity];

    // initializes the search bar
    [self initSearchBar];

    // creates the entity abstraction
    HMEntityAbstraction *entityAbstraction = [[HMEntityAbstraction alloc] init];

    // sets the attributes
    self.entityAbstraction = entityAbstraction;

    // releases the objects
    [entityAbstraction release];
}

- (void)initCreateEntity {
    // sets the new bar button in the navigation item
    UIBarButtonItem *newBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showNewEntityViewController)];
    [self.navigationItem setRightBarButtonItem:newBarButton animated:YES];

    // sets the new bar button enabled
    newBarButton.enabled = !self.createEntityHidden;

    // releases the objects
    [newBarButton release];
}

- (void)initSearchBar {
    // in case the create entity hidden flag
    // is not set (no need to unsets the search bar)
    if(!self.searchBarHidden) {
        // returns immediately
        return;
    }

    // casts the table view as remote table view (safe)
    HMRemoteTableView *remoteTableView = (HMRemoteTableView *) self.tableView;

    // unsets the table header view
    remoteTableView.tableHeaderView = nil;

    // unsets the search bar
    remoteTableView.searchBar = nil;
}

- (NSString *)getTitle {
    return nil;
}

- (NSString *)getNewEntityTitle {
    return nil;
}

- (UIColor *)getHeaderColor {
    return [UIColor redColor];
}

- (id)getViewController {
    return nil;
}

- (id)getNewEntityViewController {
    return nil;
}

- (void)showNewEntityViewController {
    // retrieves the new entity view controller
    UIViewController<HMEntityProvider> *newEntityViewController = [self getNewEntityViewController];
    newEntityViewController.entityProviderDelegate = self;

    // sets the title in the new entity view controller
    newEntityViewController.title = [self getNewEntityTitle];

    // creates the navigation controller
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newEntityViewController];

    // sets the navigation navigation bar tint color
    navigationController.navigationBar.tintColor = [self getHeaderColor];

    // presents the user view controller into the navigation controller
    [self presentModalViewController:navigationController animated:YES];

    // releases the navigation controller reference
    [navigationController release];
}

- (void)updateEntityProviderDelegate:(NSDictionary *)entity entityName:(NSString *)entityName entityKey:(NSString *)entityKey {
    // updates the entity in the entity provider delegate
    [self.entityProviderDelegate updateEntity:entity entityName:entityName entityKey:entityKey];

    // pops the view controller
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString *)getRemoteUrl {
    return nil;
}

- (HMRemoteTableViewSerialized)getRemoteType {
    return HMRemoteTableViewNoneSerialized;
}

- (NSString *)getItemName {
    return nil;
}

- (NSString *)getItemTitleName {
    return nil;
}

- (void)didSelectRemoteRowWithData:(NSDictionary *)data {
    // in case the entity provider delegate
    // is set this is a provider call
    if(self.entityProviderDelegate) {
        // retrieves the item name
        NSString *itemName = [self getItemName];

        // retrieves the item title name
        NSString *itemTitleName = [self getItemTitleName];

        // updates the entity provider delegate
        [self updateEntityProviderDelegate:data entityName:itemName entityKey:itemTitleName];
    }
    // otherwise it's a normal selection
    else {
        // retrieves the view controller
        UIViewController<HMEntityDelegate> *viewController = [self getViewController];

        // sets (and changes) the entity in the view controller
        [viewController changeEntity:data];

        // pushes the view controller into the navigation controller
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)didDeselectRemoteRowWithData:(NSDictionary *)data {
}

- (void)updateEntity:(NSDictionary *)entity entityName:(NSString *)entityName entityKey:(NSString *)entityKey {
    // in case the entity provider
    // delegate is set
    if(self.entityProviderDelegate) {
        // updates the entity provider delegate
        [self updateEntityProviderDelegate:entity entityName:entityName entityKey:entityKey];
    }
}

@end
