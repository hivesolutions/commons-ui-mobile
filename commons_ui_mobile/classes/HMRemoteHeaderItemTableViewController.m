// Hive Mobile
// Copyright (C) 2008-2015 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2015 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "HMRemoteHeaderItemTableViewController.h"

@implementation HMRemoteHeaderItemTableViewController

@synthesize imagePickerPopover = _imagePickerPopover;

- (void)dealloc {
    // releases the image picker popover
    [_imagePickerPopover release];

    // calls the super
    [super dealloc];
}

- (void)didTakePicture:(UIImage *)picture {
    // creates the item table view and sets the item table
    // view provider and the item delegate
    HMHeaderItemTableView *itemTableView = (HMHeaderItemTableView *) self.tableView;

    // retrieves the picture data
    NSData *pictureData = UIImageJPEGRepresentation(picture, HM_REMOTE_HEADER_ITEM_TABLE_VIEW_CONTROLLER_IMAGE_QUALITY);

    // sets the image in the image (view)
    itemTableView.image.image = picture;

    // sets the image value
    itemTableView.imageValue = pictureData;
}

- (void)presentImagePicker {
    // retrieves the current device model
    UIDevice *currentDevice = [UIDevice currentDevice];
    NSString *currentDeviceModel = [currentDevice model];
    BOOL iPadDevice = [currentDeviceModel hasPrefix:@"iPad"];

    // casts the table view to header item table view
    HMHeaderItemTableView *itemTableView = (HMHeaderItemTableView *) self.tableView;

    // creates a new image picker
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;

    // in case the device is an ipad
    if(iPadDevice) {
        // creates a popover controller for the image picker
        // which is required in the ipad
        UIPopoverController *imagePickerPopover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];

        // presents the popover with the image picker
        [imagePickerPopover presentPopoverFromRect:itemTableView.imageAddButton.frame inView:self.tableView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];

        // sets the image picker popover
        self.imagePickerPopover = imagePickerPopover;

        // releases the image picker popover
        [imagePickerPopover release];
    }
    // in case the device is not an ipad
    else {
        // presents the image picker
        [self presentModalViewController:imagePicker animated:NO];
    }

    // releases the objects
    [imagePicker release];
}

- (void)dismissImagePicker {
    // retrieves the current device model
    UIDevice *currentDevice = [UIDevice currentDevice];
    NSString *currentDeviceModel = [currentDevice model];
    BOOL iPadDevice = [currentDeviceModel hasPrefix:@"iPad"];

    // in case the device is an ipad
    if(iPadDevice) {
        // dismisses the image picker popover in animated mode
        [self.imagePickerPopover dismissPopoverAnimated:YES];
    }
    // in case the device is not an ipad
    else {
        // dismisses the modal view controller in animated mode
        [self dismissModalViewControllerAnimated:YES];
    }
}

- (void)buttonClicked:(NSString *)buttonName {
    // calls the super
    [super buttonClicked:buttonName];

    // casts the table view to header item table view
    HMHeaderItemTableView *itemTableView = (HMHeaderItemTableView *) self.tableView;

    // blurs all the other cells
    [itemTableView blurAllExceptCell:nil];

    // presents the image picker
    [self presentImagePicker];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // retrieves the selected image
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];

    // dismisses the image picker
    [self dismissImagePicker];

    // calls the did take picture method
    [self didTakePicture:image];
}

@end
