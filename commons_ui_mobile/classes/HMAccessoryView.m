// Hive Mobile
// Copyright (C) 2008-2016 Hive Solutions Lda.
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
// __revision__  = $LastChangedRevision$
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008-2016 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "HMAccessoryView.h"

@implementation HMAccessoryView

@synthesize label = _label;
@synthesize text = _text;
@synthesize textFont = _textFont;
@synthesize textColorNormal = _textColorNormal;
@synthesize textColorHighlighted = _textColorHighlighted;
@synthesize textShadowColor = _textShadowColor;
@synthesize imageNormal = _imageNormal;
@synthesize imageHighlighted = _imageHighlighted;
@synthesize margin = _margin;

- (id)init {
    // calls the super
    self = [super init];

    // initializes the structures
    [self initStructures];

    // constructs the structures
    [self constructStructures];

    // returns the self
    return self;
}

- (void)dealloc {
    // releases the label
    [_label release];

    // releases the text
    [_text release];

    // releases the text font
    [_textFont release];

    // releases the normal text color
    [_textColorNormal release];

    // releases the highlighted text color
    [_textColorHighlighted release];

    // releases the text shadow color
    [_textShadowColor release];

    // releases the normal image
    [_imageNormal release];

    // releases the highlighted image
    [_imageHighlighted release];

    // releases the margin
    [_margin release];

    // calls the super
    [super dealloc];
}

- (void)initStructures {
    // sets the default attributes
    self.opaque = NO;
    self.backgroundColor = [UIColor clearColor];
}

- (void)constructStructures {
    // creates the label
    HMLabel *label = [[HMLabel alloc] initWithFrame:self.frame];
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    label.contentMode = UIViewContentModeCenter;

    // stores the normal text color
    self.textColorNormal = self.label.textColor;

    // adds the label to the accessory view
    [self addSubview:label];

    // sets the label
    self.label = label;

    // releases the objects
    [label release];
}

- (void)setSelected:(BOOL)selected {
    // toggles the image's state
    self.image = selected && self.imageHighlighted ? self.imageHighlighted : self.imageNormal;

    // in case the accessory is not selected
    // and a normal text color is defined
    if(self.textColorNormal && !selected) {
        // sets the normal text color as the label's text color
        self.label.textColor = self.textColorNormal;
    }

    // in case the accessory is selected
    // and an highlighted text color is defined
    if(self.textColorHighlighted && selected) {
        // sets the highlighted text color as the label's text color
        self.label.textColor = self.textColorHighlighted;
    }

    // toggles the label's shadows
    self.label.shadowColor = selected ? nil : self.textShadowColor;
}

- (void)setHighlighted:(BOOL)highlighted {
    // toggles the image's state
    self.image = highlighted && self.imageHighlighted ? self.imageHighlighted : self.imageNormal;

    // in case the accessory is not highlighted
    // and a normal text color is defined
    if(self.textColorNormal && !highlighted) {
        // sets the normal text color as the label's text color
        self.label.textColor = self.textColorNormal;
    }

    // in case the accessory is highlighted
    // and an highlighted text color is defined
    if(self.textColorHighlighted && highlighted) {
        // sets the highlighted text color as the label's text color
        self.label.textColor = self.textColorHighlighted;
    }

    // toggles the label's shadows
    self.label.shadowColor = highlighted ? nil : self.textShadowColor;
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

    // sets the label's text
    self.label.text = text;
}

- (UIFont *)textFont {
    return _textFont;
}

- (void)setTextFont:(UIFont *)textFont {
    // in case the object is the same
    if(textFont == _textFont) {
        // returns immediately
        return;
    }

    // releases the object
    [_textFont release];

    // sets and retains the object
    _textFont = [textFont retain];

    // sets the label's text
    self.label.font = textFont;
}

- (UIColor *)textColorNormal {
    return _textColorNormal;
}

- (void)setTextColorNormal:(UIColor *)textColorNormal {
    // in case the object is the same
    if(textColorNormal == _textColorNormal) {
        // returns immediately
        return;
    }

    // releases the object
    [_textColorNormal release];

    // sets and retains the object
    _textColorNormal = [textColorNormal retain];

    // sets the label's text
    self.label.textColor = textColorNormal;
}

- (UIColor *)textShadowColor {
    return _textShadowColor;
}

- (void)setTextShadowColor:(UIColor *)textShadowColor {
    // in case the object is the same
    if(textShadowColor == _textShadowColor) {
        // returns immediately
        return;
    }

    // releases the object
    [_textShadowColor release];

    // sets and retains the object
    _textShadowColor = [textShadowColor retain];

    // sets the shadow color in the label
    self.label.shadowColor = textShadowColor;
    self.label.shadowOffset = CGSizeMake(1, 1);
}

- (UIImage *)imageNormal {
    return _imageNormal;
}

- (void)setImageNormal:(UIImage *)imageNormal {
    // in case the object is the same
    if(imageNormal == _imageNormal) {
        // returns immediately
        return;
    }

    // releases the object
    [_imageNormal release];

    // sets and retains the object
    _imageNormal = [imageNormal retain];

    // sets the normal image as the view's image
    self.image = imageNormal;
}

- (void)setFrame:(CGRect)frame {
    // calls the super
    [super setFrame:frame];

    // updates the label's frame
    self.label.frame = frame;
}

@end
