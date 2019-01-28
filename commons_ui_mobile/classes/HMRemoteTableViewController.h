// Hive Mobile
// Copyright (c) 2008-2019 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2019 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "Dependencies.h"

#import "HMEntityDelegate.h"
#import "HMEntityProvider.h"
#import "HMRemoteTableView.h"
#import "HMEntityAbstraction.h"
#import "HMEntityProviderDelegate.h"
#import "HMRemoteTableViewProvider.h"
#import "HMRemoteTableViewDelegate.h"

/**
 * Provides the behavior for remote table views.
 */
@interface HMRemoteTableViewController : HMTableViewController<HMRemoteTableViewProvider, HMRemoteTableViewDelegate, HMEntityProvider, HMEntityProviderDelegate> {
    @private
    HMEntityAbstraction *_entityAbstraction;
    NSObject<HMEntityProviderDelegate> *_entityProviderDelegate;
    BOOL _createEntityHidden;
    BOOL _searchBarHidden;
}

/**
 * The entity abstraction to be used for operations
 * in the entity.
 */
@property (retain) HMEntityAbstraction *entityAbstraction;

/**
 * Controls the status of the create entity button.
 */
@property (assign) BOOL createEntityHidden;

/**
 * Controls the status of the search bar.
 */
@property (assign) BOOL searchBarHidden;

/**
 * Initializes the structures.
 */
- (void)initStructures;

/**
 * Initializes the create entity button.
 */
- (void)initCreateEntity;

/**
 * Initializes the search bar.
 */
- (void)initSearchBar;

/**
 * Retrieves the title to be used.
 *
 * @return The title to be used.
 */
- (NSString *)getTitle;

/**
 * Retrieves the title to be used in the
 * new entity view.
 *
 * @return The title to be used in the
 * new entity view.
 */
- (NSString *)getNewEntityTitle;

/**
 * Retrieves the color to be used in the
 * header.
 *
 * @return The color to be used in the
 * header.
 */
- (UIColor *)getHeaderColor;

/**
 * Retrieves the view controller to be used
 * when selecting an item.
 *
 * @return The view controller to be used
 * when selecting an item.
 */
- (id)getViewController;

/**
 * Retrieves the view controller to be used
 * to create an item.
 *
 * @return The view controller to be used
 * to create an item.
 */
- (id)getNewEntityViewController;

/**
 * Shows the new entity view controller
 * in the screen.
 */
- (void)showNewEntityViewController;

/**
 * Updates the entity provider delegate with the entity
 * and shows it in the screen.
 *
 * @param entity The entity to be used to update the entity
 * provider delegate.
 * @param entityName The name of the entity to be updated.
 * @param entityKey The key value to the eneoty to be updated.
 */
- (void)updateEntityProviderDelegate:(NSDictionary *)entity entityName:(NSString *)entityName entityKey:(NSString *)entityKey;

@end
