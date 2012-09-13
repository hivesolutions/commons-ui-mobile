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
// __date__      = $LastChangedDate: 2009-04-02 08:36:50 +0100 (qui, 02 Abr 2009) $
// __copyright__ = Copyright (c) 2008-2012 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "HMPlainEditTableViewCell.h"

@implementation HMPlainEditTableViewCell

- (id)initWithReuseIdentifier:(NSString *)cellIdentifier {
    // invokes the parent constructor
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];

    // returns self
    return self;
}

- (void)initStructures {
    // calls the super
    [super initStructures];

    // swaps the labels
    self.nameLabel = self.detailTextLabel;
    self.descriptionLabel = self.textLabel;
}

- (void)createEditing {
    // calls the super
    [super createEditing];

    // initializes the delta
    float delta = 0;

    // adjusts the delta in case the item table view is plain
    if(self.itemTableView.style == UITableViewStylePlain) {
        delta += 24;
    }

    // adjusts the delta in case an icon is present
    if(self.imageView.image) {
        delta += 34;
    }

    // creates the edit view
    CGRect editViewFrame = CGRectMake(delta, 0, self.contentView.frame.size.width - delta, self.contentView.frame.size.height);
    UIView *editView = [[UIView alloc] initWithFrame:editViewFrame];
    editView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    editView.backgroundColor = [UIColor clearColor];

    // adds the edit view to the content view
    [self.contentView addSubview:editView];

    // sets the attributes
    self.editView = editView;

    // releases the objects
    [editView release];
}

- (void)showEditing {
    // hides the text label
    self.descriptionLabel.hidden = YES;

    // calls the super
    [super showEditing];
}

- (void)hideEditing {
    // calls the super
    [super hideEditing];

    // returns in case the edit
    // view is persistent
    if(self.persistentEdit) {
        return;
    }

    // shows the text label
    self.descriptionLabel.hidden = NO;
}

@end
