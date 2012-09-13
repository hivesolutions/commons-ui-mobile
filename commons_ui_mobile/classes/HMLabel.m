// Hive Mobile
// Copyright (C) 2008-2012 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2012 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "HMLabel.h"

@implementation HMLabel

@synthesize edgeInsets = _edgeInsets;

- (id)init {
    // calls the super
    self = [super init];

    // sets the default attributes
    self.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);

    // returns the self
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    // updates the rect with the edge insets
    rect = UIEdgeInsetsInsetRect(rect, self.edgeInsets);

    // draws the text in the rect
    [super drawTextInRect:rect];
}

@end
