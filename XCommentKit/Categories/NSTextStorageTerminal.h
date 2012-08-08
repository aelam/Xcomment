//
//  NSTextStorageTerminal.h
//  Crescat
//
//  Created by Fritz Anderson on Thu Sep 18 2003.
//  Copyright (c) 2003 Trustees of the University of Chicago. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSAttributedString (attributedCharacter)

+ (id) stringWithCharacter: (unichar) ch attributes: (NSDictionary *) attrs;
+ (NSAttributedString *) spaceInFont: (NSFont *) aFont;
+ (NSAttributedString *) newlineInFont: (NSFont *) aFont;
+ (NSAttributedString *) newlineWithAttrs: (NSDictionary *) attrs;
+ (NSAttributedString *) spaceWithAttrs: (NSDictionary *) attrs;

- (NSString *) unicodeString;
- (NSAttributedString *) unicodeAttributedString;

@end

@interface NSMutableAttributedString (attrSubstitution)

- (void) replaceForegroundColor: (NSColor *) target withColor: (NSColor *) newColor;
- (void) replaceBackgroundColor: (NSColor *) target withColor: (NSColor *) newColor;
- (void) replaceFont: (NSFont *) target withFont: (NSFont *) newFont;

@end

@interface NSString (lineRange)

- (int) lineCount;
- (NSRange) rangeOfLine: (int) line;
- (NSRange) rangeOfLines:(NSRange)lines_;
- (void) index: (int) index atRow: (int *) row column: (int *) column;

@end

@interface NSTextStorage (terminalExtensions)

- (int) lineCount;
- (NSRange)rangeOfLine: (int) line;
- (NSRange)rangeOfLines:(NSRange)lines_;
- (void) index: (int) index atRow: (int *) row column: (int *) column;

- (NSAttributedString *) copyLines: (int) howMany atLine: (int) where;

- (int) ensureRow: (int) row hasColumn: (int) column;
- (int) ensureRow: (int) row hasColumn: (int) column withAttributes: (NSDictionary *) attrs;
- (void) insertCharacter: (unichar) ch atRow: (int) row column: (int) column;
- (void) replaceCharacter: (unichar) ch atRow: (int) row column: (int) column;
- (void) insertCharacter: (unichar) ch atRow: (int) row column: (int) column withAttributes: (NSDictionary *) attrs;
- (void) replaceCharacter: (unichar) ch atRow: (int) row column: (int) column withAttributes: (NSDictionary *) attrs;
- (void) insertLines: (int) howMany atLine: (int) where;
- (void) insertLines: (int) howMany atLine: (int) where withAttributes: (NSDictionary *) attrs;
- (void) deleteLines: (int) howMany atLine: (int) where;
- (void) eraseLinesFrom: (int) firstLine to: (int) notIncluded;

- (void) deleteCharacters: (int) howMany atRow: (int) row column: (int) column;
- (void) eraseCharacters: (int) howMany atRow: (int) row column: (int) column withAttributes: (NSDictionary *) attrs;

- (void) insertCharacters: (int) howMany atRow: (int) row column: (int) column;

- (void) insertString: (NSString *) aString atRow: (int) row column: (int) column withAttributes: (NSDictionary *) attrs;
- (void) placeString: (NSString *) aString atRow: (int) row column: (int) column withAttributes: (NSDictionary *) attrs;

- (void) deleteEndOfLineAtRow: (int) row column: (int) column;

- (unichar) characterAtRow: (int) row column: (int) column;

- (NSTextView *) textView;

- (NSRange) rangeOfFirstURLInRange: (NSRange) rangeToSearch;
- (NSRange) rangeOfFirstEmailInRange: (NSRange) rangeToSearch;
- (NSRange) rangeOfProperNameBeforeOffset: (unsigned) offset;

@end
