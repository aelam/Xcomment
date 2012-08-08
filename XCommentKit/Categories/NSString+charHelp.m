//
//  NSString+charHelp.m
//  VIXcode
//
//  Created by Ryan Wang on 5/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
// /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.7.sdk/usr/include/ctype.h

#import "NSString+charHelp.h"


//BOOL iskeyword (unichar c);


@implementation NSString (charHelp)

- (NSString *)stringByTrimmingPrefixSpaces:(NSString **)prefixSpaces {
    NSMutableString *spaces = [NSMutableString string];
    int i = 0;
    for(i = 0;i < self.length;i++) {
        unichar c = [self characterAtIndex:i];
        if(c == ' ') {
            [spaces appendString:@" "];
        } else {
            break;
        }
    }
    *prefixSpaces = spaces;
    return [self substringFromIndex:i];
}

@end
