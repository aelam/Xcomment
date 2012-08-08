//
//  NSTextView+Actions.h
//  VIXcode
//
//  Created by Ryan Wang on 4/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSPosition.h"


@interface NSTextView (Actions)

- (void)cursorToLine:(NSUInteger)line;

- (void)cursorUp:(NSUInteger)count;
- (void)cursorDown:(NSUInteger)count;

- (void)cursorForward:(BOOL)flag count:(NSUInteger)count;

- (void)cursorWORDForward:(BOOL)flag count:(NSUInteger)count;
- (void)cursorwordForward:(BOOL)flag count:(NSUInteger)count;

- (void)moveCursorToPosition:(NSPosition)newPosition;

- (void)changeCaseOfLetter:(id)sender;

- (void)moveToBeginning;
- (void)moveToEnd;

- (void)scrollToCursor;


@end
