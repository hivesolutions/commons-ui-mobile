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

// __author__    = Tiago Silva <tsilva@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision: 2390 $
// __date__      = $LastChangedDate: 2009-04-02 08:36:50 +0100 (qui, 02 Abr 2009) $
// __copyright__ = Copyright (c) 2008 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "Dependencies.h"

#import "HMBadgeLabel.h"
#import "HMTableViewCellBackgroundView.h"

/**
 * The table view cell name font size.
 */
#define HM_TABLE_VIEW_CELL_NAME_FONT_SIZE 13

/**
 * The table view cell description font size.
 */
#define HM_TABLE_VIEW_CELL_DESCRIPTION_FONT_SIZE 15

/**
 * The table view cell height.
 */
#define HM_TABLE_VIEW_CELL_HEIGHT 50

/**
 * The margin between the table view cell's right
 * border and the accessory view.
 */
#define HM_TABLE_VIEW_CELL_ACCESSORY_VIEW_MARGIN_X 11

// avoids circular dependency
@class HMItemTableView;

/**
 * Enumeration defining the various
 * horizontal anchors.
 */
typedef enum  {
    HMTableViewCellHorizontalAnchorNone = 1,
    HMTableViewCellHorizontalAnchorLeft,
    HMTableViewCellHorizontalAnchorRight
} HMTableViewCellHorizontalAnchor;

/**
 * Enumeration defining the various
 * vertical anchors.
 */
typedef enum  {
    HMTableViewCellVerticalAnchorNone = 1,
    HMTableViewCellVerticalAnchorTop,
    HMTableViewCellVerticalAnchorBottom
} HMTableViewCellVerticalAnchor;

@interface HMTableViewCell : UITableViewCell<HMView> {
    @protected
    NSString *_description;

    @private
    UIFont *_descriptionFont;
    UIColor *_descriptionColor;
    NSUInteger _descriptionNumberLines;
    UITextAlignment _descriptionAlignment;
    NSValue *_descriptionPosition;
    HMTableViewCellHorizontalAnchor _descriptionHorizontalAnchor;
    HMTableViewCellVerticalAnchor _descriptionVerticalAnchor;
    NSString *_name;
    UIFont *_nameFont;
    UIColor *_nameColor;
    NSUInteger _nameNumberLines;
    UITextAlignment _nameAlignment;
    NSValue *_namePosition;
    HMTableViewCellHorizontalAnchor _nameHorizontalAnchor;
    HMTableViewCellVerticalAnchor _nameVerticalAnchor;
    UIColor *_borderColor;
    UIColor *_selectedBorderColor;
    NSArray *_backgroundColors;
    NSArray *_selectedBackgroundColors;
    BOOL _selectable;
    BOOL _selectableName;
    float _height;
    BOOL _viewReady;
    BOOL _insertableRow;
    BOOL _deletableRow;
    NSObject *_data;
    NSObject *_dataTransient;
    BOOL _changeEditingStatus;
    Class _readViewController;
    NSString *_readNibName;
    HMItem *_item;
    HMItemTableView *_itemTableView;
}

/**
 * The cell's name that will be set
 * as its label.
 */
@property (retain) NSString *name;

/**
 * The table cell's name font.
 */
@property (retain) UIFont *nameFont;

/**
 * The table cell's name color.
 */
@property (retain) UIColor *nameColor;

/**
 * The table cell's name number of lines.
 */
@property (assign) NSUInteger nameNumberLines;

/**
 * The table cell's name alignment.
 */
@property (assign) UITextAlignment nameAlignment;

/**
 * The table cell's name position.
 */
@property (retain) NSValue *namePosition;

/**
 * The table cell's name horizontal anchor.
 */
@property (assign) HMTableViewCellHorizontalAnchor nameHorizontalAnchor;

/**
 * The table cell's name vertical anchor.
 */
@property (assign) HMTableViewCellVerticalAnchor nameVerticalAnchor;

/**
 * The cell's description that will be set
 * as its detail text label.
 */
@property (retain) NSString *description;

/**
 * The cell's transient description property,
 * used to provide the cell's current description,
 * instead of the one that has last been commited.
 */
@property (assign) NSString *descriptionTransient;

/**
 * The table cell's description font.
 */
@property (retain) UIFont *descriptionFont;

/**
 * The table cell's description color.
 */
@property (retain) UIColor *descriptionColor;

/**
 * The table cell's description number of lines.
 */
@property (assign) NSUInteger descriptionNumberLines;

/**
 * The table cell's description text alignment.
 */
@property (assign) UITextAlignment descriptionAlignment;

/**
 * The table cell's description position,
 * description position.
 */
@property (retain) NSValue *descriptionPosition;

/**
 * The table cell's description horizontal anchor.
 */
@property (assign) HMTableViewCellHorizontalAnchor descriptionHorizontalAnchor;

/**
 * The table cell's description vertical anchor.
 */
@property (assign) HMTableViewCellVerticalAnchor descriptionVerticalAnchor;

/**
 * The table cell's border color.
 */
@property (retain) UIColor *borderColor;

/**
 * The border color of the table
 * cell when it is selected.
 */
@property (retain) UIColor *selectedBorderColor;

/**
 * The table cell's background colors.
 */
@property (retain) NSArray *backgroundColors;

/**
 * The table cell's background colors
 * when it is selected.
 */
@property (retain) NSArray *selectedBackgroundColors;

/**
 * Indicates if the button is
 * selectable in the normal mode.
 */
@property (assign) BOOL selectable;

/**
 * Indicates if the name is selectable.
 */
@property (assign) BOOL selectableName;

/**
 * The table view cell's height.
 */
@property (assign) float height;

/**
 * Flag controlling if the view representing the cell is
 * ready for rendering.
 */
@property (assign) BOOL viewReady;

/**
 * Indicates if the row is insertable.
 */
@property (assign) BOOL insertableRow;

/**
 * Indicates if the row is deletable.
 */
@property (assign) BOOL deletableRow;

/**
 * The data associated with the cell.
 */
@property (retain) NSObject *data;

/**
 * The data associated with the cell
 * in in the state currently described
 * in the cell.
 */
@property (retain) NSObject *dataTransient;

/**
* Flag that controls the change editing status.
 */
@property (assign) BOOL changeEditingStatus;

/**
 * The view controller to use when the
 * item is selected for reading.
 */
@property (assign) Class readViewController;

/**
 * The name of the nib for the view
 * controller that will be used when
 * the item is selected for reading.
 */
@property (retain) NSString *readNibName;

/**
 * The item table view this cell belongs to.
 */
@property (assign) HMItemTableView *itemTableView;

/**
 * Initializes the structures.
 */
- (void)initStructures;

/**
 * Initializes the structures.
 */
- (void)constructStructures;

/**
 * Called when the edinting mode is going to be changed.
 * The commit argument defined if the edit operation should
 * be persisted (commited).
 *
 * @param editing If the editing mode is going to enter.
 * @param commit If the edit should be persisted.
 */
- (void)changeEditing:(BOOL)editing commit:(BOOL)commit;

/**
 * Updates the table data according to the new
 * specification.
 * This method should be used carefully as it wastes
 * a lot of resource in order to update the table
 * contents.
 */
- (void)updateTableData;

/**
 * Updates the labels.
 */
- (void)updateLabels;

/**
 * Updates the name label.
 *
 * @param nameLabel: The label that
 * represents the name.
 */
- (void)updateNameLabel:(UILabel *)nameLabel;

/**
 * Updates the description label.
 *
 * @param descriptionLabel: The label that
 * represents the description.
 */
- (void)updateDescriptionLabel:(UILabel *)descriptionLabel;

/**
 * Updates the accessory view.
 */
- (void)updateAccessoryView;

/**
 * Updates the background view's position.
 */
- (void)updateBackgroundViewPosition;

@end
