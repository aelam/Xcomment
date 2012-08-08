//
//  NSTextView+Positions.h
//  VIXcode
//
//  Created by Ryan Wang on 4/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSPosition.h"


@interface NSTextView (CurrentLine)

- (NSUInteger)currentLineNumber;
- (NSRange)currentLineRange;
- (NSRange)currentWordRange;
- (NSUInteger)currentCharIndex;

@end


@interface NSTextView (Position)

- (NSUInteger)insertionPoint;
- (BOOL)isEndOfLine;
- (BOOL)isBeginningOfLine;
- (NSRect)glyphRect;


// Fixed
- (NSRange)rangeOfLine:(NSUInteger)line;
- (NSPosition)positionOfLocation:(NSUInteger)aLocation;
- (NSUInteger)lineCount;
- (NSRange)rangeOfLines:(NSRange)lines_;
- (NSRange)visibleRange;

- (unichar)characterAtPosition:(NSPosition)position;

- (NSRect)lineRectForRange:(NSRange)aRange;

- (void)highlightCurrentLineReset:(BOOL)flag;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 
- (void)testlineRectForRange2;



@end
