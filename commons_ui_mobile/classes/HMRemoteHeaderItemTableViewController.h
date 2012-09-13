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

#import "HMHeaderItemTableView.h"
#import "HMRemoteItemTableViewController.h"

/**
 * The default image quality to be used.
 */
#define HM_REMOTE_HEADER_ITEM_TABLE_VIEW_CONTROLLER_IMAGE_QUALITY 90.0

/**
 * Provides the behavior for remote header item table views.
 */
@interface HMRemoteHeaderItemTableViewController : HMRemoteItemTableViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
    @private
    UIPopoverController *_imagePickerPopover;
}

/**
 * The image picker popover controller.
 */
@property (retain) UIPopoverController *imagePickerPopover;

/**
 * Called when a new picture was taken.
 *
 * @param picture The new picture.
 */
- (void)didTakePicture:(UIImage *)picture;

/**
 * Presents the image picker.
 */
- (void)presentImagePicker;

/**
 * Dismisses the image picker.
 */
- (void)dismissImagePicker;

@end
