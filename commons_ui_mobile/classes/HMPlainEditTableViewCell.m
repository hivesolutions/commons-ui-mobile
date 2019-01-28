// Hive Mobile
// Copyright (c) 2008-2019 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2019 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

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
