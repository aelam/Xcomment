//
//  NSString+Category.m
//  VIXcode
//
//  Created by Ryan Wang on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSString+LineRange.h"

typedef unichar (*charIMP)(id, SEL, unsigned);

@implementation NSString (LineRange)

- (NSUInteger) lineCount
{
    int         retval = 1;
    NSUInteger  i, iLimit = [self length];
    for (i = 0; i < iLimit; i++)
        if ([self characterAtIndex: i] == '\n')
            retval++;
    return retval;
}

- (NSRange) rangeOfLine: (NSUInteger)line
{
    NSRange         retval = { 0, 0 };
    NSUInteger      index, length = [self length];
    charIMP         charAtIndex = (charIMP) [self methodForSelector: @selector(characterAtIndex:)];
    
    //  First, seek the line
    for (index = 0; index < length && line > 0; index++) {
        if (charAtIndex(self, @selector(characterAtIndex:), index) == '\n')
            line--;
    }
    
    if (line > 0)
        return NSMakeRange(NSNotFound, 0);
    
    retval.location = index;
    
    for (; index < length; index++) {
        if (charAtIndex(self, @selector(characterAtIndex:), index) == '\n')
            break;
    }
    retval.length = index - retval.location;
    
    return retval;
}

- (NSRange) rangeOfLines: (NSRange) lines
{
    NSRange     firstRange = [self rangeOfLine: lines.location];
    if (firstRange.location == NSNotFound)
        return NSMakeRange(NSNotFound, 0);
    
    if (NSMaxRange(firstRange) < [self length] && [self characterAtIndex: NSMaxRange(firstRange)] == '\n')
        firstRange.length++;
    
    NSRange     lastRange = [self rangeOfLine: NSMaxRange(lines)-1];
    if (lastRange.location == NSNotFound)
        firstRange.length = [self length] - firstRange.location;
    else {
        if (NSMaxRange(lastRange) < [self length] && [self characterAtIndex: NSMaxRange(lastRange)] == '\n')
            lastRange.length++;
        firstRange.length = NSMaxRange(lastRange) - firstRange.location;
    }
    
    return firstRange;
}

/*
 123\n567\n\nAB
 */

- (NSPosition)positionOfLocation:(NSUInteger)index {
    
    int         lclRow = 0;
    int         lclColumn = 0;
    NSUInteger  i, limit = MIN(index, [self length]);
    unichar     ch = 0;
    
    for (i = 0; i < limit; i++) {
        ch = [self characterAtIndex: i];
        if (ch == '\n') {
            lclRow++;
            lclColumn = 0;
        }
        else
            lclColumn++;
    }
    
    return NSMakePosition(lclRow, lclColumn);
}


@end
