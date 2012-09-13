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
// __revision__  = $LastChangedRevision$
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008-2012 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "HMOptionsButtonView.h"

@implementation HMOptionsButtonView

@synthesize button = _button;
@synthesize label = _label;

- (id)init {
    // calls the super
    self = [super init];

    // initializes the structures
    [self initStructures];

    // returns self
    return self;
}

- (void)dealloc {
    // releases the button
    [_button release];

    // releases the label
    [_label release];

    // releases the icon image
    [_iconImage release];

    // releases the text
    [_text release];

    // calls the super
    [super dealloc];
}

- (void)initStructures {
    // sets the initial frame with the default values
    self.frame = CGRectMake(0, 0, HM_OPTIONS_BUTTON_VIEW_WIDTH, HM_OPTIONS_BUTTON_VIEW_HEIGHT);

    // sets the background color
    self.backgroundColor = [UIColor clearColor];

    // initializes the button with the initial position
    CGRect buttonFrame = CGRectMake(HM_OPTIONS_BUTTON_VIEW_IMAGE_X, HM_OPTIONS_BUTTON_VIEW_IMAGE_Y, HM_OPTIONS_BUTTON_VIEW_IMAGE_WIDTH, HM_OPTIONS_BUTTON_VIEW_IMAGE_HEIGHT);
    UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
    button.backgroundColor = [UIColor clearColor];

    // initializes the label and the value of it
    CGRect labelFrame = CGRectMake(HM_OPTIONS_BUTTON_VIEW_LABEL_X, HM_OPTIONS_BUTTON_VIEW_LABEL_Y, HM_OPTIONS_BUTTON_VIEW_WIDTH, HM_OPTIONS_BUTTON_VIEW_LABEL_HEIGHT);
    UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    label.textColor = [UIColor colorWithRed:0.24 green:0.24 blue:0.24 alpha:1.0];
    label.backgroundColor = [UIColor clearColor];
    label.shadowColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(0, 1);
    label.textAlignment = UITextAlignmentCenter;

    // adds the button as subview of self
    [self addSubview:button];

    // adds the label as subview of self
    [self addSubview:label];

    // sets the attributes
    self.button = button;
    self.label = label;

    // releases the objects
    [label release];
    [button release];
}

- (UIImage *)iconImage {
    return _iconImage;
}

- (void)setIconImage:(UIImage *)iconImage {
    // in case the object is the same
    if(iconImage == _iconImage) {
        // returns immediately
        return;
    }

    // releases the object
    [_iconImage release];

    // sets and retains the object
    _iconImage = [iconImage retain];

    // sets the ui control state normal
    [self.button setImage:iconImage forState:UIControlStateNormal];
}

- (NSString *)text {
    return _text;
}

- (void)setText:(NSString *)text {
    // in case the object is the same
    if(text == _text) {
        // returns immediately
        return;
    }

    // releases the object
    [_text release];

    // sets and retains the object
    _text = [text retain];

    // sets the text in the label
    self.label.text = text;
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    // calls the method in the button
    [self.button addTarget:target action:action forControlEvents:controlEvents];
}

- (void)removeTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    // calls the method in the button
    [self.button removeTarget:target action:action forControlEvents:controlEvents];
}

@end
