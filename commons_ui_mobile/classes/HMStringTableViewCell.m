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

#import "HMStringTableViewCell.h"

@implementation HMStringTableViewCell

@synthesize textField = _textField;
@synthesize stringValue = _stringValue;

- (id)initWithReuseIdentifier:(NSString *)cellIdentifier {
    // invokes the parent constructor
    self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier];

    // returns self
    return self;
}

- (void)dealloc {
    // releases the text field
    [_textField release];

    // releases the string value
    [_stringValue release];

    // calls the super
    [super dealloc];
}

- (void)createEditing {
    // calls the super
    [super createEditing];

    // creates the text field and adds it to the edit view
    CGRect editViewFrame = self.editView.frame;
    CGRect textFieldFrame = CGRectMake(HM_STRING_TABLE_VIEW_CELL_X_MARGIN, HM_STRING_TABLE_VIEW_CELL_Y_MARGIN, editViewFrame.size.width - HM_STRING_TABLE_VIEW_CELL_X_MARGIN * 2, HM_STRING_TABLE_VIEW_CELL_HEIGHT);
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldFrame];
    textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    textField.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    textField.placeholder = @"default value";
    textField.clearButtonMode = UITextFieldViewModeAlways;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;

    // adds the textfield as subview
    [self.editView addSubview:textField];

    // sets the attributes
    self.textField = textField;

    // releases the objects
    [textField release];
}

- (void)showEditing {
    // calls the super
    [super showEditing];

    // updates the string value
    self.stringValue = self.detailTextLabel.text;

    // sets the text field text
    self.textField.text = self.stringValue;

    // hides the text field
    self.textField.hidden = NO;
}

- (void)hideEditing {
    // updates the string value
    self.stringValue = self.textField.text;

    // sets the detail text label text
    self.detailTextLabel.text = self.stringValue;

    // hides the text field
    self.textField.hidden = YES;

    // calls the super
    [super hideEditing];
}

@end
