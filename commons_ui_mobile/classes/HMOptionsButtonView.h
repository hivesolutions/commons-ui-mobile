// Hive Mobile
// Copyright (c) 2008-2018 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2018 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "Dependencies.h"

/**
 * The options button view width.
 */
#define HM_OPTIONS_BUTTON_VIEW_WIDTH 106

/**
 * The options button view height.
 */
#define HM_OPTIONS_BUTTON_VIEW_HEIGHT 94

/**
 * The options button view image width.
 */
#define HM_OPTIONS_BUTTON_VIEW_IMAGE_WIDTH 50

/**
 * The options button view image height.
 */
#define HM_OPTIONS_BUTTON_VIEW_IMAGE_HEIGHT 50

/**
 * The options button view image x.
 */
#define HM_OPTIONS_BUTTON_VIEW_IMAGE_X 28

/**
 * The options button view image y.
 */
#define HM_OPTIONS_BUTTON_VIEW_IMAGE_Y 12

/**
 * The options button view label height.
 */
#define HM_OPTIONS_BUTTON_VIEW_LABEL_HEIGHT 20

/**
 * The options button view label x.
 */
#define HM_OPTIONS_BUTTON_VIEW_LABEL_X 0

/**
 * The options button view label y.
 */
#define HM_OPTIONS_BUTTON_VIEW_LABEL_Y 68

/**
 * Button component to be used inside the
 * options view, to provide an optimized
 * menu view.
 */
@interface HMOptionsButtonView : UIControl {
    @private
    UIButton *_button;
    UILabel *_label;
    UIImage *_iconImage;
    NSString *_text;
}

/**
 * The button to be used internally for
 * state control.
 */
@property (retain) UIButton *button;

/**
 * The label to be used internally for
 * state control.
 */
@property (retain) UILabel *label;

/**
 * The icon image that represents the
 * options button.
 */
@property (retain) UIImage *iconImage;

/**
 * The text to be presented in the label.
 * This text should represent the button.
 */
@property (retain) NSString *text;

/**
 * Initializes the structures.
 */
- (void)initStructures;

@end
