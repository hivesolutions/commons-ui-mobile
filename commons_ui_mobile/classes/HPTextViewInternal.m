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

// __author__    = João Magalhães <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision$
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008-2016 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "HPTextViewInternal.h"

@implementation HPTextViewInternal

-(void)setContentOffset:(CGPoint)s {
    // in case the tracking os the decelerating are set
    if(self.tracking || self.decelerating){
        self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    } else {
        // calculates the bottom offset
        float bottomOffset = (self.contentSize.height - self.frame.size.height + self.contentInset.bottom);

        if(s.y < bottomOffset && self.scrollEnabled){
            self.contentInset = UIEdgeInsetsMake(0, 0, 8, 0);
        }
    }

    // sets the content offset
    [super setContentOffset:s];
}

-(void)setContentInset:(UIEdgeInsets)s {
    // copies the insets into a local
    // variable value
    UIEdgeInsets insets = s;

    // in case the bottom insets
    // overflows the maximum value
    if(s.bottom > 8) {
        // sets the default inset
        insets.bottom = 0;
    }

    // forces the top value
    insets.top = -5;

    // sets the content insets
    [super setContentInset:insets];
}

@end
