//
//  NSTextView+Positions.m
//  VIXcode
//
//  Created by Ryan Wang on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSTextView+Positions.h"
#import "NSString+LineRange.h"

@implementation NSTextView (CurrentLine)

- (NSUInteger)currentLineNumber {
    return [self positionOfLocation:self.insertionPoint].row;
}


- (NSRange)currentLineRange {
    return [self rangeOfLine:[self currentLineNumber]];
}

- (NSRange)currentWordRange {
    
    NSRange lineGlyphRange = [self currentLineRange];
    
    NSRange lineCharRange = [[self layoutManager] characterRangeForGlyphRange:lineGlyphRange actualGlyphRange:NULL];
    NSUInteger charIndex = [[self layoutManager] characterIndexForGlyphAtIndex:[self insertionPoint]];
    
    NSRange wordCharRange = NSIntersectionRange(lineCharRange, [self selectionRangeForProposedRange:NSMakeRange(charIndex, 0) granularity:NSSelectByWord]);
//    NIF_INFO(@"%@",NSStringFromRange(wordCharRange));
    return wordCharRange;
}

- (NSUInteger)currentCharIndex {
    return [self insertionPoint];
//    return [self.layoutManager characterIndexForGlyphAtIndex:[self insertionPoint]];
}

@end

@implementation NSTextView (Position)

- (NSUInteger)insertionPoint {
    return [[[self selectedRanges] objectAtIndex:0] rangeValue].location;
}

- (BOOL)isEndOfLine {

    return YES;    
}

- (BOOL)isBeginningOfLine {
    return YES;
}


- (NSRect)glyphRect {
    NSLayoutManager *layoutManager = [self layoutManager];
    NSTextContainer *textContainer = [self textContainer];

    return [layoutManager boundingRectForGlyphRange:NSMakeRange(self.insertionPoint, 1) inTextContainer:textContainer];
    
}

- (NSUInteger)lineCount {
    return [self.string lineCount];
}

- (NSRange)rangeOfLine:(NSUInteger)line {
    return [self.string rangeOfLine:line];
}

- (NSRange)rangeOfLines:(NSRange)lines_ {
    return [self.string rangeOfLines:lines_];
}

- (NSPosition)positionOfLocation:(NSUInteger)aLocation {
    return [self.string positionOfLocation:aLocation];
}


- (NSRange)visibleRange {
    NSRect visibleRect = [self visibleRect];
    NSLayoutManager *lm = [self layoutManager];
    NSTextContainer *tc = [self textContainer];
    
    NSRange glyphVisibleRange = [lm glyphRangeForBoundingRect:visibleRect inTextContainer:tc];
//    NIF_INFO(@"glyphVisibleRange = %@",NSStringFromRange(glyphVisibleRange));
    NSRange charVisibleRange = [lm characterRangeForGlyphRange:glyphVisibleRange  actualGlyphRange:nil];
//    NIF_INFO(@"charVisibleRange = %@",NSStringFromRange(charVisibleRange));
    return charVisibleRange;
}

- (unichar)characterAtPosition:(NSPosition)position {
    
    int row = position.row;
    int column = position.column;
    
    //  First ensure that there are enough rows
    NSString *   mString = [self string];
    unichar             ch;
    int                 i, iLimit = [mString length];
    
    //  after this loop, i should be the index of the first character of
    //  the row sought
    
    for (i = 0; i < iLimit && row > 0; i++) {
        ch = [mString characterAtIndex: i];
        if (ch == '\n')
            row--;
    }       
    
    if (row > 0) {
        return 0xffff;
    }
    
    //  i is the index of the first character of the row sought
    //  Now look for the \n at the end of the row
    
    for (; i < iLimit && column > 0; i++, column--) {
        ch = [mString characterAtIndex: i];
        if (ch == '\n')
            break;
    }
    
    if (column > 0 || [mString characterAtIndex: i] == '\n') {
        return 0xffff;
    }
    
    return [mString characterAtIndex: i];

}


- (NSRect)lineRectForRange:(NSRange)range {
    
    return [self.layoutManager boundingRectForGlyphRange:range inTextContainer:self.textContainer];;    
}

- (void)highlightCurrentLineReset:(BOOL)flag{
    NSLayoutManager *layoutManager = [self layoutManager];
    NSUInteger textLength = [[self textStorage] length];
    NSRange textCharRange = NSMakeRange(0, textLength);
    // Remove any existing coloring.
    
    if (flag) {
        [layoutManager removeTemporaryAttribute:NSBackgroundColorAttributeName forCharacterRange:textCharRange];        
    }
    
    // Color the characters using temporary attributes
    [layoutManager addTemporaryAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[NSColor cyanColor], NSBackgroundColorAttributeName, nil] forCharacterRange:[self currentLineRange]];
    [layoutManager addTemporaryAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[NSColor yellowColor], NSBackgroundColorAttributeName, nil] forCharacterRange:[self currentWordRange]];
    [layoutManager addTemporaryAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[NSColor magentaColor], NSBackgroundColorAttributeName, nil] forCharacterRange:NSMakeRange(self.currentCharIndex, 1)];
}


#pragma mark -
#pragma mark Test Case
- (void)testlineRectForRange {
    NIF_INFO(@"currentlineRectForRange2 %@",NSStringFromRect([self lineRectForRange:[self currentLineRange]]));
    
}



@end

