// Hive Mobile
// Copyright (c) 2008-2017 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2017 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "HMColumnEditTableViewCell.h"

@implementation HMColumnEditTableViewCell

@synthesize nameLabelClickView = _nameLabelClickView;
@synthesize columnSeparatorView = _columnSeparatorView;
@synthesize drawColumnSeparator = _drawColumnSeparator;

- (id)initWithReuseIdentifier:(NSString *)cellIdentifier {
    // invokes the parent constructor
    self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier];

    // returns self
    return self;
}

- (void)dealloc {
    // releases the name label click view
    [_nameLabelClickView release];

    // releases the column separator view
    [_columnSeparatorView release];

    // calls the super
    [super dealloc];
}

- (void)initStructures {
    // calls the super
    [super initStructures];

    // draws the column separator
    self.drawColumnSeparator = YES;
}

- (void)didSelectLabel {
}

- (void)createEditing {
    // calls the super
    [super createEditing];

    // initializes the delta
    float delta = 81;

    // adjusts the delta in case the item table view is plain
    if(self.itemTableView.style == UITableViewStylePlain) {
        delta += 24;
    }

    // creates a label click view
    CGRect nameLabelClickViewFrame = CGRectMake(0, 0, delta, self.contentView.frame.size.height);
    UIView *nameLabelClickView = [[UIView alloc] initWithFrame:nameLabelClickViewFrame];
    nameLabelClickView.backgroundColor = [UIColor clearColor];
    nameLabelClickView.hidden = self.selectableName ? NO : YES;

    // creates a tap gesture recognizer
    // for the label click view
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectLabel)];
    [nameLabelClickView addGestureRecognizer:tapGestureRecognizer];

    // creates the edit view
    CGRect editViewFrame = CGRectMake(delta, 0, self.contentView.frame.size.width - delta, self.contentView.frame.size.height);
    UIView *editView = [[UIView alloc] initWithFrame:editViewFrame];
    editView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    editView.backgroundColor = [UIColor clearColor];

    // creates the column separator view frame
    CGRect columnSeparatorViewFrame = CGRectMake(delta, 0, 1, self.contentView.frame.size.height);
    UIView *columnSeparatorView = [[UIView alloc] initWithFrame:columnSeparatorViewFrame];
    columnSeparatorView.backgroundColor = self.itemTableView.separatorColor;
    columnSeparatorView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    columnSeparatorView.hidden = YES;

    // adds the label click view and the
    // edit view to the content view
    [self.contentView addSubview:nameLabelClickView];
    [self.contentView addSubview:editView];
    [self.contentView addSubview:columnSeparatorView];

    // sets the attributes
    self.nameLabelClickView = nameLabelClickView;
    self.columnSeparatorView = columnSeparatorView;
    self.editView = editView;

    // releases the objects
    [columnSeparatorView release];
    [editView release];
    [tapGestureRecognizer release];
    [nameLabelClickView release];
}

- (void)showEditing {
    // hides the description label
    self.descriptionLabel.hidden = YES;

    // shows/hides the column separator
    self.columnSeparatorView.hidden = self.drawColumnSeparator ? NO : YES;

    // calls the super
    [super showEditing];
}

- (void)hideEditing {
    // calls the super
    [super hideEditing];

    // shows/hides the column separator
    self.columnSeparatorView.hidden = YES;

    // returns in case the edit
    // view is persistent
    if(self.persistentEdit) {
        return;
    }

    // shows the description label
    self.descriptionLabel.hidden = NO;
}

- (void)setSelectableName:(BOOL)selectableName {
    // calls the super
    [super setSelectableName:selectableName];

    // shows/hides the name label click view
    self.nameLabelClickView.hidden = selectableName ? NO : YES;
}

- (void)layoutNameLabel {
    // calls the super
    [super layoutNameLabel];

    // sets the name label to adapt to the size
    self.nameLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)layoutDescriptionLabel {
    // calls the super
    [super layoutDescriptionLabel];

    // retrieves the descripton label's frame
    CGRect descriptionLabelFrame = self.descriptionLabel.frame;

    // in case the name's width changed and no positions were defined
    if(self.nameWidth && !self.namePosition && !self.descriptionPosition) {
        // figures out if the device is an ipad
        UIDevice *currentDevice = [UIDevice currentDevice];
        NSString *currentDeviceModel = currentDevice.model;
        BOOL iPadDevice = [currentDeviceModel hasPrefix:@"iPad"];

        // calculates the delta according to the device
        float delta = iPadDevice ? 90 : 20;

        // offsets the description label to the right of the name label
        CGFloat nameLabelX = self.nameLabel.frame.origin.x;
        CGFloat nameLabelWidth = self.nameLabel.frame.size.width;
        descriptionLabelFrame.origin.x = nameLabelX + nameLabelWidth + 10;

        // updates the edit view frame's width
        CGRect editViewFrame = self.editView.frame;
        editViewFrame.origin.x = descriptionLabelFrame.origin.x;
        editViewFrame.size.width = self.frame.size.width - editViewFrame.origin.x - delta;
        self.editView.frame = editViewFrame;
    }

    // moves the description label origin
    // four pixels to the right to make
    // the label coincide with the edit field
    descriptionLabelFrame.origin.x += 4;

    // sets the updated description label frame
    self.descriptionLabel.frame = descriptionLabelFrame;
}

@end
