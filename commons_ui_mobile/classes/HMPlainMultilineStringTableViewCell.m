// Hive Mobile
// Copyright (c) 2008-2018 Hive Solutions Lda.
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
// __copyright__ = Copyright (c) 2008-2018 Hive Solutions Lda.
// __license__   = Apache License, Version 2.0

#import "HMPlainMultilineStringTableViewCell.h"

@implementation HMPlainMultilineStringTableViewCell

@synthesize textView = _textView;
@synthesize returnDisablesEdit = _returnDisablesEdit;
@synthesize autocapitalizationType = _autocapitalizationType;

- (id)initWithReuseIdentifier:(NSString *)cellIdentifier {
    // invokes the parent constructor
    self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellIdentifier];

    // sets the default attributes
    self.persistentEdit = YES;

    // enables clips to bound to avoid overflow
    self.clipsToBounds = YES;

    // returns self
    return self;
}

- (void)dealloc {
    // releases the text view
    [_textView release];

    // releases the auto capitalization type
    [_autocapitalizationType release];

    // calls the super
    [super dealloc];
}

- (void)createEditing {
    // calls the super
    [super createEditing];

    // hides the text label
    self.descriptionLabel.hidden = YES;

    // creates the text view
    CGRect editViewFrame = self.editView.frame;
    CGRect textViewFrame = CGRectMake(0, HM_PLAIN_MULTILINE_STRING_TABLE_VIEW_CELL_Y_MARGIN, editViewFrame.size.width, self.height - HM_PLAIN_MULTILINE_STRING_TABLE_VIEW_CELL_Y_MARGIN);
    HPGrowingTextView *textView = [[HPGrowingTextView alloc] initWithFrame:textViewFrame];
    textView.delegate = self;
    textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    textView.font = self.descriptionLabel.font;
    textView.backgroundColor = [UIColor clearColor];
    textView.text = self.description;
    textView.editable = NO;
    textView.secureTextEntry = self.secure;

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
    // calls the super
    [super showEditing];

    // makes the text view editable
    self.textView.editable = YES;
}

- (void)hideEditing {
    // hides the keyboard
    [self.textView resignFirstResponder];

    // makes the text view not editable
    self.textView.editable = NO;

    // calls the super
    [super hideEditing];
}

- (void)blurEditing {
    // hides the keyboard
    [self.textView resignFirstResponder];

    // calls the super
    [super blurEditing];
}

- (void)persistEditing {
    // calls the super
    [super persistEditing];

    // sets the description from the text view
    self.description = self.textView.text;
}

- (void)rollbackEditing {
    // reverts the text view text value
    self.textView.text = self.description;

    // calls the super
    [super rollbackEditing];
}

- (void)flushEditing {
    // calls the super
    [super flushEditing];

    // flushes the size of the text view
    self.textView.text = self.textView.text;
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

- (void)growingTextViewDidBeginEditing:(HPGrowingTextView *)textView {
    // focuses the editing
    [self focusEditing];
}

- (void)growingTextViewDidEndEditing:(HPGrowingTextView *)textView {
    // blurs the editing
    [self blurEditing];
}

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height {
    // sets the item height
    self.item.height = height + HM_PLAIN_MULTILINE_STRING_TABLE_VIEW_CELL_EXTRA_CELL_HEIGHT;

    // updates the table data
    [self updateTableData];
}

- (void)growingTextViewWillBeginScroll:(HPGrowingTextView *)growingTextView {
    // increments the item height with the scroll padding
    self.item.height += HM_PLAIN_MULTILINE_STRING_TABLE_VIEW_CELL_EXTRA_SCROLL_MARGIN;

    // updates the table data
    [self updateTableData];
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
        for(int index = 0; index < description.length && index < HM_PLAIN_MULTILINE_STRING_TABLE_VIEW_CELL_PASSWORD_LENGTH; index++) {
            // adds the secret token to the secret value
            [secretValue appendString:@"•"];
        }

        // sets the secret value in the description label
        self.descriptionLabel.text = secretValue;

        // releases the object
        [secretValue release];
    }
}

- (NSString *)descriptionTransient {
    return self.textView.text;
}

- (void)setDescriptionTransient:(NSString *)descriptionTransient {
    self.textView.text = descriptionTransient;
}

@end
