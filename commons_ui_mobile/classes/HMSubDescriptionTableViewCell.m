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
// GNU General Public License for more subDescriptions.
//
// You should have received a copy of the GNU General Public License
// along with Hive Mobile. If not, see <http://www.gnu.org/licenses/>.

// __author__    = Tiago Silva <tsilva@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision: 2390 $
// __date__      = $LastChangedDate: 2009-04-02 08:36:50 +0100 (qui, 02 Abr 2009) $
// __copyright__ = Copyright (c) 2008 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "HMSubDescriptionTableViewCell.h"

@implementation HMSubDescriptionTableViewCell

@synthesize subDescriptionLabel = _subDescriptionLabel;
@synthesize subDescriptionFont = _subDescriptionFont;
@synthesize subDescriptionPosition = _subDescriptionPosition;
@synthesize subDescriptionHorizontalAnchor = _subDescriptionHorizontalAnchor;
@synthesize subDescriptionVerticalAnchor = _subDescriptionVerticalAnchor;

- (void)dealloc {
    // releases the sub description label
    [_subDescriptionLabel release];

    // releases the sub description font
    [_subDescriptionFont release];

    // releases the sub description position
    [_subDescriptionPosition release];

    // calls the super
    [super dealloc];
}

- (void)initStructures {
    // calls the super
    [super initStructures];

    // sets the default attributes
    self.subDescriptionHorizontalAnchor = HMTableViewCellHorizontalAnchorNone;
    self.subDescriptionVerticalAnchor = HMTableViewCellVerticalAnchorNone;
}

- (void)constructStructures {
    // calls the super
    [super constructStructures];

    // creates the subDescription label
    CGRect frame = CGRectMake(0, 0, 300, 10);
    UILabel *subDescriptionLabel = [[UILabel alloc] initWithFrame:frame];
    subDescriptionLabel.backgroundColor = [UIColor clearColor];

    // adds the sub description label
    [self.contentView addSubview:subDescriptionLabel];

    // sets the objects
    self.subDescriptionLabel = subDescriptionLabel;

    // releases the objects
    [subDescriptionLabel release];
}

- (void)layoutSubviews {
    // calls the super
    [super layoutSubviews];

    // in case the sub description position is defined
    if(self.subDescriptionPosition) {
        // unpacks the position
        CGPoint subDescriptionPositionPoint = self.subDescriptionPosition.CGPointValue;

        // updates the label's position
        [self updateLabelPosition:self.subDescriptionLabel position:subDescriptionPositionPoint horizontalAnchor:self.subDescriptionHorizontalAnchor verticalAnchor:self.subDescriptionVerticalAnchor];
    }
}

- (UIFont *)subDescriptionFont {
    // returns the sub description font
    return _subDescriptionFont;
}

- (void)setSubDescriptionFont:(UIFont *)subDescriptionFont {
    // in case the object is the same
    if(subDescriptionFont == _subDescriptionFont) {
        // returns immediately
        return;
    }

    // releases the object
    [_subDescriptionFont release];

    // sets and retains the object
    _subDescriptionFont = [subDescriptionFont retain];

    // sets the font in the sub description label
    self.subDescriptionLabel.font = subDescriptionFont;

    // calculates the new text size
    CGSize textSize = [@"1" sizeWithFont:subDescriptionFont];

    // sets the updates text size
    CGRect frame = self.subDescriptionLabel.frame;
    frame.size.height = textSize.height;
    self.subDescriptionLabel.frame = frame;
}

@end
