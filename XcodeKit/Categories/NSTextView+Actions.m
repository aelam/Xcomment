//
//  NSTextView+Actions.m
//  VIXcode
//
//  Created by Ryan Wang on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSTextView+Actions.h"
#import "NSTextView+Positions.h"

@implementation NSTextView (Actions)

- (void)changeCaseOfLetter:(id)sender {
    NIF_INFO();
}

- (void)cursorToLine:(NSUInteger)line {
    NSPosition currentPosition = [self positionOfLocation:[self insertionPoint]];
    if (line > currentPosition.row) {
        [self cursorDown:line - currentPosition.row];
    } else if (line < currentPosition.row) {
        [self cursorDown:currentPosition.row - line];
    }
    
}

- (void)cursorUp:(NSUInteger)count {
    NSPosition currentPosition = [self positionOfLocation:[self insertionPoint]];

    // stop cursor Up while cursor row is 0
    if (currentPosition.row == 0) {
        return;
    }
    
    NSUInteger descRow = MAX(0, currentPosition.row - count);
    
    NSRange descLineRange = [self rangeOfLine:descRow];
    
    NSUInteger descColumn = MIN(currentPosition.column,descLineRange.length);
    
    NSRange descRange = NSMakeRange(descLineRange.location + descColumn, 0);
    
    [self setSelectedRange:descRange];

    NIF_INFO(@"%@",NSStringFromRange(self.visibleRange));
    
    [self scrollToCursor];
    
}


- (void)cursorDown:(NSUInteger)count {
    NSPosition currentPosition = [self positionOfLocation:[self insertionPoint]];
    

    NSUInteger lineCount = [self lineCount];
    
    NIF_INFO(@"currentPosition : %@ line count : %lu ",NSStringFromPosition(currentPosition),lineCount);

    // stop cursor Up while cursor row is last line
    if (currentPosition.row >= lineCount-1) {
        NIF_INFO(@"LAST LINE");
        return;
    }
    
    NSUInteger descRow = MIN(lineCount, currentPosition.row + count);
    NIF_INFO(@"descRow ： %lu",descRow);
    NSRange descLineRange = [self rangeOfLine:descRow];

    NSUInteger descColumn = MIN(currentPosition.column,descLineRange.length);
    NIF_INFO(@"descColumn ： %lu",descColumn);
    NSRange descRange = NSMakeRange(descLineRange.location + descColumn, 0);

    [self setSelectedRange:descRange];

    [self scrollToCursor];

}

- (void)cursorForward:(BOOL)flag count:(NSUInteger)count {

    
    if (flag) {
        NSUInteger wantedLoc = self.insertionPoint - count;
        
        NSUInteger newLoc = ((NSInteger)wantedLoc)>=0?wantedLoc:0;
        
        NSRange newRange = NSMakeRange(newLoc,0);
        
        [self setSelectedRanges:[NSArray arrayWithObject:[NSValue valueWithRange:newRange]]];
        
    } else {
        
        NSUInteger wantedLoc = self.insertionPoint + count;
        
        NSUInteger newLoc = (NSUInteger)wantedLoc <=[[self string]length]?wantedLoc:[[self string]length];
        
        NSRange newRange = NSMakeRange(newLoc,0);
        
        [self setSelectedRanges:[NSArray arrayWithObject:[NSValue valueWithRange:newRange]]];
    }    
}

/**
 A word consists of a sequence of letters, digits and underscores, or a         
 sequence of other non-blank characters, separated with white space (spaces,    
 tabs, <EOL>).  This can be changed with the 'iskeyword' option.  An empty line 
 is also considered to be a word.                                               
 *WORD*                 
 A WORD consists of a sequence of non-blank characters, separated with white    
 space.  An empty line is also considered to be a WORD.  
 
 */
- (void)cursorWORDForward:(BOOL)flag count:(NSUInteger)count {
    if (flag) {
    } else {
        
    }
}

- (void)cursorwordForward:(BOOL)flag count:(NSUInteger)count {
    NSUInteger index = [self insertionPoint];
    NSUInteger j = [self currentCharIndex];
    NIF_INFO(@"insert Point : %lu charIndex : %lu",index,j);
    NSUInteger recordCount = count;
    
    for(NSUInteger i = index+1 ; i <= [[self string] length]; i++ ){
        unichar c = [self.string characterAtIndex:i];
        printf("%c",c);
        if (recordCount <= 0) {
            break;
        }
        if (i > 100) {
            break;
        }
    }
    
    NSUInteger nextWordIndex = [self.textStorage nextWordFromIndex:[self currentCharIndex] forward:flag];
    
    NSRange newRange = NSMakeRange(nextWordIndex,0);
    [self setSelectedRanges:[NSArray arrayWithObject:[NSValue valueWithRange:newRange]]];
    [self scrollToCursor];

}

/*

- (void)moveBackwardCharactersCount:(NSUInteger)count {
    
    NSUInteger wantedLoc = self.insertionPoint - count;

    NSUInteger newLoc = ((NSInteger)wantedLoc)>=0?wantedLoc:0;
    
    NSRange newRange = NSMakeRange(newLoc,0);
    
    [self setSelectedRanges:[NSArray arrayWithObject:[NSValue valueWithRange:newRange]]];
}

- (void)moveForwardCharactersCount:(NSUInteger)count {
    
    NSUInteger wantedLoc = self.insertionPoint + count;
    
    NSUInteger newLoc = (NSUInteger)wantedLoc <=[[self string]length]?wantedLoc:[[self string]length];
    
    NSRange newRange = NSMakeRange(newLoc,0);
    
    [self setSelectedRanges:[NSArray arrayWithObject:[NSValue valueWithRange:newRange]]];
}
 
*/

- (void)moveToBeginning {
    NSRange zeroRange = { 0, 0 };
    [self setSelectedRange: zeroRange];   
}

- (void)moveToEnd {
    NSRange range = { [[self string] length], 0 };
    [self setSelectedRange: range];
}

- (void)moveAndScrollToBeginning {
    NSRange range = { 0, 0 };
    [self setSelectedRange: range];
    [self scrollRangeToVisible: range];
}

- (void)moveAndScrollToEnd {
    NSRange range = { [[self string] length], 0 };
    [self setSelectedRange: range];
    [self scrollRangeToVisible: range];
}

- (void)scrollToCursor {    
    NSRect lineRect = [self lineRectForRange:[self currentLineRange]];
    
    NIF_INFO(@"currentLineRange - %@",NSStringFromRange([self currentLineRange]));
    NIF_INFO(@"lineRect - %@",NSStringFromRect(lineRect));
    NSRange r = [self.layoutManager glyphRangeForTextContainer:self.textContainer];
    NIF_INFO(@"glyphRangeForTextContainer - %@",NSStringFromRange(r));
    
    NSRect visibleRect = self.visibleRect;
    
    if (NSMaxY(lineRect) > NSMaxY(visibleRect)) {
        visibleRect.origin.y = NSMinY(visibleRect) + (NSMaxY(lineRect) - NSMaxY(visibleRect));
    } else if (NSMinY(lineRect) < NSMinY(visibleRect)) {
        visibleRect.origin.y = NSMinY(lineRect);
    } else {
        // Do nothing
    }
    [self scrollRectToVisible:visibleRect];  

    [self highlightCurrentLineReset:YES];
}

@end
