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

// __author__    = Tiago Silva <tsilva@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision: 2390 $
// __date__      = $LastChangedDate: 2009-04-02 08:36:50 +0100 (qui, 02 Abr 2009) $
// __copyright__ = Copyright (c) 2008 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "HMColumnEditTableViewCell.h"

@implementation HMColumnEditTableViewCell

@synthesize nameLabelClickView = _nameLabelClickView;

- (id)initWithReuseIdentifier:(NSString *)cellIdentifier {
    // invokes the parent constructor
    self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier];

    // returns self
    return self;
}

- (void)dealloc {
    // releases the name label click view
    [_nameLabelClickView release];

    // calls the super
    [super dealloc];
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
    UIView *editView = [[HMEditTableViewCellEditView alloc] initWithFrame:editViewFrame];
    editView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    editView.backgroundColor = [UIColor clearColor];

    // adds the label click view and the
    // edit view to the content view
    [self.contentView addSubview:nameLabelClickView];
    [self.contentView addSubview:editView];

    // sets the attributes
    self.nameLabelClickView = nameLabelClickView;
    self.editView = editView;

    // releases the objects
    [nameLabelClickView release];
    [tapGestureRecognizer release];
    [editView release];
}

- (void)showEditing {
    // hides the detail text label
    self.detailTextLabel.hidden = YES;

    // enables the edit view border
    HMEditTableViewCellEditView *editView = (HMEditTableViewCellEditView *) self.editView;
    editView.drawBorder = YES;
    [editView setNeedsDisplay];

    // calls the super
    [super showEditing];
}

- (void)hideEditing {
    // calls the super
    [super hideEditing];

    // disables the edit view border
    HMEditTableViewCellEditView *editView = (HMEditTableViewCellEditView *) self.editView;
    editView.drawBorder = NO;
    [editView setNeedsDisplay];

    // returns in case the edit
    // view is persistent
    if(self.persistentEdit) {
        return;
    }

    // shows the detail text label
    self.detailTextLabel.hidden = NO;
}

- (void)setSelectableName:(BOOL)selectableName {
    // calls the super
    [super setSelectableName:selectableName];

    // shows/hides the name label click view
    if(selectableName){
        self.nameLabelClickView.hidden = NO;
    }
    else {
        self.nameLabelClickView.hidden = YES;
    }
}

- (void)layoutSubviews {
    // calls the super
    [super layoutSubviews];

    // moves the detail text label origin
    // five pixels to the right
    CGRect frame = self.detailTextLabel.frame;
    frame.origin.x += 4;

    // updates the detail text label's position
    self.detailTextLabel.frame = frame;

    // sets the text label to adjust the
    // font size to the available width
    self.textLabel.adjustsFontSizeToFitWidth = YES;

    // swaps the fonts and colors because the name is
    // represented by the text label and the description
    // by the detail text label in this cell type
    self.textLabel.font = [UIFont fontWithName:self.nameFont size:self.nameFontSize];
    self.textLabel.textColor = self.nameColor;
    self.detailTextLabel.font = [UIFont fontWithName:self.descriptionFont size:self.descriptionFontSize];
    self.detailTextLabel.textColor = self.descriptionColor;
}

@end
