//
//  NSString+Category.h
//  VIXcode
//
//  Created by Ryan Wang on 4/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSPosition.h"

@interface NSString (LineRange)

- (NSUInteger)lineCount;
- (NSRange)rangeOfLine:(NSUInteger)line;
- (NSRange)rangeOfLines:(NSRange)lines_;

- (NSPosition)positionOfLocation:(NSUInteger)aLocation;


@end