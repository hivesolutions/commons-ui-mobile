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

#import "Dependencies.h"

#import "HMRemoteTableViewProvider.h"
#import "HMRemoteTableViewDelegate.h"
#import "HMEntityProvider.h"
#import "HMEntityProviderDelegate.h"
#import "HMEntityDelegate.h"

@interface HMRemoteTableViewController : HMTableViewController<HMRemoteTableViewProvider, HMRemoteTableViewDelegate, HMEntityProvider, HMEntityProviderDelegate> {
    @private
    HMEntityAbstraction *_entityAbstraction;
    NSObject<HMEntityProviderDelegate> *_entityProviderDelegate;
}

/**
 * The entity abstraction to be used for operations
 * in the entity.
 */
@property (retain) HMEntityAbstraction *entityAbstraction;

/**
 * Initializes the structures.
 */
- (void)initStructures;

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
