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
// __date__      = $LastChangedDate: 2009-04-02 08:36:50 +0100 (qui, 02 2009) $
// __copyright__ = Copyright (c) 2008 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "HMPlainStringTableViewCell.h"

@implementation HMPlainStringTableViewCell

@synthesize textField = _textField;

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
    CGRect textFieldFrame = CGRectMake(HM_PLAIN_STRING_TABLE_VIEW_CELL_X_MARGIN, HM_PLAIN_STRING_TABLE_VIEW_CELL_Y_MARGIN, editViewFrame.size.width - HM_PLAIN_STRING_TABLE_VIEW_CELL_X_MARGIN * 2 + 4, HM_PLAIN_STRING_TABLE_VIEW_CELL_HEIGHT);
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldFrame];
    textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    textField.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.backgroundColor = [UIColor clearColor];
    textField.text = self.stringValue;
    textField.placeholder = self.defaultValue;
    textField.clearsOnBeginEditing = self.secure;
    textField.secureTextEntry = self.secure;
    textField.delegate = self;

    // enables the clear button
    // in case the cell is clearable
    if(self.clearable) {
        textField.clearButtonMode = UITextFieldViewModeAlways;
    }

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

    // shows the text field
    self.textField.hidden = NO;
}

- (void)hideEditing {
    // hides the keyboard
    [self.textField resignFirstResponder];

    // updates the description
    self.description = self.textField.text;

    // hides the text field
    self.textField.hidden = YES;

    // calls the super
    [super hideEditing];
}

- (void)blurEditing {
    // hides the keyboard
    [self.textField resignFirstResponder];

    // updates the description
    self.description = self.textField.text;

    // calls the super
    [super blurEditing];
}

- (NSString *)stringValue {
    return _stringValue;
}

- (void)setStringValue:(NSString *)stringValue {
    // in case the object is the same
    if(stringValue == _stringValue) {
        // returns immediately
        return;
    }

    // releases the object
    [_stringValue release];

    // sets and retains the object
    _stringValue = [stringValue retain];

    // updates the text field text
    self.textField.text = _stringValue;
}

- (BOOL)secure {
    return _secure;
}

- (void)setSecure:(BOOL)secure {
    // in case the object is the same
    if(secure == _secure) {
        // returns immediately
        return;
    }

    // sets the object
    _secure = secure;

    // updates the secure text entry attribute
    self.textField.secureTextEntry = _secure;

    // sets the description
    self.description = self.textField.text;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    // focuses the editing
    [self focusEditing];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    // blurs the editing
    [self blurEditing];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // hides the keyboard
    [self.textField resignFirstResponder];

    // returns yes
    return YES;
}

- (void)setDescription:(NSString *)description {
    // sets the string value
    self.stringValue = description;

    // masks the description if necessary
    if(self.secure == YES && description.length > 0) {
        description = @"••••••••";
    }

    // calls the super
    [super setDescription:description];
}

@end
