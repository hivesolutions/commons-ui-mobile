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

#import "HMColumnConstantStringTableViewCell.h"

@implementation HMColumnConstantStringTableViewCell

@synthesize label = _label;

- (void)dealloc {
    // releases the label
    [_label release];

    // calls the super
    [super dealloc];
}

- (void)createEditing {
    // calls the super
    [super createEditing];

    // creates the text field and adds it to the edit view
    CGRect editViewFrame = self.editView.frame;
    CGRect labelFrame = CGRectMake(HM_COLUMN_CONSTANT_STRING_TABLE_VIEW_CELL_X_MARGIN, round(editViewFrame.size.height / 2 - HM_COLUMN_CONSTANT_STRING_TABLE_VIEW_CELL_HEIGHT / 2), editViewFrame.size.width - HM_COLUMN_CONSTANT_STRING_TABLE_VIEW_CELL_X_MARGIN * 2, HM_COLUMN_CONSTANT_STRING_TABLE_VIEW_CELL_HEIGHT);
    UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.font = self.descriptionLabel.font;
    label.backgroundColor = [UIColor clearColor];
    label.text = self.description;
    label.textColor = self.descriptionLabel.textColor;

    // adds the textfield as subview
    [self.editView addSubview:label];

    // sets the attributes
    self.label = label;

    // releases the objects
    [label release];
}

- (void)showEditing {
    // calls the super
    [super showEditing];

    // shows the text field
    self.label.hidden = NO;
}

- (void)hideEditing {
    // hides the text field
    self.label.hidden = YES;

    // calls the super
    [super hideEditing];
}

- (void)persistEditing {
    // calls the super
    [super persistEditing];

    // sets the description from the text field
    self.description = self.label.text;
}

- (void)rollbackEditing {
    // reverts the text view text field
    self.label.text = self.description;

    // calls the super
    [super rollbackEditing];
}

- (NSString *)descriptionTransient {
    return self.label.text;
}

- (void)setDescriptionTransient:(NSString *)descriptionTransient {
    // sets the transient description in the text field
    self.label.text = descriptionTransient;
}

@end
