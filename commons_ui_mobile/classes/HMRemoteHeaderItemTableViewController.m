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

#import "HMRemoteHeaderItemTableViewController.h"

@implementation HMRemoteHeaderItemTableViewController

- (void)didTakePicture:(UIImage *)picture {
    // creates the item table view and sets the item table
    // view provider and the item delegate
    HMHeaderItemTableView *itemTableView = (HMHeaderItemTableView *) self.tableView;

    // sets the image
    [itemTableView.imageImage setImage:picture];
}

- (void)buttonClicked:(NSString *)buttonName {
    // calls the super
    [super buttonClicked:buttonName];

    // creates a new image picker
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;

    // presents the image picker
    [self presentModalViewController:imagePicker animated:YES];

    // releases the objects
    [imagePicker release];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // dismisses the modal view controller in animated mode
    [self dismissModalViewControllerAnimated:YES];

    // retrieves the selected image
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];

    // calls the did take picture method
    [self didTakePicture:image];
}

+ (void)_keepAtLinkTime {
}

@end
