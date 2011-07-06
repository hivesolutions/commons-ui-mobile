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

@synthesize subDescription = _subDescription;
@synthesize subDescriptionLabel = _subDescriptionLabel;
@synthesize subDescriptionFont = _subDescriptionFont;
@synthesize subDescriptionColor = _subDescriptionColor;
@synthesize subDescriptionWidth = _subDescriptionWidth;
@synthesize subDescriptionTextAlignment = _subDescriptionTextAlignment;
@synthesize subDescriptionShadowColor = _subDescriptionShadowColor;
@synthesize subDescriptionPosition = _subDescriptionPosition;
@synthesize subDescriptionHorizontalAnchor = _subDescriptionHorizontalAnchor;
@synthesize subDescriptionVerticalAnchor = _subDescriptionVerticalAnchor;
@synthesize subDescriptionNumberLines = _subDescriptionNumberLines;

- (void)dealloc {
    // releases the sub description
    [_subDescription release];

    // releases the sub description label
    [_subDescriptionLabel release];

    // releases the sub description font
    [_subDescriptionFont release];

    // releases the sub description color
    [_subDescriptionColor release];

    // releases the sub description shadow color
    [_subDescriptionShadowColor release];

    // releases the sub description position
    [_subDescriptionPosition release];

    // calls the super
    [super dealloc];
}

- (void)initStructures {
    // calls the super
    [super initStructures];

    // sets the default sub description attributes
    self.subDescriptionFont = [UIFont fontWithName:@"Helvetica-Bold" size:HM_SUB_DESCRIPTION_TABLE_VIEW_CELL_SUB_DESCRIPTION_FONT_SIZE];
    self.subDescriptionColor = [UIColor blackColor];
    self.subDescriptionWidth = -1;
    self.subDescriptionTextAlignment = UITextAlignmentLeft;
    self.subDescriptionHorizontalAnchor = HMTableViewCellHorizontalAnchorNone;
    self.subDescriptionVerticalAnchor = HMTableViewCellVerticalAnchorNone;
    self.subDescriptionNumberLines = 1;
}

- (void)constructStructures {
    // calls the super
    [super constructStructures];

    // creates the subDescription label
    CGSize fontSize = [@"1" sizeWithFont:self.subDescriptionFont];
    CGRect frame = CGRectMake(0, 0, 320, fontSize.height);
    UILabel *subDescriptionLabel = [[UILabel alloc] initWithFrame:frame];
    subDescriptionLabel.backgroundColor = [UIColor clearColor];

    // adds the sub description label
    [self.contentView addSubview:subDescriptionLabel];

    // sets the objects
    self.subDescriptionLabel = subDescriptionLabel;

    // releases the objects
    [subDescriptionLabel release];
}

- (void)updateLabels {
    // calls the super
    [super updateLabels];

    // configures the sub description label
    self.subDescriptionLabel.font = self.subDescriptionFont;
    self.subDescriptionLabel.textColor = self.subDescriptionColor;
    self.subDescriptionLabel.textAlignment = self.subDescriptionTextAlignment;
    self.subDescriptionLabel.numberOfLines = self.subDescriptionNumberLines;

    // in case the sub description
    // position is not defined
    if(!self.subDescriptionPosition) {
        // returns
        return;
    }

    // retrieves the sub description label frame
    CGRect subDescriptionLabelFrame = self.subDescriptionLabel.frame;

    // retrieves the label positions
    CGPoint subDescriptionPosition = self.subDescriptionPosition.CGPointValue;

    // updates the sub description label's horizontal positions
    // according to the type of horizontal anchoring
    switch(self.subDescriptionHorizontalAnchor) {
        // in case the labels should anchor to the left
        case HMTableViewCellHorizontalAnchorLeft:
            subDescriptionPosition.x = self.frame.origin.x + subDescriptionPosition.x;
            break;
        // in case the labels should anchor to the top
        case HMTableViewCellHorizontalAnchorRight:
            subDescriptionPosition.x = self.frame.origin.x + self.frame.size.width - subDescriptionPosition.x;
            break;
        // in case no anchoring is defined
        case HMTableViewCellHorizontalAnchorNone:
            break;
    }

    // updates the sub description label's vertical positions
    // according to the type of vertical anchoring
    switch(self.subDescriptionVerticalAnchor) {
        // in case the labels should anchor to the top
        case HMTableViewCellVerticalAnchorTop:
            subDescriptionPosition.y = self.frame.origin.y + subDescriptionPosition.y;
            break;
        // in case the labels should anchor to the bottom
        case HMTableViewCellVerticalAnchorBottom:
            subDescriptionPosition.y = self.frame.origin.y + self.frame.size.height - subDescriptionPosition.y;
            break;
        // in case no anchoring is defined
        case HMTableViewCellVerticalAnchorNone:
            break;
    }

    // updates the label origin
    subDescriptionLabelFrame.origin = subDescriptionPosition;

    // updates the label's width
    subDescriptionLabelFrame.size.width = self.subDescriptionWidth > -1 ? self.subDescriptionWidth : subDescriptionLabelFrame.size.width;

    // sets the updated label frames
    self.subDescriptionLabel.frame = subDescriptionLabelFrame;
}

- (NSString *)subDescription {
    return _subDescription;
}

- (void)setSubDescription:(NSString *)subDescription {
    // in case the description is invalid
    if(subDescription == nil) {
        // returns immediately
        return;
    }

    // in case the object is the same
    if(subDescription == _subDescription) {
        // returns immediately
        return;
    }

    // releases the objects
    [_subDescription release];

    // sets and retains the object
    _subDescription = [subDescription retain];

    // sets the sub description label's text
    self.subDescriptionLabel.text = subDescription;
}

- (NSValue *)subDescriptionPosition {
    return _subDescriptionPosition;
}

- (void)setSubDescriptionPosition:(NSValue *)subDescriptionPosition {
    // in case the object is the same
    if(subDescriptionPosition == _subDescriptionPosition) {
        // returns immediately
        return;
    }

    // releases the object
    [_subDescriptionPosition release];

    // sets and retains the object
    _subDescriptionPosition = [subDescriptionPosition retain];

    // retrieves the sub description position point
    CGPoint subDescriptionPositionPoint = [subDescriptionPosition CGPointValue];

    // sets the sub description label's position
    CGRect frame = self.subDescriptionLabel.frame;
    frame.origin = subDescriptionPositionPoint;
    self.subDescriptionLabel.frame = frame;
}

@end
