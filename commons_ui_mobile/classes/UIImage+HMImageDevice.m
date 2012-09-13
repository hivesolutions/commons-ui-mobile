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

#import "UIImage+HMImageDevice.h"

@implementation UIImage (HMImageDevice)

+ (UIImage *)imageNamedDevice:(NSString *)imageName {
    // retrieves the current device model
    UIDevice *currentDevice = [UIDevice currentDevice];
    NSString *currentDeviceModel = [currentDevice model];
    BOOL iPadDevice = [currentDeviceModel hasPrefix:@"iPad"];

    // allocates the suffix value
    NSString *suffixValue;

    // adjusts the delta in case the device is an ipad
    if(iPadDevice) {
        // sets the ipad suffix value
        suffixValue = @"~ipad";
    }
    // otherwise the device is not an ipad
    else {
        // sets the (default) suffix value
        suffixValue = @"";
    }

    // separates the image name on the dots
    NSArray *imageNameComponents = [imageName componentsSeparatedByString:@"."];

    // creates a mutable array from the image name components
    NSMutableArray *imageNameComponentsMutable = [[NSMutableArray alloc] initWithArray:imageNameComponents];

    // retrieves the last index value
    NSUInteger lastIndex = imageNameComponentsMutable.count - 1;

    // retrieves the extension value
    NSString *extension = [imageNameComponentsMutable objectAtIndex:lastIndex];

    // removes the extension from the image name components
    [imageNameComponentsMutable removeObjectAtIndex:lastIndex];

    // retrieves the base image name by joining back the (remaining) components
    NSString *baseImageName = [imageNameComponentsMutable componentsJoinedByString:@"."];

    // creates the complete image name by appending the suffix
    NSString *completeImageName = [NSString stringWithFormat:@"%@%@.%@", baseImageName, suffixValue, extension];

    // loads the image using the complete image name
    UIImage *image = [UIImage imageNamed:completeImageName];

    // releases the objects
    [imageNameComponentsMutable release];

    // returns the image
    return image;
}

@end
