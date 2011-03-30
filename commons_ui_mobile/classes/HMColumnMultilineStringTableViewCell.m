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

#import "HMColumnMultilineStringTableViewCell.h"

@implementation HMColumnMultilineStringTableViewCell

@synthesize textView = _textView;
@synthesize returnDisablesEdit = _returnDisablesEdit;

- (void)dealloc {
    // releases the text view
    [_textView release];

    // calls the super
    [super dealloc];
}

- (void)changeEditing:(BOOL)editing commit:(BOOL)commit {
    // returns in case its in edit mode
    if(editing == YES) {
        return;
    }

    // commits the cell's value in
    // or restores it depending on
    // the commit flag
    if(commit == YES) {
        self.description = self.textView.text;
    } else {
        self.textView.text = self.description;
    }
}

- (void)createEditing {
    // calls the super
    [super createEditing];

    // hides the detail text label
    self.detailTextLabel.hidden = YES;

    // creates the text view
    CGRect editViewFrame = self.editView.frame;
    CGRect textViewFrame = CGRectMake(0, HM_COLUMN_MULTILINE_STRING_TABLE_VIEW_CELL_Y_MARGIN, editViewFrame.size.width, self.height - HM_COLUMN_MULTILINE_STRING_TABLE_VIEW_CELL_Y_MARGIN);
    UITextView *textView = [[UITextView alloc] initWithFrame:textViewFrame];
    textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    textView.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    textView.autocorrectionType = UITextAutocorrectionTypeNo;
    textView.backgroundColor = [UIColor clearColor];
    textView.text = self.description;
    textView.secureTextEntry = self.secure;
    textView.delegate = self;
    textView.editable = NO;

    // sets the text field's return key type
    if([self.returnType isEqualToString:@"done"]) {
        textView.returnKeyType = UIReturnKeyDone;
    }

    // adds the textfield as subview
    [self.editView addSubview:textView];

    // sets the attributes
    self.textView = textView;

    // releases the objects
    [textView release];
}

- (void)showEditing {
    // makes the text view editable
    self.textView.editable = YES;
}

- (void)hideEditing {
    // hides the keyboard
    [self.textView resignFirstResponder];

    // makes the text view not editable
    self.textView.editable = NO;
}

- (void)blurEditing {
    // hides the keyboard
    [self.textView resignFirstResponder];

    // calls the super
    [super blurEditing];
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
    self.textView.secureTextEntry = _secure;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    // focuses the editing
    [self focusEditing];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    // blurs the editing
    [self blurEditing];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    // hides the keyboard when
    // a newline is inserted
    if([text isEqualToString:@"\n"]) {
        // disables editing in case
        // returning should do so
        if(self.returnDisablesEdit) {
            self.itemTableView.editing = NO;
        }

        // hides the keyboard
        [self.textView resignFirstResponder];

        // returns no to avoid adding the newline
        return NO;
    }

    // returns yes to add the newline
    return YES;
}

- (void)setDescription:(NSString *)description {
    // calls the super
    [super setDescription:description];

    // in case the description is invalid
    if(description == nil || (NSNull *) description == [NSNull null]) {
        // returns immediately
        return;
    }

    // in case the text field is defined
    if(self.textView) {
        // updates the text field text
        self.textView.text = description;
    }

    // masks the description if necessary
    if(self.secure == YES && description.length > 0) {
        // creates the secret value
        NSMutableString *secretValue = [[NSMutableString alloc] init];

        // iterates over the length of the description
        for(int index = 0; index < description.length && index < HM_COLUMN_MULTILINE_STRING_TABLE_VIEW_CELL_PASSWORD_LENGTH; index++) {
            // adds the secret token to the secret value
            [secretValue appendString:@"•"];
        }

        // sets the detail text label text with the secret value
        self.detailTextLabel.text = secretValue;

        // releases the object
        [secretValue release];
    }
}

@end
