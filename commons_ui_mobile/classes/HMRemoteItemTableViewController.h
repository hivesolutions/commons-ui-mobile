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
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "Dependencies.h"

#import "HMItemTableView.h"
#import "HMEntityDelegate.h"
#import "HMEntityProvider.h"
#import "HMRemoteDelegate.h"
#import "HMErrorAbstraction.h"
#import "HMRemoteAbstraction.h"
#import "HMTableViewController.h"
#import "HMItemTableViewDelegate.h"
#import "HMItemTableViewProvider.h"
#import "HMAuthenticationDelegate.h"

@class HMEntityAbstraction;

/**
 * Enumeration defining the various item
 * operations available.
 */
typedef enum {
    HMItemOperationUnset = 1,
    HMItemOperationCreate,
    HMItemOperationRead,
    HMItemOperationUpdate,
    HMItemOperationDelete
} HMItemOperationType;

/**
 * Provides the behavior for remote table views.
 */
@interface HMRemoteItemTableViewController : HMTableViewController<UIActionSheetDelegate, HMItemTableViewProvider, HMItemTableViewDelegate, HMRemoteDelegate, HMEntityDelegate, HMEntityProvider, HMAuthenticationDelegate> {
    @private
    NSDictionary *_entity;
    HMEntityAbstraction *_entityAbstraction;
    HMRemoteAbstraction *_remoteAbstraction;
    NSObject<HMEntityProviderDelegate> *_entityProviderDelegate;
    NSMutableData *_receivedData;
    HMNamedItemGroup *_remoteGroup;
    HMItemOperationType _operationType;
    BOOL _updateRemoteUpdate;
    BOOL _editHidden;
    BOOL _deleteHidden;
    BOOL _refreshHidden;
    BOOL _toolbarHidden;
    BOOL _viewAppear;
    BOOL _viewDisappear;
    BOOL _remoteDataIsSet;
}

/**
 * The entity represented by the view.
 */
@property (retain) NSDictionary *entity;

/**
 * The entity abstraction to be used for operations
 * in the entity.
 */
@property (retain) HMEntityAbstraction *entityAbstraction;

/**
 * The remote abstraction to be used for controlling
 * the remote calls.
 */
@property (retain) HMRemoteAbstraction *remoteAbstraction;

/**
 * The buffer for received data.
 */
@property (retain) NSMutableData *receivedData;

/**
 * The generated remote group.
 */
@property (retain) HMNamedItemGroup *remoteGroup;

/**
 * The property that defined the king of table
 * view to be presented.
 * The ui of the table view is presented according to
 * the type of operation in defined.
 */
@property (assign) HMItemOperationType operationType;

/**
 * If the remote should be updated whenever
 * an update is done.
 */
@property (assign) BOOL updateRemoteUpdate;

/**
 * Controls if the edit support should be
 * hidden or displayed.
 */
@property (assign) BOOL editHidden;

/**
 * Controls if the delete support should be
 * hidden or displayed.
 */
@property (assign) BOOL deleteHidden;

/**
 * Controls if the refresh support should be
 * hidden or displayed.
 */
@property (assign) BOOL refreshHidden;

/**
 * Controls if the toolbar support should be
 * hidden or displayed.
 */
@property (assign) BOOL toolbarHidden;

/**
 * Constructor of the class.
 *
 * @param nibNameOrNil The name of the nib to be used.
 * @param nibBundleOrNil The nib bundle to be used.
 * @param operationType The type of operation.
 * @return The created instance.
 */
- (id)initWithNibNameAndType:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil operationType:(HMItemOperationType)operationType;

/**
 * Initializes the structures.
 */
- (void)initStructures;

/**
 * Initializes the background view.
 */
- (void)initBackgroundView;

/**
 * Retrieves the title.
 *
 * @return The title.
 */
- (NSString *)getTitle;

/**
 * Retrieves the remote url.
 *
 * @return The remote url.
 */
- (NSString *)getRemoteUrl;

/**
 * Retrieves the remote url for the given
 * operation type.
 *
 * @param operationType The opration type to retrieve the remote url.
 * @return The remote url for the given operation type.
 */
- (NSString *)getRemoteUrlForOperation:(HMItemOperationType)operationType;

/**
 * Retrieves the name of the item represented.
 *
 * @return The name of the item represented.
 */
- (NSString *)getItemName;

/**
 * Retrieves the name of tht title attribute
 * to be used to represent the entity.
 *
 * @return The name of tht title attribute
 * to be used to represent the entity.
 */
- (NSString *)getItemTitleName;

/**
 * Constructs the internal data structures.
 */
- (void)constructStructures;

/**
 * Destroys the internal data structures.
 */
- (void)destroyStructures;

/**
 * Constructs the internal data structures (delayed).
 * This delayed constructing allows the display to be
 * constructed only after the initial successful parsing.
 */
- (void)constructStructuresDelayed;

/**
 * Constructs the internal data structures (delayed).
 * This delayed constructing allows the display to be
 * constructed only after the initial successful parsing.
 * This method is called for reshow.
 */
- (void)constructStructuresDelayedReshow;

/**
 * Destroy the internal data structures (delayed).
 */
- (void)destroyStructuresDelayed;

/**
 * Constructs the create operation stuctures.
 */
- (void)constructCreateStructures;

/**
 * Destroys the create operation stuctures.
 */
- (void)destroyCreateStructures;

/**
 * Constructs the read operation stuctures.
 */
- (void)constructReadStructures;

/**
 * Constructs the read operation stuctures (for reshow).
 */
- (void)constructReadStructuresReshow;

/**
 * Destroy the read operation stuctures.
 */
- (void)destroyReadStructures;

/**
 * Processes the empty data hanlding it and constructing
 * the final adapted object item.
 */
- (void)processEmpty;

/**
 * Processes the remote data hanlding it and constructing
 * the final adapted object item.
 * The object item is set in the remote group.
 *
 * @param remoteData The remote data to be processed.
 */
- (void)processRemoteData:(NSDictionary *)remoteData;

/**
 * Converts the remote group to the must up to date
 * information.
 * This method is called before persistence of the data
 * to obtain the most updated values.
 *
 * @param operationType The type of operation type to be
 * used in the convertion, in case it's not defined the current
 * intance operation type is used.
 * @return The converted remote group as remote data.
 */
- (NSMutableArray *)convertRemoteGroup:(HMItemOperationType)operationType;

/**
 * Converts the remote group for the create operation.
 * This operation puts the result into the given
 * remote data array.
 *
 * @param The remote data array to receive the
 * converted results.
 */
- (void)convertRemoteGroupCreate:(NSMutableArray *)remoteData;

/**
 * Converts the remote group for the read operation.
 * This operation puts the result into the given
 * remote data array.
 *
 * @param The remote data array to receive the
 * converted results.
 */
- (void)convertRemoteGroupRead:(NSMutableArray *)remoteData;

/**
 * Converts the remote group for the update operation.
 * This operation puts the result into the given
 * remote data array.
 *
 * @param The remote data array to receive the
 * converted results.
 */
- (void)convertRemoteGroupUpdate:(NSMutableArray *)remoteData;

/**
 * Converts the remote group for the delete operation.
 * This operation puts the result into the given
 * remote data array.
 *
 * @param The remote data array to receive the
 * converted results.
 */
- (void)convertRemoteGroupDelete:(NSMutableArray *)remoteData;

/**
 * Updates the remote data, by performing a remote
 * call to the provider.
 */
- (void)updateRemote;

/**
 * Updates the remote data, by performing a remote
 * call to the provider.
 * This method disallows the animation.
 */
- (void)updateRemoteNoAnimation;

/**
 * Updates the remote data, by performing a remote
 * call to the provider.
 * This melhod allows control of the animation.
 *
 * @param animated If the updating should be animated.
 */
- (void)updateRemote:(BOOL)animated;

/**
 * Cancels the current remote call.
 */
- (void)cancelRemote;

/**
 * Changes the current toolbar state
 * to a new state and changes the internal
 * structures accordingly.
 *
 * @param hidden The new visibility value for
 * the toolbar.
 */
- (void)changeToolbar:(BOOL)hidden;

/**
 * Updates the toolbar status.
 */
- (void)updateToolbar;

/**
 * Shows the bottom toolbar.
 */
- (void)showToolbar;

/**
 * Hides the bottom toolbar.
 */
- (void)hideToolbar;

/**
 * Callback handler called when the edit button is
 * clicked.
 *
 * @param sender The sender object.
 * @param extra The extra parameters values.
 */
- (void)editButtonClicked:(id)sender extra:(id)extra;

/**
 * Callback handler called when the cancel button is
 * clicked.
 *
 * @param sender The sender object.
 * @param extra The extra parameters values.
 */
- (void)cancelButtonClicked:(id)sender extra:(id)extra;

/**
 * Callback handler called when the delete button is
 * clicked.
 *
 * @param sender The sender object.
 * @param extra The extra parameters values.
 */
- (void)deleteButtonClicked:(id)sender extra:(id)extra;

/**
 * Callback handler called when the refresh button is
 * clicked.
 *
 * @param sender The sender object.
 * @param extra The extra parameters values.
 */
- (void)refreshButtonClicked:(id)sender extra:(id)extra;

@end
