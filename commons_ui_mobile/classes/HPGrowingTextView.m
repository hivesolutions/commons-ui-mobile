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

// __author__    = João Magalhães <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision$
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "HPGrowingTextView.h"
#import "HPTextViewInternal.h"

@implementation HPGrowingTextView
@synthesize internalTextView;
@synthesize delegate;

@synthesize text;
@synthesize font;
@synthesize textColor;
@synthesize textAlignment;
@synthesize selectedRange;
@synthesize editable;
@synthesize dataDetectorTypes;
@synthesize animateHeightChange;
@synthesize returnKeyType;

- (id)initWithFrame:(CGRect)frame {
    if((self = [super initWithFrame:frame])) {
        // Initialization code
        CGRect r = frame;
        r.origin.y = -10;
        r.origin.x = 0;

        // creates the internal text view
        internalTextView = [[HPTextViewInternal alloc] initWithFrame:r];
        internalTextView.delegate = self;
        internalTextView.scrollEnabled = NO;
        internalTextView.font = [UIFont fontWithName:@"Helvetica" size:15];
        internalTextView.contentInset = UIEdgeInsetsZero;
        internalTextView.textAlignment = UITextAlignmentLeft;
        internalTextView.showsHorizontalScrollIndicator = NO;
        internalTextView.backgroundColor = [UIColor clearColor];
        internalTextView.autocorrectionType = UITextAutocorrectionTypeNo;

        // adds the internal text view as sub view
        [self addSubview:internalTextView];

        UIView *internal = (UIView *)[[internalTextView subviews] objectAtIndex:0];
        minimumHeight = internal.frame.size.height;
        minNumberOfLines = 1;

        // sets the animate height change
        animateHeightChange = YES;

        // sets the maximum number of lines
        [self setMaxNumberOfLines:6];
    }

    // returns self
    return self;
}

- (void)flushSize {
    // size of content, so we can set the frame of self
    NSInteger newSizeHeight = internalTextView.contentSize.height;

    if(newSizeHeight < minimumHeight || !internalTextView.hasText) {
        // not smaller than minHeight
        newSizeHeight = minimumHeight;
    }

    if(internalTextView.frame.size.height != newSizeHeight) {
        if(newSizeHeight <= maximumHeight) {
            if(animateHeightChange){
                [UIView beginAnimations:@"slideDown" context:nil];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationDidStopSelector:@selector(growDidStop)];
                [UIView setAnimationBeginsFromCurrentState:YES];
            }

            if([delegate respondsToSelector:@selector(growingTextView:willChangeHeight:)]) {
                [delegate growingTextView:self willChangeHeight:newSizeHeight];
            }

            // internalTextView
            CGRect internalTextViewFrame = self.frame;
            internalTextViewFrame.size.height = newSizeHeight;
            self.frame = internalTextViewFrame;

            internalTextViewFrame.origin.y = 0;
            internalTextViewFrame.origin.x = 0;
            internalTextView.frame = internalTextViewFrame;

            // in case the height animations are set
            if(animateHeightChange) {
                // commits the animations
                [UIView commitAnimations];
            }
        } else if(internalTextView.frame.size.height < maximumHeight) {
            // internalTextView
            CGRect internalTextViewFrame = self.frame;
            internalTextViewFrame.size.height = maximumHeight;
            self.frame = internalTextViewFrame;

            internalTextViewFrame.origin.y = 0;
            internalTextViewFrame.origin.x = 0;
            internalTextView.frame = internalTextViewFrame;

            if([delegate respondsToSelector:@selector(growingTextView:willChangeHeight:)]) {
                [delegate growingTextView:self willChangeHeight:maximumHeight];
            }
        }

        // in case the new size height is greater or equal
        // to the maximum height
        if(newSizeHeight >= maximumHeight) {
            // in case the scroll is not enabled
            if(!internalTextView.scrollEnabled) {
                // sets the internal text view scroll
                // and flashes the scroll indicators (for visibility)
                internalTextView.scrollEnabled = YES;
                [internalTextView flashScrollIndicators];

                if([delegate respondsToSelector:@selector(growingTextViewWillBeginScroll:)]) {
                    [delegate growingTextViewWillBeginScroll:self];
                }
            }
        }
        // otherwise the new size is shrinking bellow
        // the maximum height
        else {
            // disbles the scroll enabled
            internalTextView.scrollEnabled = NO;

            if([delegate respondsToSelector:@selector(growingTextViewWillEndScroll:)]) {
                [delegate growingTextViewWillEndScroll:self];
            }
        }
    }

    // in case the delegate response to the selector
    if([delegate respondsToSelector:@selector(growingTextViewDidChange:)]) {
        // calls the growing textt view did change
        [delegate growingTextViewDidChange:self];
    }
}


- (void)sizeToFit {
    CGRect r = self.frame;
    r.size.height = minimumHeight;
    self.frame = r;
}

- (void)setFrame:(CGRect)aframe {
    CGRect r = aframe;
    r.origin.y = 0;
    r.origin.x = 0;
    internalTextView.frame = r;

    [super setFrame:aframe];
}

- (int)maxNumberOfLines {
    return maxNumberOfLines;
}

- (void)setMaxNumberOfLines:(int)n {
    UITextView *test = [[HPTextViewInternal alloc] init];
    test.font = internalTextView.font;
    test.hidden = YES;

    NSMutableString *newLines = [NSMutableString string];

    if(n == 1){
        [newLines appendString:@"-"];
    } else {
        for(int i = 1; i < n; i++){
            [newLines appendString:@"\n"];
        }
    }

    test.text = newLines;

    [self addSubview:test];

    maximumHeight = test.contentSize.height;
    maxNumberOfLines = n;

    [test removeFromSuperview];
    [test release];
}

- (int)minNumberOfLines {
    return minNumberOfLines;
}

- (void)setMinNumberOfLines:(int)m {
    UITextView *test = [[HPTextViewInternal alloc] init];
    test.font = internalTextView.font;
    test.hidden = YES;

    NSMutableString *newLines = [NSMutableString string];

    if(m == 1){
        [newLines appendString:@"-"];
    } else {
        for(int i = 1; i<m; i++){
            [newLines appendString:@"\n"];
        }
    }

    test.text = newLines;

    [self addSubview:test];

    minimumHeight = test.contentSize.height;

    [self sizeToFit];
    minNumberOfLines = m;

    [test removeFromSuperview];
    [test release];
}

- (void)textViewDidChange:(UITextView *)textView {
    // flushes the size of the text view
    [self flushSize];
}

- (void)growDidStop {
    if([delegate respondsToSelector:@selector(growingTextView:didChangeHeight:)]) {
        [delegate growingTextView:self didChangeHeight:self.frame.size.height];
    }
}

- (BOOL)resignFirstResponder {
    [super resignFirstResponder];
    return [internalTextView resignFirstResponder];
}

- (void)dealloc {
    // releases the internal text view
    [internalTextView release];

    // calls the super
    [super dealloc];
}

#pragma mark -
#pragma mark UITextView properties

- (void)setText:(NSString *)atext {
    internalTextView.text = atext;

    // flushes the size of the text view
    [self flushSize];
}

- (NSString*)text {
    return internalTextView.text;
}

- (void)setFont:(UIFont *)afont {
    internalTextView.font = afont;

    [self setMaxNumberOfLines:maxNumberOfLines];
    [self setMinNumberOfLines:minNumberOfLines];
}

- (UIFont *)font {
    return internalTextView.font;
}

- (void)setTextColor:(UIColor *)color {
    internalTextView.textColor = color;
}

- (UIColor *)textColor{
    return internalTextView.textColor;
}

- (void)setTextAlignment:(UITextAlignment)aligment {
    internalTextView.textAlignment = aligment;
}

- (UITextAlignment)textAlignment {
    return internalTextView.textAlignment;
}

- (void)setScrollEnabled:(BOOL)scrollEnabled {
    internalTextView.scrollEnabled = scrollEnabled;
}

- (BOOL)isScrollEnabled {
    return internalTextView.scrollEnabled;
}

- (void)setSelectedRange:(NSRange)range {
    internalTextView.selectedRange = range;
}

- (NSRange)selectedRange {
    return internalTextView.selectedRange;
}

- (void)setEditable:(BOOL)beditable {
    internalTextView.editable = beditable;
}

- (BOOL)isEditable {
    return internalTextView.editable;
}

- (void)setSecureTextEntry:(BOOL)bsecureTextEntry {
    internalTextView.secureTextEntry = bsecureTextEntry;
}

- (BOOL)secureTextEntry {
    return internalTextView.secureTextEntry;
}

- (void)setReturnKeyType:(UIReturnKeyType)keyType {
    internalTextView.returnKeyType = keyType;
}

- (UIReturnKeyType)returnKeyType {
    return internalTextView.returnKeyType;
}

-(void)setDataDetectorTypes:(UIDataDetectorTypes)datadetector {
    internalTextView.dataDetectorTypes = datadetector;
}

-(UIDataDetectorTypes)dataDetectorTypes {
    return internalTextView.dataDetectorTypes;
}

- (BOOL)hasText {
    return [internalTextView hasText];
}

- (void)scrollRangeToVisible:(NSRange)range {
    [internalTextView scrollRangeToVisible:range];
}

#pragma mark -
#pragma mark UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if([delegate respondsToSelector:@selector(growingTextViewShouldBeginEditing:)]) {
        return [delegate growingTextViewShouldBeginEditing:self];
    } else {
        return YES;
    }
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if([delegate respondsToSelector:@selector(growingTextViewShouldEndEditing:)]) {
        return [delegate growingTextViewShouldEndEditing:self];

    } else {
        return YES;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if([delegate respondsToSelector:@selector(growingTextViewDidBeginEditing:)]) {
        [delegate growingTextViewDidBeginEditing:self];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if([delegate respondsToSelector:@selector(growingTextViewDidEndEditing:)]) {
        [delegate growingTextViewDidEndEditing:self];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)atext {
    // weird 1 pixel bug when clicking backspace when textView is empty
    if(![textView hasText] && [atext isEqualToString:@""]) return NO;

    if([atext isEqualToString:@"\n"]) {
        if([delegate respondsToSelector:@selector(growingTextViewShouldReturn:)]) {
            if(![delegate performSelector:@selector(growingTextViewShouldReturn:) withObject:self]) {
                return YES;
            } else {
                [textView resignFirstResponder];
                return NO;
            }
        }
    }

    return YES;
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    if([delegate respondsToSelector:@selector(growingTextViewDidChangeSelection:)]) {
        [delegate growingTextViewDidChangeSelection:self];
    }
}

@end
