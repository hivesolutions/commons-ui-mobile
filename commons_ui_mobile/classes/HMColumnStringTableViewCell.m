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

#import "HMColumnStringTableViewCell.h"

@implementation HMColumnStringTableViewCell

@synthesize textField = _textField;
@synthesize returnDisablesEdit = _returnDisablesEdit;
@synthesize autocapitalizationType = _autocapitalizationType;

- (void)dealloc {
    // releases the text field
    [_textField release];

    // releases the auto capitalization type
    [_autocapitalizationType release];

    // calls the super
    [super dealloc];
}

- (void)createEditing {
    // calls the super
    [super createEditing];

    // creates the text field and adds it to the edit view
    CGRect editViewFrame = self.editView.frame;
    CGRect textFieldFrame = CGRectMake(HM_COLUMN_STRING_TABLE_VIEW_CELL_X_MARGIN, HM_COLUMN_STRING_TABLE_VIEW_CELL_Y_MARGIN, editViewFrame.size.width - HM_COLUMN_STRING_TABLE_VIEW_CELL_X_MARGIN * 2, HM_COLUMN_STRING_TABLE_VIEW_CELL_HEIGHT);
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldFrame];
    textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    textField.font = self.descriptionFont;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.backgroundColor = [UIColor clearColor];
    textField.text = self.description;
    textField.placeholder = self.defaultValue;
    textField.clearsOnBeginEditing = self.secure;
    textField.secureTextEntry = self.secure;
    textField.delegate = self;

    // sets the text field's auto capitalization type
    if([self.autocapitalizationType isEqualToString:@"words"]) {
        textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    } else if([self.autocapitalizationType isEqualToString:@"sentences"]) {
        textField.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    }

    // sets the text field's return key type
    if([self.returnType isEqualToString:@"done"]) {
        textField.returnKeyType = UIReturnKeyDone;
    }

    // enables the clear button
    // in case the cell is clearable
    if(self.clearable) {
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
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

    // focuses on the text field in case
    // it should focus when entering edit mode
    if(self.focusEdit) {
        // makes the text field the first responder
        [self.textField becomeFirstResponder];
    }
}

- (void)hideEditing {
    // hides the keyboard
    [self.textField resignFirstResponder];

    // hides the text field
    self.textField.hidden = YES;

    // calls the super
    [super hideEditing];
}

- (void)blurEditing {
    // hides the keyboard
    [self.textField resignFirstResponder];

    // calls the super
    [super blurEditing];
}

- (void)persistEditing {
    // calls the super
    [super persistEditing];

    // sets the description from the text field
    self.description = self.textField.text;
}

- (void)rollbackEditing {
    // reverts the text view text field
    self.textField.text = self.description;

    // calls the super
    [super rollbackEditing];
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

    // disables editing in case
    // returning should do so
    if(self.returnDisablesEdit) {
        self.itemTableView.editing = NO;
    }

    // returns yes
    return YES;
}

- (void)setDescription:(NSString *)description {
    // calls the super
    [super setDescription:description];

    // in case the description is invalid
    if(description == nil) {
        // returns immediately
        return;
    }

    // in case the text field is defined
    if(self.textField) {
        // updates the text field text
        self.textField.text = description;
    }

    // masks the description if necessary
    if(self.secure == YES && description.length > 0) {
        // creates the secret value
        NSMutableString *secretValue = [[NSMutableString alloc] init];

        // iterates over the length of the description
        for(int index = 0; index < description.length && index < HM_COLUMN_STRING_TABLE_VIEW_CELL_PASSWORD_LENGTH; index++) {
            // adds the secret token to the secret value
            [secretValue appendString:@"•"];
        }

        // sets the detail text label text with the secret value
        self.descriptionLabel.text = secretValue;

        // releases the object
        [secretValue release];
    }
}

- (NSString *)descriptionTransient {
    return self.textField.text;
}

- (void)setDescriptionTransient:(NSString *)descriptionTransient {
    // sets the transient description in the text field
    self.textField.text = descriptionTransient;
}

@end
